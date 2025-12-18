import 'dart:developer';

import 'package:fpdart/fpdart.dart';
import 'package:ideapp/common/falla.dart';
import 'package:ideapp/idea/data/fuentes_de_data/idea_fuente_local.dart';
import 'package:ideapp/idea/data/mappers/idea_mapper.dart';
import 'package:ideapp/idea/dominio/entidades/idea_entidad.dart';
import 'package:ideapp/idea/dominio/modelos/idea_modelo.dart';
import 'package:ideapp/idea/dominio/repositorio/idea_repositorio.dart';

class IdeaRepositorioImpl implements IdeaRepositorio {
  final IdeaFuenteLocal fuenteLocal;
  IdeaRepositorioImpl(this.fuenteLocal);

  @override
  Future<Either<Falla, String>> guardarIdea(IdeaEntidad idea) async {
    try {
      await fuenteLocal.guardarIdea(IdeaMapper.desdeEntidad(idea));
      log("Idea guardada con éxito");
      return right("Idea guardada con éxito");
    } catch (e) {
      log("Idea guardada con fallo: ${e.toString()}");
      return left(Falla("Error al guardar idea: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Falla, IdeaEntidad>> editarIdea(String ideaId) {
    // TODO: implement editarIdea
    throw UnimplementedError();
  }

  @override
  Future<Either<Falla, String>> eliminarIdea(String ideaId) async {
    try {
      await fuenteLocal.eliminarIdea(ideaId);
      log("🗑️ Idea eliminada con éxito: $ideaId");
      return right("Idea eliminada con éxito");
    } catch (e) {
      log("❌ Error al eliminar idea: ${e.toString()}");
      return left(Falla("Error al eliminar idea: ${e.toString()}"));
    }
  }

  @override
  Either<Falla, List<IdeaEntidad>> obtenerIdeas() {
    try {
      final List<IdeaModelo> listaModelo = fuenteLocal.obtenerIdeas();
      return right(IdeaMapper.aListaDeEntidad(listaModelo));
    } catch (e) {
      return left(Falla("Error al obtener idea: ${e.toString()}"));
    }
  }
}
