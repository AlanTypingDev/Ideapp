// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea_modelo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IdeaModeloAdapter extends TypeAdapter<IdeaModelo> {
  @override
  final int typeId = 0;

  @override
  IdeaModelo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IdeaModelo(
      id: fields[0] as String,
      creadaEn: fields[1] as DateTime,
      estado: fields[2] as IdeaEstado,
      titulo: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IdeaModelo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.creadaEn)
      ..writeByte(2)
      ..write(obj.estado)
      ..writeByte(3)
      ..write(obj.titulo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdeaModeloAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
