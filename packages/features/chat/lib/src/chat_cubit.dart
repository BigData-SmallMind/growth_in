import 'dart:io';

import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_repository/user_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({
    required this.userRepository,
  })  : _imagePicker = ImagePicker(),
        super(const ChatState()) {
    getChat();
    userRepository.initPusher().then((_) {
      userRepository.subscribeToChat();
    });
  }

  final scrollController = ScrollController();
  final UserRepository userRepository;
  final ImagePicker _imagePicker;
  final TextEditingController messageController = TextEditingController();

  // get ticket_messages
  Future getChat() async {
    final loadingState =
        state.copyWith(fetchingStatus: ChatFetchingStatus.inProgress);
    emit(loadingState);
    try {
      final dateGroupedChats = await userRepository.getDateGroupedChats();
      final successState = state.copyWith(
        fetchingStatus: ChatFetchingStatus.success,
        dateGroupedChats: dateGroupedChats,
      );
      emit(successState);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(
            scrollController.position.maxScrollExtent,
          );
        }
      });
    } catch (_) {
      final failureState = state.copyWith(
        fetchingStatus: ChatFetchingStatus.failure,
      );
      emit(failureState);
    }
  }

  Future pickFiles() async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
    );

    if (result != null) {
      final files =
          result.files.map((platformFile) => File(platformFile.path!)).toList();
      final newState = state.copyWith(
        files: files,
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
        files: [file],
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
        files: [file],
      );
      emit(newState);
    }
  }

  void deletePickedFile() {
    final newState = ChatState(
      dateGroupedChats: state.dateGroupedChats,
      fetchingStatus: state.fetchingStatus,
      submissionStatus: state.submissionStatus,
      message: state.message,
      files: null,
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
      submissionStatus: ChatSubmissionStatus.inProgress,
    );
    emit(newState);
    try {
      await userRepository.sendChatMessage(
        message: state.message!,
        files: state.files,
      );
      final newState = state.copyWith(
        submissionStatus: ChatSubmissionStatus.success,
      );
      emit(newState);
      final initialState = ChatState(
        dateGroupedChats: state.dateGroupedChats,
        fetchingStatus: ChatFetchingStatus.initial,
        submissionStatus: ChatSubmissionStatus.initial,
        message: null,
        files: null,
      );
      emit(initialState);
      messageController.clear();
      // getChat();
    } catch (e) {
      final failureState = state.copyWith(
        submissionStatus: ChatSubmissionStatus.failure,
      );
      emit(failureState);
      rethrow;
    }
  }

  Stream<DateGroupedChats> get chatStream => userRepository.chatStream();
}
