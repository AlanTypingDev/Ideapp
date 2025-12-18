import 'package:fpdart/fpdart.dart';
import 'package:ideapp/common/falla.dart';
import 'package:ideapp/idea/dominio/entidades/idea_entidad.dart';

abstract interface class IdeaRepositorio {
  Future<Either<Falla, String>> guardarIdea(IdeaEntidad idea);
  Future<Either<Falla, String>> eliminarIdea(String ideaId);
  Future<Either<Falla, IdeaEntidad>> editarIdea(String ideaId);
  Either<Falla, List<IdeaEntidad>> obtenerIdeas();
}
