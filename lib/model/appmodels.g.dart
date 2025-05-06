// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appmodels.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppmodelsAdapter extends TypeAdapter<Appmodels> {
  @override
  final int typeId = 0;

  @override
  Appmodels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Appmodels(
      image: fields[0] as Uint8List?,
      date: fields[1] as String?,
      time: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Appmodels obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppmodelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
