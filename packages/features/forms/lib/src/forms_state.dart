part of 'forms_cubit.dart';

class FormsState extends Equatable {
  const FormsState({
    this.forms,
    this.formsFetchingStatus = FormsFetchingStatus.initial,
  });

  final FormsDM? forms;
  final FormsFetchingStatus formsFetchingStatus;

  FormsState copyWith({
    FormsDM? forms,
    FormsFetchingStatus? formsFetchingStatus,
  }) {
    return FormsState(
      forms: forms ?? this.forms,
      formsFetchingStatus: formsFetchingStatus ?? this.formsFetchingStatus,
    );
  }

  @override
  List<Object?> get props => [
        forms,
        formsFetchingStatus,
      ];
}

enum FormsFetchingStatus {
  initial,
  loading,
  success,
  error,
}
