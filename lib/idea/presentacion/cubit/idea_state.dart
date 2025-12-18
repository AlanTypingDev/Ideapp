import 'package:ideapp/common/estado.dart';
import 'package:ideapp/idea/dominio/entidades/idea_entidad.dart';

class IdeaState {
  final List<IdeaEntidad> ideas;
  final Estado estado;
  final String? error;
  final String? mensaje;
  IdeaState({
    this.ideas = const [],
    this.estado = Estado.inicial,
    this.error,
    this.mensaje,
  });

  IdeaState copyWith({
    List<IdeaEntidad>? ideas,
    Estado? estado,
    String? error,
    String? mensaje,
  }) {
    return IdeaState(
      ideas: ideas ?? this.ideas,
      estado: estado ?? this.estado,
      error: error,
      mensaje: mensaje,
    );
  }
}
