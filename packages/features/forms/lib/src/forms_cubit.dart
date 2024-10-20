import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'forms_state.dart';

class FormsCubit extends Cubit<FormsState> {
  FormsCubit({
    required this.userRepository,
  }) : super(const FormsState()) {
    fetchForms();
  }

  final UserRepository userRepository;

  void fetchForms() async {
    final loading =
        state.copyWith(formsFetchingStatus: FormsFetchingStatus.loading);
    emit(loading);
    try {
      final forms = await userRepository.getForms();
      final success = state.copyWith(
        forms: forms,
        formsFetchingStatus: FormsFetchingStatus.success,
      );
      emit(success);
    } catch (e) {
      final error =
          state.copyWith(formsFetchingStatus: FormsFetchingStatus.error);
      emit(error);
    }
// @override
// Future<void> close() {
//   requestRepository.changeNotifier.clearRequest();
//   return super.close();
// }
  }
}
