import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:requests/src/requests_cubit.dart';

class RequestCard extends StatelessWidget {
  const RequestCard({
    super.key,
    required this.request,
  });

  final Request request;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestsCubit, RequestsState>(
      builder: (context, state) {
        final theme = GrowthInTheme.of(context);
        final cubit = context.read<RequestsCubit>();
        return GestureDetector(
          onTap: () => cubit.onRequestTapped(request.id),
          child: Container(
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
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.small,
                        vertical: Spacing.xSmall,
                      ),
                      decoration: BoxDecoration(
                          color: const Color(0xFFEBF2FF),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        request.serviceName != null
                            ? request.serviceName!
                            : request.projectName != null
                                ? request.projectName!
                                : request.campaignName != null
                                    ? request.campaignName!
                                    : '',
                      ),
                    ),
                    VerticalGap.small(),
                    Text(request.name),
                    VerticalGap.small(),
                    DateAndTimeWidget(date: request.startDate),
                  ],
                ),
                const Spacer(),
                CircularPercentIndicator(
                  radius: 25,
                  center: Text(
                      '${request.completeActionStepsCount}/${request.totalActionStepsCount}'),
                  percent: request.percentActionStepsComplete,
                  circularStrokeCap: CircularStrokeCap.round,
                  lineWidth: 3,
                  progressColor: const Color(0xFF4CAF50),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
