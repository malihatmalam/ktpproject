// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'penduduk.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PendudukAdapter extends TypeAdapter<Penduduk> {
  @override
  final int typeId = 0;

  @override
  Penduduk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Penduduk(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Penduduk obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nama)
      ..writeByte(1)
      ..write(obj.birtInfo)
      ..writeByte(2)
      ..write(obj.city)
      ..writeByte(3)
      ..write(obj.province)
      ..writeByte(4)
      ..write(obj.job)
      ..writeByte(5)
      ..write(obj.education);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PendudukAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
