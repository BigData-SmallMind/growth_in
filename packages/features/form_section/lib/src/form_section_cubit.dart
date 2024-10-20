import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

part 'form_section_state.dart';

class FormSectionCubit extends Cubit<FormSectionState> {
  FormSectionCubit({
    required this.userRepository,
  }) : super(const FormSectionState()) {
    fetchFormSection();
  }

  final UserRepository userRepository;

  void fetchFormSection() async {
    final loading = state.copyWith(
        formSectionFetchingStatus: FormSectionFetchingStatus.loading);
    emit(loading);
    try {
      final formSections = await userRepository.getFormSections(formId);
      final formSection = formSections.firstWhere(
        (element) => element.id == formSectionId,
        orElse: () => FormSection(
          id: 0,
          name: '',
          questions: [],
        ),
      );
      final success = state.copyWith(
        formSection: formSection,
        formSectionFetchingStatus: FormSectionFetchingStatus.success,
      );
      emit(success);
    } catch (e) {
      final error = state.copyWith(
          formSectionFetchingStatus: FormSectionFetchingStatus.error);
      emit(error);
    }
// @override
// Future<void> close() {
//   requestRepository.changeNotifier.clearRequest();
//   return super.close();
// }
  }
}
