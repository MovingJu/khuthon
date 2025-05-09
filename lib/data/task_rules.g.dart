// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_rules.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CropDataAdapter extends TypeAdapter<CropData> {
  @override
  final int typeId = 0;

  @override
  CropData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CropData(
      name: fields[0] as String,
      waterperiod: fields[1] as String,
      sunneed: fields[2] as String,
      description: fields[3] as String,
    )
      ..difficulty = fields[4] as String?
      ..info = fields[5] as String?
      ..indoorfriendly = fields[6] as String?
      ..sowingdate = fields[7] as DateTime?
      ..harvestdate = fields[8] as DateTime?;
  }

  @override
  void write(BinaryWriter writer, CropData obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.waterperiod)
      ..writeByte(2)
      ..write(obj.sunneed)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.difficulty)
      ..writeByte(5)
      ..write(obj.info)
      ..writeByte(6)
      ..write(obj.indoorfriendly)
      ..writeByte(7)
      ..write(obj.sowingdate)
      ..writeByte(8)
      ..write(obj.harvestdate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CropDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
