import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:meeting_repository/meeting_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'meeting_details_state.dart';

class MeetingDetailsCubit extends Cubit<MeetingDetailsState> {
  MeetingDetailsCubit({
    required this.meetingRepository,
    required this.onCancelMeetingTapped,
    required this.onScheduleMeetingTapped,
    required this.downloadUrl,
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
  final ValueSetter<Meeting> onCancelMeetingTapped;
  final ValueSetter<Meeting> onScheduleMeetingTapped;
  final String downloadUrl;

  void downloadFile(FileDM file) async {
    try {
      final downloadPermissionStatus = await Permission.storage.request();
      if (downloadPermissionStatus.isGranted) {
        final url = '$downloadUrl/${file.name}';
        final downloadPath = await getExternalStorageDirectory();
        final taskId = await FlutterDownloader.enqueue(
          url: url,
          savedDir: downloadPath?.path ?? '/storage/emulated/0/Download',
          fileName: file.name,
          showNotification: true,
          openFileFromNotification: true,
        );
        debugPrint(taskId.toString());
        return;
      } else {
        debugPrint('Permission denied');
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

// @override
// Future<void> close() async {
//   userRepository.deleteOtpVerificationTokenSupplierString();
//   return super.close();
// }
}
