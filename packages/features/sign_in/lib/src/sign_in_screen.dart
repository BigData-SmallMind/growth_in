import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:sign_in/sign_in.dart';
import 'package:sign_in/src/components/components.dart';
import 'package:sign_in/src/sign_in_cubit.dart';
import 'package:user_repository/user_repository.dart';
import 'package:function_and_extension_library/function_and_extension_library.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({
    required this.userRepository,
    required this.onForgotPasswordTapped,
    required this.onSignInSuccess,
    super.key,
  });

  final UserRepository userRepository;
  final VoidCallback onForgotPasswordTapped;
  final VoidCallback onSignInSuccess;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (_) => SignInCubit(
        userRepository: widget.userRepository,
        onForgotPasswordTapped: widget.onForgotPasswordTapped,
        onSignInSuccess: widget.onSignInSuccess,
      ),
      child: const SignInView(),
    );
  }
}

class SignInView extends StatelessWidget {
  const SignInView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.releaseFocus(),
      child: const _SignInForm(),
    );
  }
}

class _SignInForm extends StatelessWidget {
  const _SignInForm();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(
      listenWhen: (oldState, newState) =>
          oldState.submissionStatus != newState.submissionStatus,
      listener: (context, state) {
        final l10n = SignInLocalizations.of(context);

        if (state.submissionStatus == FormzSubmissionStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.generalErrorSnackBarMessage,
            ),
          );
          return;
        }
      },
      builder: (context, state) {
        final textTheme = Theme.of(context).textTheme;
        final theme = GrowthInTheme.of(context);
        final l10n = SignInLocalizations.of(context);
        final companyChoiceInProgress =
            !(state.companyChoiceStatus == CompanyChoiceStatus.initial);
        return BlocBuilder<SignInCubit, SignInState>(
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(horizontal: theme.screenMargin),
                    children: <Widget>[
                      const Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: SvgAsset(AssetPathConstants.logoPath),
                      ),
                      VerticalGap.xxLarge(),
                      if (companyChoiceInProgress) const SelectCompany(),
                      if (!companyChoiceInProgress) ...[
                        Text(
                          l10n.signInGreetingTitle,
                          style: textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        VerticalGap.xLarge(),
                        if (!state.rememberMeLoading) ...[
                          const EmailTextField(),
                          VerticalGap.mediumLarge(),
                          const PasswordTextField(),
                          VerticalGap.medium(),
                        ],
                        const RememberMeAndForgotPassword(),
                        VerticalGap.xLarge(),
                        const SignInButton(),
                        VerticalGap.large(),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

