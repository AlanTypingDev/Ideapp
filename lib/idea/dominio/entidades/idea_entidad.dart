// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';

part 'idea_entidad.g.dart';

@HiveType(typeId: 1)
enum IdeaEstado {
  @HiveField(0)
  completa,
  @HiveField(1)
  incompleta,
}

class IdeaEntidad {
  final String id;
  final DateTime creadaEn;
  final IdeaEstado estado;
  final String titulo;
  IdeaEntidad({
    required this.id,
    required this.creadaEn,
    required this.estado,
    required this.titulo,
  });

  IdeaEntidad copyWith({
    String? id,
    DateTime? creadaEn,
    IdeaEstado? estado,
    String? titulo,
  }) {
    return IdeaEntidad(
      id: id ?? this.id,
      creadaEn: creadaEn ?? this.creadaEn,
      estado: estado ?? this.estado,
      titulo: titulo ?? this.titulo,
    );
  }
}
