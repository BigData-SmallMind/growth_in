import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms/src/forms_cubit.dart';
import 'package:forms/src/l10n/forms_localizations.dart';
import 'package:user_repository/user_repository.dart';

class FormsScreen extends StatelessWidget {
  const FormsScreen({
    super.key,
    required this.userRepository,
    required this.imageDownloadUrl,
    required this.onFormTapped,
  });

  final UserRepository userRepository;
  final String imageDownloadUrl;
  final ValueSetter<int> onFormTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FormsCubit>(
      create: (_) => FormsCubit(
        imageDownloadUrl: imageDownloadUrl,
        userRepository: userRepository,
        onFormTapped: onFormTapped,
      ),
      child: const FormsView(),
    );
  }
}

class FormsView extends StatelessWidget {
  const FormsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FormsCubit, FormsState>(
      builder: (context, state) {
        final l10n = FormsLocalizations.of(context);
        final loading =
            state.formsFetchingStatus == FormsFetchingStatus.loading;
        final error = state.formsFetchingStatus == FormsFetchingStatus.error;
        final theme = GrowthInTheme.of(context);
        final textTheme = Theme.of(context).textTheme;
        final hasNoForms = state.forms?.list.isEmpty == true &&
            state.forms?.previous.isEmpty == true;
        final cubit = context.read<FormsCubit>();
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: Text(l10n.appBarTitle),
          ),
          body: loading
              ? const CenteredCircularProgressIndicator()
              : error || hasNoForms
                  ? ExceptionIndicator(
                      onTryAgain: () => context.read<FormsCubit>().fetchForms(),
                      message: hasNoForms ? l10n.noFormsErrorMessage : null,
                      title: hasNoForms ? l10n.noFormsErrorTitle : null,
                    )
                  : ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                      children: [
                        if (state.forms!.list.isNotEmpty) ...[
                          Text(
                            l10n.incompleteFormsSectionTitle,
                            style: textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          VerticalGap.small(),
                          ColumnBuilder(
                            itemCount: state.forms!.list.length,
                            itemBuilder: (context, index) {
                              final form = state.forms!.list[index];
                              return Column(
                                children: [
                                  FormCard(
                                    form: form,
                                    onFormTapped: () =>
                                        cubit.onFormTapped(form.id),
                                  ),
                                  VerticalGap.medium(),
                                ],
                              );
                            },
                          ),
                        ],
                        if (state.forms!.previous.isNotEmpty) ...[
                          VerticalGap.large(),
                          const Divider(),
                          VerticalGap.large(),
                          Text(
                            l10n.previousFormsSectionTitle,
                            style: textTheme.bodyMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          VerticalGap.small(),
                          ColumnBuilder(
                            itemCount: state.forms!.previous.length,
                            itemBuilder: (context, index) {
                              final form = state.forms!.previous[index];
                              return FormCard(
                                form: form,
                                onFormTapped: () => cubit.onFormTapped(form.id),
                              );
                            },
                          ),
                        ]
                      ],
                    ),
        );
      },
    );
  }
}

class FormCard extends StatelessWidget {
  const FormCard({
    super.key,
    required this.form,
    required this.onFormTapped,
  });

  final FormDM form;
  final VoidCallback onFormTapped;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final theme = GrowthInTheme.of(context);
    final l10n = FormsLocalizations.of(context);

    return GestureDetector(
      onTap: onFormTapped,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: theme.secondaryColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalGap.small(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HorizontalGap.custom(theme.screenMargin),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      form.name,
                      style: textTheme.titleMedium,
                    ),
                    VerticalGap.medium(),
                    Text(form.services.first.name),
                    VerticalGap.medium(),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: theme.secondaryColor,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: theme.secondaryColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: Spacing.small),
              child: Center(
                child: Row(
                  children: [
                    HorizontalGap.custom(theme.screenMargin),
                    Expanded(
                      child: Text(
                        l10n.waitingToCompleteFormText,
                        style: textTheme.bodyMedium?.copyWith(
                          color: theme.materialThemeData.colorScheme.surface,
                        ),
                      ),
                    ),
                    Text(
                      '${form.totalAnsweredQuestions}/${form.totalQuestions}',
                      style: textTheme.bodyMedium?.copyWith(
                        color: theme.materialThemeData.colorScheme.surface,
                      ),
                    ),
                    HorizontalGap.custom(theme.screenMargin),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
