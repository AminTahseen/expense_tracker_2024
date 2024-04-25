// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'accounts_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountsModelAdapter extends TypeAdapter<AccountsModel> {
  @override
  final int typeId = 1;

  @override
  AccountsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountsModel(
      accountId: fields[0] as String,
      accountName: fields[1] as String,
      createdByUserId: fields[2] as double,
      openingBalance: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, AccountsModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.accountId)
      ..writeByte(1)
      ..write(obj.accountName)
      ..writeByte(2)
      ..write(obj.createdByUserId)
      ..writeByte(3)
      ..write(obj.openingBalance);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
