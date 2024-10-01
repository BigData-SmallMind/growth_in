import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_details/src/components/request_actions.dart';
import 'package:request_details/src/components/request_comments.dart';
import 'package:request_details/src/l10n/request_details_localizations.dart';
import 'package:request_details/src/request_details_cubit.dart';
import 'package:request_repository/request_repository.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({
    super.key,
    required this.requestRepository,
    required this.onProfileInfoTapped,
    required this.onChangePasswordTapped,
    required this.onChangeEmailTapped,
    required this.requestId,
  });

  final RequestRepository requestRepository;
  final VoidCallback onProfileInfoTapped;
  final VoidCallback onChangePasswordTapped;
  final VoidCallback onChangeEmailTapped;
  final int requestId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestDetailsCubit>(
      create: (_) => RequestDetailsCubit(
        requestRepository: requestRepository,
        requestId: requestId,
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
        final loading =
            state.requestFetchingStatus == RequestFetchingStatus.loading;
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: l10n.appBarTitle,
          ),
          body: loading
              ? const CenteredCircularProgressIndicator()
              : ListView(
                  children: [
                    Row(
                      children: [
                        HorizontalGap.custom(theme.screenMargin),
                        Text(request!.name),
                        Spacer(),
                        IconButton(
                          icon: SvgAsset(
                            request.isCompleted == true
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
                              date: request.dueDate,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                      child: Text(l10n.descriptionSectionTitle),
                    ),
                    VerticalGap.small(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                      child: Text(
                        request.descriptionHtml!,
                        style: textTheme.bodySmall?.copyWith(
                          color: Color(0xFF636262),
                        ),
                      ),
                    ),
                    VerticalGap.medium(),
                    if (request.actions.isNotEmpty)
                      RequestActions(actions: request.actions),
                    if (request.comments.isNotEmpty)
                      RequestComments(comments: request.comments),
                  ],
                ),
        );
      },
    );
  }
}
