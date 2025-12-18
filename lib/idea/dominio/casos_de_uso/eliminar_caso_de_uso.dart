import 'package:fpdart/fpdart.dart';
import 'package:ideapp/common/caso_de_uso.dart';
import 'package:ideapp/common/falla.dart';
import 'package:ideapp/idea/dominio/repositorio/idea_repositorio.dart';

class EliminarIdea implements AsyncCasoDeUso<String, EliminarIdeaParametros> {
  final IdeaRepositorio repositorio;
  EliminarIdea(this.repositorio);

  @override
  Future<Either<Falla, String>> call(EliminarIdeaParametros parametros) async {
    return repositorio.eliminarIdea(parametros.id);
  }
}

class EliminarIdeaParametros {
  final String id;
  EliminarIdeaParametros({required this.id});
}
