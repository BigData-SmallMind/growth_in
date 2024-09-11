// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_companies_cm.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserCompaniesCMAdapter extends TypeAdapter<UserCompaniesCM> {
  @override
  final int typeId = 1;

  @override
  UserCompaniesCM read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCompaniesCM(
      companies: (fields[6] as List).cast<CompanyCM>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserCompaniesCM obj) {
    writer
      ..writeByte(1)
      ..writeByte(6)
      ..write(obj.companies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCompaniesCMAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
