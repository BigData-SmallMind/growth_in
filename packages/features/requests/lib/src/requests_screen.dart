import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:request_repository/request_repository.dart';
import 'package:requests/src/components/filter_button.dart';
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
    return BlocConsumer<RequestsCubit, RequestsState>(
      listener: (context, state) {
        final cubit = context.read<RequestsCubit>();
        cubit.requestsPagingController.value = state.toPagingState();
      },
      builder: (context, state) {
        final l10n = RequestsLocalizations.of(context);
        final cubit = context.read<RequestsCubit>();
        final theme = GrowthInTheme.of(context);
        final projectsFetchStatusLoading =
            state.projectsFetchStatus == ProjectsFetchStatus.loading;
        return Scaffold(
          appBar: GrowthInAppBar(
            logoVariation: false,
            title: Row(
              children: [
                Text(l10n.appBarTitle),
                HorizontalGap.small(),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      prefixIconConstraints:
                          BoxConstraints(minWidth: 40, minHeight: 10),
                      prefixIcon: Icon(
                        Icons.search,
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 5),
                      isDense: true,
                    ),
                    onChanged: cubit.onSearchTextChanged,
                  ),
                ),
                HorizontalGap.small(),
                projectsFetchStatusLoading
                    ? Transform.scale(
                        scale: 0.6,
                        child: const CenteredCircularProgressIndicator(),
                      )
                    : const FilterButton(),
              ],
            ),
          ),
          body: RefreshIndicator(
            onRefresh: cubit.reFetchFirstPage,
            child: PagedListView.separated(
              padding: EdgeInsets.symmetric(horizontal: theme.screenMargin),
              pagingController: cubit.requestsPagingController,
              separatorBuilder: (context, index) => VerticalGap.medium(),
              builderDelegate: PagedChildBuilderDelegate<Request>(
                itemBuilder: (context, request, index) {
                  return Column(
                    children: [
                      if (index == 0) VerticalGap.medium(),
                      RequestCard(
                        request: request,
                      ),
                    ],
                  );
                },
                firstPageErrorIndicatorBuilder: (context) {
                  return ExceptionIndicator(
                    onTryAgain: cubit.reFetchFirstPage,
                  );
                },
                newPageProgressIndicatorBuilder: (_) {
                  return const NewPageProgressIndicator();
                },
                noItemsFoundIndicatorBuilder: (_) {
                  return NoItemsFoundIndicator(
                    message: l10n.noItemsFoundMessage,
                  );
                },
                newPageErrorIndicatorBuilder: (_) {
                  return NextPageExceptionIndicator(
                    onTryAgain: cubit.reFetchNextSearchListPage,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

extension on RequestsState {
  PagingState<int, Request> toPagingState() {
    return PagingState(
      itemList: requests,
      nextPageKey: nextSearchPage,
      error: nextSearchListPageLoadError,
    );
  }
}
