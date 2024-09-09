import 'package:hive/hive.dart';

part 'user_cm.g.dart';

@HiveType(typeId: 1)
class UserCM {
  const UserCM({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.image,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String? image;

}
