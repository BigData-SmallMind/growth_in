import 'package:json_annotation/json_annotation.dart';

part 'change_email_rm.g.dart';



@JsonSerializable(createFactory: false)
class ChangeEmailRM {
  const ChangeEmailRM({
    required this.newEmail,
    required this.newEmailConfirmation,
    required this.password,
  });


  @JsonKey(name: 'new_email')
  final String newEmail;
  @JsonKey(name: 'new_email_confirmation')
  final String newEmailConfirmation;
  @JsonKey(name: 'current_password')
  final String password;

  Map<String, dynamic> toJson() => _$ChangeEmailRMToJson(this);
}
