import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:meeting_repository/meeting_repository.dart';

part 'meeting_details_state.dart';

class MeetingDetailsCubit extends Cubit<MeetingDetailsState> {
  MeetingDetailsCubit({
    required this.meetingRepository,
    required this.folderRepository,
    required this.onCancelMeetingTapped,
    required this.onScheduleMeetingTapped,
  }) : super(
          MeetingDetailsState(
            meeting: meetingRepository.changeNotifier.meeting,
            variation: meetingRepository.changeNotifier.meetingCardVariation,
          ),
        ) {
    meetingRepository.changeNotifier.addListener(() {
      if (meetingRepository.changeNotifier.shouldReFetchMeetings == true) {
        final updatedMeetingState = state.copyWith(
          meeting: meetingRepository.changeNotifier.meeting,
        );
        if (!isClosed) emit(updatedMeetingState);
      }
    });
  }

  final MeetingRepository meetingRepository;
  final FolderRepository folderRepository;
  final ValueSetter<Meeting> onCancelMeetingTapped;
  final ValueSetter<Meeting> onScheduleMeetingTapped;

  // void downloadFile(FileDM file) async {
  //   try {
  //     folderRepository.downloadFiles([file.name]);
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

// @override
// Future<void> close() async {
//   userRepository.deleteOtpVerificationTokenSupplierString();
//   return super.close();
// }
}
