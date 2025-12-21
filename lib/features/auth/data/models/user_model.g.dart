// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      message: fields[0] as String?,
      token: fields[8] as String?,
      userId: fields[1] as int?,
      userName: fields[2] as String?,
      userEmail: fields[3] as String?,
      userPhone: fields[4] as String?,
      userSalary: fields[5] as String?,
      userImage: fields[6] as String?,
      branch: fields[7] as Branch?,
      rewarded: fields[9] as String?,
      penalized: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.message)
      ..writeByte(8)
      ..write(obj.token)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.userName)
      ..writeByte(3)
      ..write(obj.userEmail)
      ..writeByte(4)
      ..write(obj.userPhone)
      ..writeByte(5)
      ..write(obj.userSalary)
      ..writeByte(6)
      ..write(obj.userImage)
      ..writeByte(7)
      ..write(obj.branch)
      ..writeByte(9)
      ..write(obj.rewarded)
      ..writeByte(10)
      ..write(obj.penalized);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BranchAdapter extends TypeAdapter<Branch> {
  @override
  final int typeId = 2;

  @override
  Branch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Branch(
      id: fields[0] as int?,
      name: fields[1] as String?,
      transferFee: fields[2] as int?,
      commissionRatePercentage: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Branch obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.transferFee)
      ..writeByte(3)
      ..write(obj.commissionRatePercentage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BranchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
