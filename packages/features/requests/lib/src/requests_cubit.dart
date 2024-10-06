import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:request_repository/request_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'requests_state.dart';

class RequestsCubit extends Cubit<RequestsState> {
  RequestsCubit({
    required this.requestRepository,
    required this.onRequestTapped,
  })  : requestsPagingController = PagingController(firstPageKey: 1),
        super(const RequestsState()) {
    getProjects();
    requestRepository.changeNotifier.addListener(
      () {
        final request = requestRepository.changeNotifier.request;
        if (request != null && !isClosed) {
          final updatedRequests = state.requests?.map((r) {
            if (r.id == request.id) {
              return request;
            }
            return r;
          }).toList();
          emit(state.copyWith(requests: updatedRequests));
        }
      },
    );
    // Fetch the first search page
    _handleVoucherListNextPageRequested();
    requestsPagingController.addPageRequestListener(
      (pageNumber) {
        final isSubsequentPage = pageNumber > 1;
        if (isSubsequentPage) {
          _handleVoucherListNextPageRequested(page: pageNumber);
        }
      },
    );
    searchTextSC
        .debounce((_) => TimerStream(true, const Duration(milliseconds: 500)))
        .switchMap((query) async* {
      final newState = RequestsState(
        filterBy: state.filterBy.copyWith(
          searchText: query,
        ),
      );
      emit(newState);

      yield await _handleVoucherListNextPageRequested();
    }).listen((_) {});
  }

  final RequestRepository requestRepository;
  final ValueSetter<int> onRequestTapped;
  final PagingController<int, Request> requestsPagingController;
  final BehaviorSubject<String> searchTextSC = BehaviorSubject();

  void getProjects() async {
    final loading = state.copyWith(
      projectsFetchStatus: ProjectsFetchStatus.loading,
    );
    emit(loading);
    try {
      final projects = await requestRepository.getProjects();
      final success = state.copyWith(
        projects: projects,
        projectsFetchStatus: ProjectsFetchStatus.loaded,
      );
      emit(success);
    } catch (error) {
      final failure = state.copyWith(
        projectsFetchStatus: ProjectsFetchStatus.error,
      );
      emit(failure);
    }
  }

  void onSearchTextChanged(String searchText) => searchTextSC.add(searchText);

  Future _handleVoucherListNextPageRequested({
    int page = 1,
  }) async {
    try {
      final newPage = await requestRepository.getRequests(
        pageNumber: page,
        filterBy: state.filterBy,
      );

      final newItemList = newPage.requestsList;
      final oldItemList = state.requests ?? [];
      final completeItemList =
          page == 1 ? newItemList : (oldItemList + newItemList);

      final nextPage = newPage.isLastPage ? null : page + 1;

      final couponListPageState = state.copyWith(
        requests: completeItemList,
        nextSearchPage: nextPage,
      );

      emit(couponListPageState);
    } catch (error) {
      final errorState = state.copyWith(
        nextSearchListPageLoadError: error,
      );
      emit(errorState);
      rethrow;
    }
  }

  Future reFetchFirstPage() async {
    final loadingFirstPageState = RequestsState(
      filterBy: state.filterBy,
      projects: state.projects,
    );
    emit(loadingFirstPageState);
    _handleVoucherListNextPageRequested();
  }

  Future<void> reFetchNextSearchListPage() async {
    final nextPageKey = state.nextSearchPage;
    final hasNextPage = nextPageKey != null;
    if (hasNextPage) {
      emit(
        state.copyWith(
          nextSearchPage: nextPageKey,
        ),
      );
      _handleVoucherListNextPageRequested(page: nextPageKey);
    }
  }

  onRequestStatusFilterPicked(RequestStatus status) {
    final newFilterBy = state.filterBy.copyWith(requestStatus: status);
    final newState = state.copyWith(filterBy: newFilterBy);
    emit(newState);
  }

  void setFilterBy(FilterBy filterBy) async {
    final newState = state.copyWith(
      filterBy: filterBy,
    );
    emit(newState);
  }

  FilterBy getFilterBy() => state.filterBy;

  void onApplyFilter() {
    final newState = state.copyWith(filterBy: state.filterBy);
    emit(newState);
    reFetchFirstPage();
  }

// @override
// Future<void> close() {
//   return super.close();
// }
}
