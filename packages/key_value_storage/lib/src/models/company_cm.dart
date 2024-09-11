import 'package:hive/hive.dart';

part 'company_cm.g.dart';

@HiveType(typeId: 5)
class CompanyCM {
  const CompanyCM({
    required this.id,
    required this.name,
    required this.sector,
    required this.isSelected,
    this.profileImage,
    required this.email,
  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String sector;
  @HiveField(4)
  final bool isSelected;
  @HiveField(5)
  final String? profileImage;
  @HiveField(6)
  final String? email;
}
