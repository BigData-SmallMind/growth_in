part of 'switch_account_company_cubit.dart';

class SwitchAccountCompanyState extends Equatable {
  const SwitchAccountCompanyState({
    this.companyChoiceStatus = CompanyChoiceStatus.initial,
    this.companyBeingSelected,
    this.user,
    this.error,
  });

  final CompanyChoiceStatus companyChoiceStatus;
  final Company? companyBeingSelected;
  final User? user;
  final dynamic error;

  SwitchAccountCompanyState copyWith({
    CompanyChoiceStatus? companyChoiceStatus,
    Company? companyBeingSelected,
    User? user,
    dynamic error,
  }) {
    return SwitchAccountCompanyState(
      companyChoiceStatus: companyChoiceStatus ?? this.companyChoiceStatus,
      companyBeingSelected: companyBeingSelected ?? this.companyBeingSelected,
      user: user ?? this.user,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        companyChoiceStatus,
        companyBeingSelected,
        user,
        error,
      ];
}

enum CompanyChoiceStatus {
  initial,
  inProgress,
  success,
  failure;
}
