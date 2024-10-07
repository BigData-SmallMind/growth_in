import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_repository/meeting_repository.dart';

part 'meetings_state.dart';

class MeetingsCubit extends Cubit<MeetingsState> {
  MeetingsCubit({
    required this.meetingRepository,
  }) : super(
          const MeetingsState(),
        ){
    getMeetings();
  }

  final MeetingRepository meetingRepository;

  void getMeetings() async {
    final loading = state.copyWith(
      meetingsStatus: MeetingsStatus.loading,
    );
    emit(loading);
    try {
      final meetings = await meetingRepository.getMeetings();
      final success = state.copyWith(
        meetings: meetings,
        meetingsStatus: MeetingsStatus.success,
      );
      emit(success);
    } catch (error) {
      final failure = state.copyWith(
        meetingsStatus: MeetingsStatus.failure,
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
