import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_actions/src/l10n/request_actions_localizations.dart';
import 'package:request_actions/src/request_actions_cubit.dart';
import 'package:request_repository/request_repository.dart';

class RequestActionsScreen extends StatelessWidget {
  const RequestActionsScreen({
    super.key,
    required this.requestRepository,
    required this.onViewActionStepsTapped,
  });

  final RequestRepository requestRepository;
  final ValueSetter<int> onViewActionStepsTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestActionsCubit>(
      create: (_) => RequestActionsCubit(
        requestRepository: requestRepository,
        onViewActionStepsTapped: onViewActionStepsTapped,
      ),
      child: const RequestActionsView(),
    );
  }
}

class RequestActionsView extends StatelessWidget {
  const RequestActionsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final isTablet = !View.of(context).isSmallTabletOrLess;

    return BlocBuilder<RequestActionsCubit, RequestActionsState>(
      builder: (context, state) {
        final theme = GrowthInTheme.of(context);
        final l10n = RequestActionsLocalizations.of(context);
        final request = state.request;
        final cubit = context.read<RequestActionsCubit>();
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: Text(l10n.appBarTitle),
          ),
          body: ListView.separated(
            padding: EdgeInsetsDirectional.only(
              start: theme.screenMargin,
              bottom: theme.screenMargin,
            ),
            separatorBuilder: (context, index) => VerticalGap.medium(),
            itemCount: request!.actions.length,
            itemBuilder: (context, index) {
              final action = request.actions[index];
              return ActionCard(
                action: action,
                index: index,
                onTap: () => cubit.onViewActionStepsTapped(action.id),
              );
            },
          ),
        );
      },
    );
  }
}
