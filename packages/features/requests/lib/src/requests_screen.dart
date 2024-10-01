import 'package:component_library/component_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:request_repository/request_repository.dart';
import 'package:requests/src/components/request_card.dart';
import 'package:requests/src/l10n/requests_localizations.dart';
import 'package:requests/src/requests_cubit.dart';

class RequestsScreen extends StatelessWidget {
  const RequestsScreen({
    super.key,
    required this.requestRepository,
    required this.onRequestTapped,
  });

  final RequestRepository requestRepository;
  final ValueSetter<int> onRequestTapped;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestsCubit>(
      create: (_) => RequestsCubit(
        requestRepository: requestRepository,
        onRequestTapped: onRequestTapped,
      ),
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
        final loading =
            state.fetchingRequestsStatus == FetchingRequestsStatus.loading;
        final requestsEmpty = state.requests.isEmpty;
        final textTheme = Theme.of(context).textTheme;
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: l10n.appBarTitle,
          ),
          body: loading
              ? const CenteredCircularProgressIndicator()
              : requestsEmpty
                  ? Center(
                      child: Text(
                        l10n.emptyRequestsListIndicator,
                        style: textTheme.titleLarge,
                      ),
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) => VerticalGap.small(),
                      padding:
                          EdgeInsets.symmetric(horizontal: theme.screenMargin),
                      itemCount: state.requests.length,
                      itemBuilder: (context, index) {
                        final request = state.requests[index];
                        return RequestCard(request: request);
                      },
                    ),
        );
      },
    );
  }
}
