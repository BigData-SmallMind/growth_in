import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meeting_repository/meeting_repository.dart';

part 'meeting_details_state.dart';

class MeetingDetailsCubit extends Cubit<MeetingDetailsState> {
  MeetingDetailsCubit({
    required this.meetingRepository,
  }) : super(
          MeetingDetailsState(
            meeting: meetingRepository.changeNotifier.meeting,
          ),
        );
  final MeetingRepository meetingRepository;

// @override
// Future<void> close() async {
//   userRepository.deleteOtpVerificationTokenSupplierString();
//   return super.close();
// }
}
