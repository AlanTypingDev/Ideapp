import 'package:ideapp/idea/dominio/entidades/idea_entidad.dart';
import 'package:ideapp/idea/dominio/modelos/idea_modelo.dart';

class IdeaMapper {
  static IdeaModelo desdeEntidad(IdeaEntidad idea) {
    return IdeaModelo(
      id: idea.id,
      creadaEn: idea.creadaEn,
      estado: idea.estado,
      titulo: idea.titulo,
    );
  }

  static IdeaEntidad desdeModelo(IdeaModelo idea) {
    return IdeaEntidad(
      id: idea.id,
      creadaEn: idea.creadaEn,
      estado: idea.estado,
      titulo: idea.titulo,
    );
  }

  static List<IdeaEntidad> aListaDeEntidad(List<IdeaModelo> listaModelo) {
    return listaModelo.map((IdeaModelo modelo) => desdeModelo(modelo)).toList();
  }
}
