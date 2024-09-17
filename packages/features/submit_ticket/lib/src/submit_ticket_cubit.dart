import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

part 'submit_ticket_state.dart';

class SubmitTicketCubit extends Cubit<SubmitTicketState> {
  SubmitTicketCubit({
    required this.userRepository,
  }) : super(const SubmitTicketState()) {
    getTicketsTypes();
  }

  final UserRepository userRepository;

  Future getTicketsTypes() async {
    try {
      final ticketsTypes = await userRepository.getTicketsTypes();
      final successState = state.copyWith(
        ticketsTypes: ticketsTypes,
      );
      emit(successState);
    } catch (_) {
      rethrow;
    }
  }

  Future onTypeChanged(TicketType? newValue) async {
    final isAlreadySelected = state.type.value == newValue;
    final newState = state.copyWith(
      type: isAlreadySelected
          ? Dynamic<TicketType?>.unvalidated()
          : Dynamic<TicketType?>.validated(
              newValue,
              isRequired: true,
            ),
    );
    emit(newState);
  }

  Future onTitleChanged(String newValue) async {
    final newState = state.copyWith(
      ticketTitle: Dynamic<String>.validated(
        newValue,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  Future onTitleUnfocused() async {
    final newState = state.copyWith(
      ticketTitle: Dynamic<String>.validated(
        state.title.value,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  Future onDescriptionChanged(String newValue) async {
    final newState = state.copyWith(
      ticketDescription: Dynamic<String>.validated(
        newValue,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  Future onDescriptionUnfocused() async {
    final newState = state.copyWith(
      ticketDescription: Dynamic<String>.validated(
        state.description.value,
        isRequired: true,
      ),
    );
    emit(newState);
  }

  void onSubmit() async {
    final problemType = Dynamic<TicketType?>.validated(
      state.type.value,
      isRequired: true,
    );
    final ticketTitle = Dynamic<String>.validated(
      state.title.value,
      isRequired: true,
    );
    final ticketDescription = Dynamic<String>.validated(
      state.description.value,
      isRequired: true,
    );

    final isFormValid = Formz.validate([
      problemType,
      ticketTitle,
      ticketDescription,
    ]);

    final newState = state.copyWith(
      type: problemType,
      ticketTitle: ticketTitle,
      ticketDescription: ticketDescription,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await userRepository.submitTicket(
          ticketType: problemType.value!,
          ticketTitle: ticketTitle.value!,
          ticketDescription: ticketDescription.value!,
        );
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.failure,
        );
        emit(newState);
      }
    }
  }
// @override
// Future<void> close() {
//   return super.close();
// }
}
