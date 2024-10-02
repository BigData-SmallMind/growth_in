import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart' as dm;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_details/src/l10n/request_details_localizations.dart';
import 'package:request_details/src/request_details_cubit.dart';

class RequestActions extends StatelessWidget {
  const RequestActions({
    super.key,
    required this.actions,
  });

  final List<dm.Action> actions;

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final l10n = RequestDetailsLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<RequestDetailsCubit, RequestDetailsState>(
      builder: (context, state) {
        final cubit = context.read<RequestDetailsCubit>();
        return GestureDetector(
          // onTap: cubit.onActionTapped,
          child: Column(
            children: [
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
                      onPressed: cubit.onViewAllActionsTapped),
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
                  itemCount: actions.length,
                  itemBuilder: (context, index) {
                    final action = actions[index];
                    return ActionCard(
                      onTap: () => cubit.onViewActionStepsTapped(action.id),
                      action: action,
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
