import 'package:json_annotation/json_annotation.dart';

part 'change_password_rm.g.dart';

@JsonSerializable(createFactory: false)
class ChangePasswordRM {
  const ChangePasswordRM({
    required this.currentPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });


  @JsonKey(name: 'current_password')
  final String currentPassword;
  @JsonKey(name: 'new_password')
  final String newPassword;
  @JsonKey(name: 'new_password_confirmation')
  final String newPasswordConfirmation;

  Map<String, dynamic> toJson() => _$ChangePasswordRMToJson(this);
}

