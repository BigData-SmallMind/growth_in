import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';

import 'package:user_repository/user_repository.dart';

part 'send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  SendOtpCubit({
    required this.userRepository,
  }) : super(
          const SendOtpState(),
        );

  final UserRepository userRepository;

  void onEmailChanged(String newValue) {
    final previousScreenState = state;
    final previousPhoneState = previousScreenState.email;
    final shouldValidate = previousPhoneState.isNotValid;
    final newPhoneState = shouldValidate
        ? Email.validated(
            newValue,
            isRequired: true,
          )
        : Email.unvalidated(
            newValue,
          );

    final newScreenState = state.copyWith(
      email: newPhoneState,
    );

    emit(newScreenState);
  }

  void onEmailUnfocused() {
    final newScreenState = state.copyWith(
      email: Email.validated(
        state.email.value,
        isRequired: true,
        isNotRegistered: state.email.isNotRegistered,
      ),
    );
    emit(newScreenState);
  }

  void onSubmit() async {
    final email = Email.validated(
      state.email.value,
      isRequired: true,
    );

    final isFormValid = Formz.validate([
      email,
    ]);

    final newState = state.copyWith(
      email: email,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      try {
        await userRepository.sendOtp(email.value!);
        final otpVerification = OtpVerification(
          email: email.value!,
          reason: OtpVerificationReason.resetPassword,
        );
        userRepository.changeNotifier.setOtpVerification(otpVerification);
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          email: Email.validated(
            email.value,
            isRequired: true,
            isNotRegistered:
                error is EmailNotRegisteredException ? true : false,
          ),
          submissionStatus: error is! EmailNotRegisteredException
              ? FormzSubmissionStatus.failure
              : FormzSubmissionStatus.initial,
        );
        emit(newState);
      }
    }
  }
}
