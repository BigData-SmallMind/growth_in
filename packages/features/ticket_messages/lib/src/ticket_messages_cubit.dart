import 'dart:io';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

part 'ticket_messages_state.dart';

class TicketMessagesCubit extends Cubit<TicketMessagesState> {
  TicketMessagesCubit({
    required this.userRepository,
  })  : _imagePicker = ImagePicker(),
        super(
          TicketMessagesState(
            ticket: userRepository.changeNotifier.ticket,
          ),
        ) {
    getTicketMessages();
  }

  final UserRepository userRepository;
  final ImagePicker _imagePicker;
  final TextEditingController messageController = TextEditingController();
  // get ticket_messages
  Future getTicketMessages() async {
    final loadingState =
        state.copyWith(fetchingStatus: TicketMessagesFetchingStatus.inProgress);
    emit(loadingState);
    try {
      final messages = await userRepository.getTicketMessages(state.ticket!.id);
      final successState = state.copyWith(
        fetchingStatus: TicketMessagesFetchingStatus.success,
        messages: messages,
      );
      emit(successState);
    } catch (_) {
      final failureState = state.copyWith(
        fetchingStatus: TicketMessagesFetchingStatus.failure,
      );
      emit(failureState);
    }
  }

  Future pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      final newState = state.copyWith(
        file: file,
      );
      emit(newState);
    } else {
      // User canceled the picker
    }
  }

  Future<void> pickImageFromGallery() async {
    XFile? xFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (xFile != null) {
      File? file = File(
        xFile.path.toString(),
      );
      final newState = state.copyWith(
        file: file,
      );
      emit(newState);
    }
  }

  Future<void> capturePhoto() async {
    XFile? xFile = await _imagePicker.pickImage(
      source: ImageSource.camera,
    );
    if (xFile != null) {
      File? file = File(
        xFile.path.toString(),
      );
      final newState = state.copyWith(
        file: file,
      );
      emit(newState);
    }
  }

  void deletePickedFile() {
    final newState = TicketMessagesState(
      ticket: state.ticket,
      messages: state.messages,
      fetchingStatus: state.fetchingStatus,
      submissionStatus: state.submissionStatus,
      message: state.message,
      file: null,
    );
    emit(newState);
  }

  void onMessageChanged(String message) {
    final newState = state.copyWith(
      message: message,
    );
    emit(newState);
  }

  void sendMessage() async {
    final newState = state.copyWith(
      submissionStatus: TicketMessagesSubmissionStatus.inProgress,
    );
    emit(newState);
    try {
      await userRepository.createTicketMessage(
        ticketId: state.ticket!.id,
        text: state.message!,
        file: state.file,
      );
      final newState = state.copyWith(
        submissionStatus: TicketMessagesSubmissionStatus.success,
      );
      emit(newState);
      final initialState = TicketMessagesState(
        ticket: state.ticket,
        messages: state.messages,
        fetchingStatus: TicketMessagesFetchingStatus.initial,
        submissionStatus: TicketMessagesSubmissionStatus.initial,
        message: null,
        file: null,
      );
      emit(initialState);
      messageController.clear();
      getTicketMessages();
    } catch (e) {
      final failureState = state.copyWith(
        submissionStatus: TicketMessagesSubmissionStatus.failure,
      );
      emit(failureState);
      rethrow;
    }
  }

// @override
// Future<void> close() {
//   return super.close();
// }
}
