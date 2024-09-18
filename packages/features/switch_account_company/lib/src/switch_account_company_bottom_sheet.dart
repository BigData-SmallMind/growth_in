import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:switch_account_company/src/l10n/switch_account_company_localizations.dart';
import 'package:switch_account_company/src/switch_account_company_cubit.dart';
import 'package:user_repository/user_repository.dart';

class SwitchAccountCompanyBottomSheet extends StatelessWidget {
  const SwitchAccountCompanyBottomSheet({
    required this.userRepository,
    super.key,
  });

  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwitchAccountCompanyCubit>(
      create: (_) => SwitchAccountCompanyCubit(
        userRepository: userRepository,
      ),
      child: const SwitchAccountCompanyView(),
    );
  }
}

class SwitchAccountCompanyView extends StatelessWidget {
  const SwitchAccountCompanyView({super.key,});

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final l10n = SwitchAccountCompanyLocalizations.of(context);
    return BlocConsumer<SwitchAccountCompanyCubit, SwitchAccountCompanyState>(
      listener: (context, state) {
        if (state.error is CompanyNotAssociatedException) {
          showSnackBar(
            context: context,
            snackBar: ErrorSnackBar(
              context: context,
              message: l10n.companyNotAssociatedErrorSnackBarMessage,
            ),
          );
        }
        if (state.companyChoiceStatus == CompanyChoiceStatus.success) {
          // if (true) {
          Navigator.pop(context);
          showSnackBar(
            context: context,
            snackBar: SuccessSnackBar(
              context: context,
              marginalSpace: EdgeInsets.only(
                bottom: Spacing.huge,
                left: theme.screenMargin,
                right: theme.screenMargin,
              ),
              message: l10n.companySwitchedSuccessSnackBarMessage,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<SwitchAccountCompanyCubit>();
        final submissionInProgress =
            state.companyChoiceStatus == CompanyChoiceStatus.inProgress;
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) => state.user == null
              ? const CenteredCircularProgressIndicator()
              : ListView.separated(
                  controller: scrollController,
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
        );
      },
    );
  }
}
