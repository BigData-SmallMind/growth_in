import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_details/src/l10n/request_details_localizations.dart';
import 'package:request_details/src/request_details_cubit.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({
    super.key,
    required this.onProfileInfoTapped,
    required this.onChangePasswordTapped,
    required this.onChangeEmailTapped,
  });

  final VoidCallback onProfileInfoTapped;
  final VoidCallback onChangePasswordTapped;
  final VoidCallback onChangeEmailTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestDetailsCubit>(
      create: (_) => RequestDetailsCubit(
        onProfileInfoTapped: onProfileInfoTapped,
        onChangePasswordTapped: onChangePasswordTapped,
        onChangeEmailTapped: onChangeEmailTapped,
      ),
      child: const RequestDetailsView(),
    );
  }
}

class RequestDetailsView extends StatelessWidget {
  const RequestDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final isTablet = !View.of(context).isSmallTabletOrLess;

    return BlocBuilder<RequestDetailsCubit, RequestDetailsState>(
      builder: (context, state) {
        final theme = GrowthInTheme.of(context);
        final l10n = RequestDetailsLocalizations.of(context);
        final textTheme = Theme.of(context).textTheme;
        final request = state.request;
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: l10n.appBarTitle,
          ),
          body: ListView(
            children: [
              Row(
                children: [
                  HorizontalGap.custom(theme.screenMargin),
                  Text(request!.name),
                  Spacer(),
                  IconButton(
                    icon: SvgAsset(
                      request.isComplete
                          ? AssetPathConstants.markAsCompleteActivePath
                          : AssetPathConstants.markAsCompletePath,
                      width: 40,
                      height: 40,
                    ),
                    onPressed: () {},
                  ),
                  HorizontalGap.custom(theme.screenMargin),
                ],
              ),
              VerticalGap.medium(),
              Divider(),
              VerticalGap.medium(),
              Row(
                children: [
                  HorizontalGap.custom(theme.screenMargin),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l10n.deadlineSectionTitle),
                      VerticalGap.small(),
                      Text(l10n.serviceNameSectionTitle),
                    ],
                  ),
                  HorizontalGap.medium(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DateAndTimeWidget(
                        date: request.deadline,
                        dateOnly: true,
                        textColor: Colors.red,
                      ),
                      VerticalGap.small(),
                      Text(request.serviceName),
                    ],
                  ),
                ],
              ),
              VerticalGap.medium(),
              Divider(),
              VerticalGap.medium(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
                child: Text(l10n.descriptionSectionTitle),
              ),
              VerticalGap.small(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
                child: Text(
                  request.details! * 20,
                  style: textTheme.bodySmall?.copyWith(
                    color: Color(0xFF636262),
                  ),
                ),
              ),
              VerticalGap.medium(),
              Divider(),
              VerticalGap.medium(),
              Row(
                children: [
                  HorizontalGap.custom(theme.screenMargin),
                  Text(l10n.actionsSectionTitle),
                  Spacer(),
                  TextButton(
                    child: Text(
                      l10n.viewAllActionsButtonLabel,
                      style: textTheme.bodySmall?.copyWith(
                        color: theme.primaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {},
                  ),
                  HorizontalGap.custom(theme.screenMargin),
                ],
              ),
              VerticalGap.medium(),
              Container(
                height: 100,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
                  separatorBuilder: (context, index) =>
                      HorizontalGap.custom(theme.screenMargin),
                  scrollDirection: Axis.horizontal,
                  itemCount: request.actions.length,
                  itemBuilder: (context, index) {
                    final action = request.actions[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.actionTitle + ' ' + (index + 1).toString(),
                          style: textTheme.bodySmall?.copyWith(
                            color: Color(0xFFADADAD),
                          ),
                        ),
                        VerticalGap.small(),
                        Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width -
                              (2 * theme.screenMargin),
                          padding: EdgeInsets.all(Spacing.small),
                          decoration: BoxDecoration(
                            color: action.isComplete
                                ? theme.primaryColor.withOpacity(0.1)
                                : Color(0xFFF7F8F9),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: action.isComplete
                                  ? theme.primaryColor
                                  : theme.borderColor,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgAsset(AssetPathConstants.taskPath),
                              HorizontalGap.small(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width -
                                        (5 * theme.screenMargin),
                                    child: Text(
                                      action.description * 10,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    l10n.percentActionsComplete +
                                        ' (' +
                                        '${action.completeStepsCount}/${action.steps.length}' +
                                        ')',
                                    style: textTheme.bodySmall?.copyWith(
                                      color: Color(0xFF797979),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              ...[
                VerticalGap.medium(),
                Divider(),
                VerticalGap.medium(),
                // comments
                Row(
                  children: [
                    HorizontalGap.custom(theme.screenMargin),
                    Text(l10n.commentsSectionTitle),
                    Spacer(),
                    TextButton(
                      child: Text(
                        l10n.viewAllCommentsButtonLabel,
                        style: textTheme.bodySmall?.copyWith(
                          color: theme.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onPressed: () {},
                    ),
                    HorizontalGap.custom(theme.screenMargin),
                  ],
                ),
                VerticalGap.medium(),
              ]
            ],
          ),
        );
      },
    );
  }
}
