import 'package:hive/hive.dart';
import 'package:ideapp/idea/data/fuentes_de_data/idea_fuente_local.dart';
import 'package:ideapp/idea/dominio/modelos/idea_modelo.dart';

class IdeaFuenteLocalImpl implements IdeaFuenteLocal {
  final Box<IdeaModelo> box;
  IdeaFuenteLocalImpl(this.box);

  @override
  Future<void> guardarIdea(IdeaModelo idea) {
    return box.put(idea.id, idea);
  }

  @override
  Future<void> editarIdea(IdeaModelo idea) {
    return box.put(idea.id, idea);
  }

  @override
  Future<void> eliminarIdea(String ideaId) {
    return box.delete(ideaId);
  }

  @override
  List<IdeaModelo> obtenerIdeas() {
    return box.values.toList();
  }
}
