import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_settings_state.dart';

class ProfileSettingsCubit extends Cubit<ProfileSettingsState> {
  ProfileSettingsCubit({
    required this.onProfileInfoTapped,
    required this.onChangePasswordTapped,
  }) : super(const ProfileSettingsState());
  final VoidCallback onProfileInfoTapped;
  final VoidCallback onChangePasswordTapped;
// @override
// Future<void> close() {
//   return super.close();
// }
}
