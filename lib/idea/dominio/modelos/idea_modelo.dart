import 'package:hive/hive.dart';
import 'package:ideapp/idea/dominio/entidades/idea_entidad.dart';

part 'idea_modelo.g.dart';

@HiveType(typeId: 0)
class IdeaModelo {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final DateTime creadaEn;

  @HiveField(2)
  final IdeaEstado estado;

  @HiveField(3)
  final String titulo;

  IdeaModelo({
    required this.id,
    required this.creadaEn,
    required this.estado,
    required this.titulo,
  });

  factory IdeaModelo.fromJson(Map<String, dynamic> json) {
    return IdeaModelo(
      id: json['id'] as String,
      creadaEn: DateTime.parse(json['creadaEn'] as String),
      estado: IdeaEstado.values.byName(json['estado'] as String),
      titulo: json['titulo'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'creadaEn': creadaEn.toIso8601String(),
      'estado': estado.name,
      'titulo': titulo,
    };
  }
}
