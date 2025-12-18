// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea_entidad.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IdeaEstadoAdapter extends TypeAdapter<IdeaEstado> {
  @override
  final int typeId = 1;

  @override
  IdeaEstado read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return IdeaEstado.completa;
      case 1:
        return IdeaEstado.incompleta;
      default:
        return IdeaEstado.completa;
    }
  }

  @override
  void write(BinaryWriter writer, IdeaEstado obj) {
    switch (obj) {
      case IdeaEstado.completa:
        writer.writeByte(0);
        break;
      case IdeaEstado.incompleta:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IdeaEstadoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
