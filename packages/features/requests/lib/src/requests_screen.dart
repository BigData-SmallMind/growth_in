import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:requests/src/l10n/requests_localizations.dart';
import 'package:requests/src/requests_cubit.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestsCubit>(
      create: (_) => RequestsCubit(),
      child: const RequestsView(),
    );
  }
}

class RequestsView extends StatelessWidget {
  const RequestsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestsCubit, RequestsState>(
      builder: (context, state) {
        final theme = GrowthInTheme.of(context);
        final l10n = RequestsLocalizations.of(context);
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: l10n.appBarTitle,
          ),
          body: ListView.separated(
            separatorBuilder: (context, index) =>
                SizedBox(height: Spacing.small),
            padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
            itemCount: state.requests.length,
            itemBuilder: (context, index) {
              final request = state.requests[index];
              return Container(
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.borderColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(
                  Spacing.small,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Spacing.small,
                            vertical: Spacing.xSmall,
                          ),
                          child: Text(request.serviceName),
                          decoration: BoxDecoration(
                              color: Color(0xFFEBF2FF),
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        VerticalGap.small(),
                        Text(request.name),
                        VerticalGap.small(),
                        DateWidget(date: request.dateCreated),
                      ],
                    ),
                    Spacer(),
                    CircularPercentIndicator(
                      radius: 25,
                      center: Text(
                          '${request.completeTasksCount}/${request.tasks.length}'),
                      percent: request.percentTasksComplete,
                      circularStrokeCap: CircularStrokeCap.round,

                      lineWidth: 3,
                      progressColor: Color(0xFF4CAF50),
                    )
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
