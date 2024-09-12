import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

part 'switch_account_company_state.dart';

class SwitchAccountCompanyCubit extends Cubit<SwitchAccountCompanyState> {
  SwitchAccountCompanyCubit({
    required this.userRepository,
  }) : super(const SwitchAccountCompanyState()) {
    userRepository
        .getUser()
        .first
        .then((user) {
      emit(state.copyWith(user: user));
    });
  }

  final UserRepository userRepository;

  Future onCompanySelected(Company company) async {
    final selectedSameCompany = company.id ==
        state.user!
            .companies
            .firstWhere((element) => element.isSelected)
            .id;
    if (selectedSameCompany) return;

    final companyRemoteSelectionInProgress = state.copyWith(
      companyBeingSelected: company,
      companyChoiceStatus: CompanyChoiceStatus.inProgress,
    );
    emit(companyRemoteSelectionInProgress);
    try {
      await userRepository.switchAccountCompany(companyId: company.id);
      final companySelectionSuccess = state.copyWith(
        companyChoiceStatus: CompanyChoiceStatus.success,
      );
      emit(companySelectionSuccess);
    } catch (error) {
      final companySelectionFailure = state.copyWith(
        companyChoiceStatus: CompanyChoiceStatus.failure,
        error: error,
      );
      emit(companySelectionFailure);
      rethrow;
    }
  }

// @override
// Future<void> close() {
//   return super.close();
// }
}
