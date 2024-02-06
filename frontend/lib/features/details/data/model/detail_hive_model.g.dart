// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetailHiveModelAdapter extends TypeAdapter<DetailHiveModel> {
  @override
  final int typeId = 2;

  @override
  DetailHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DetailHiveModel(
      tripId: fields[0] as String?,
      title: fields[1] as String,
      url: fields[2] as String,
      date: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DetailHiveModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.tripId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
