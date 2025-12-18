import 'package:ideapp/idea/dominio/modelos/idea_modelo.dart';

abstract class IdeaFuenteLocal {
  Future<void> guardarIdea(IdeaModelo idea);
  Future<void> eliminarIdea(String ideaId);
  Future<void> editarIdea(IdeaModelo idea);
  List<IdeaModelo> obtenerIdeas();
}
