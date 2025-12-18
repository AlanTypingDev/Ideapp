import 'package:fpdart/fpdart.dart';
import 'package:ideapp/common/caso_de_uso.dart';
import 'package:ideapp/common/falla.dart';
import 'package:ideapp/idea/dominio/entidades/idea_entidad.dart';
import 'package:ideapp/idea/dominio/repositorio/idea_repositorio.dart';

class GuardarIdea implements AsyncCasoDeUso<String, GuardarIdeaParametros> {
  final IdeaRepositorio repo;
  GuardarIdea(this.repo);

  @override
  Future<Either<Falla, String>> call(GuardarIdeaParametros parametros) {
    return repo.guardarIdea(parametros.idea);
  }
}

class GuardarIdeaParametros {
  final IdeaEntidad idea;
  GuardarIdeaParametros(this.idea);
}
