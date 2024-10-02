import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_details/src/components/components.dart';
import 'package:request_details/src/l10n/request_details_localizations.dart';
import 'package:request_details/src/request_details_cubit.dart';
import 'package:request_repository/request_repository.dart';

class RequestDetailsScreen extends StatelessWidget {
  const RequestDetailsScreen({
    super.key,
    required this.requestRepository,
    required this.onViewAllActionsTapped,
    required this.onViewActionStepsTapped,
    required this.requestId,
  });

  final RequestRepository requestRepository;
  final VoidCallback onViewAllActionsTapped;
  final ValueSetter<int> onViewActionStepsTapped;

  final int requestId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestDetailsCubit>(
      create: (_) => RequestDetailsCubit(
        requestRepository: requestRepository,
        requestId: requestId,
        onViewAllActionsTapped: onViewAllActionsTapped,
        onViewActionStepsTapped: onViewActionStepsTapped,
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
    return BlocBuilder<RequestDetailsCubit, RequestDetailsState>(
      builder: (context, state) {
        final theme = GrowthInTheme.of(context);
        final l10n = RequestDetailsLocalizations.of(context);
        final textTheme = Theme.of(context).textTheme;
        final cubit = context.read<RequestDetailsCubit>();
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
                        MarkAsCompleteToggler(
                          isComplete: request.isComplete,
                          isLoading: state.toggleRequestCompleteStatus ==
                              ToggleRequestCompleteStatus.loading,
                          onPressed: cubit.toggleRequestComplete,
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
                      Comments(comments: request.comments),
                  ],
                ),
        );
      },
    );
  }
}
