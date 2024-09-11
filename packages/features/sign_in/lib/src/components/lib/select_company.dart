import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in/sign_in.dart';
import 'package:sign_in/src/sign_in_cubit.dart';

class SelectCompany extends StatelessWidget {
  const SelectCompany({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = GrowthInTheme.of(context);
    final l10n = SignInLocalizations.of(context);
    return BlocConsumer<SignInCubit, SignInState>(
      listenWhen: (oldState, newState) =>
          oldState.companyChoiceStatus != newState.companyChoiceStatus,
      listener: (context, state) {
        if (state.companyChoiceStatus == CompanyChoiceStatus.success) {
          final cubit = context.read<SignInCubit>();

          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              message: l10n.signInSuccessSnackBarMessage,
              marginalSpace: EdgeInsets.only(
                bottom: 80,
                left: theme.screenMargin,
                right: theme.screenMargin,
              ),
            ),
          );
          cubit.onSignInSuccess();
        }
        if (state.companyChoiceStatus == CompanyChoiceStatus.failure) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.generalErrorSnackBarMessage,
            ),
          );
        }
      },
      builder: (context, state) {
        final submissionInProgress = state.companyChoiceStatus ==
            CompanyChoiceStatus.remoteSubmissionInProgress;
        final cubit = context.read<SignInCubit>();
        return Column(
          children: [
            Container(
              height: 400,
              padding: const EdgeInsets.only(
                top: Spacing.large,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: theme.borderColor,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    l10n.chooseCompanyTitle,
                    style: textTheme.titleMedium,
                  ),
                  VerticalGap.large(),
                  const Divider(),
                  VerticalGap.large(),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final company = state.user!.companies[index];
                        final isLoading = submissionInProgress &&
                            state.companyBeingSelected?.id == company.id;
                        return CompanyTile(
                          company: company,
                          isLoading: isLoading,
                          isSubmissionInProgress: submissionInProgress,
                          onCompanySelected: cubit.onCompanySelected,
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: state.user!.companies.length,
                    ),
                  )
                ],
              ),
            ),
            VerticalGap.large(),
            Text(
              l10n.chooseCompanyHintText,
              textAlign: TextAlign.center,
              style:
                  textTheme.titleMedium?.copyWith(color: theme.dimmedTextColor),
            ),
          ],
        );
      },
    );
  }
}
