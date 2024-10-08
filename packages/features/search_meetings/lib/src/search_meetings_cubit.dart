import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_repository/meeting_repository.dart';

part 'search_meetings_state.dart';

class SearchMeetingsCubit extends Cubit<SearchMeetingsState> {
  SearchMeetingsCubit({
    required this.meetingRepository,
  }) : super(
          const SearchMeetingsState(),
        ){
    getSearchMeetings();
  }

  final MeetingRepository meetingRepository;

  void getSearchMeetings() async {
    final loading = state.copyWith(
      search_meetingsStatus: SearchMeetingsStatus.loading,
    );
    emit(loading);
    try {
      final search_meetings = await meetingRepository.getSearchMeetings();
      final success = state.copyWith(
        search_meetings: search_meetings,
        search_meetingsStatus: SearchMeetingsStatus.success,
      );
      emit(success);
    } catch (error) {
      final failure = state.copyWith(
        search_meetingsStatus: SearchMeetingsStatus.failure,
      );
      emit(failure);
    }
  }

// @override
// Future<void> close() async {
//   userRepository.deleteOtpVerificationTokenSupplierString();
//   return super.close();
// }
}
