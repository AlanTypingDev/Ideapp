import 'package:fpdart/fpdart.dart';
import 'package:ideapp/common/caso_de_uso.dart';
import 'package:ideapp/common/falla.dart';
import 'package:ideapp/idea/dominio/entidades/idea_entidad.dart';
import 'package:ideapp/idea/dominio/repositorio/idea_repositorio.dart';

class ObtenerIdeas implements CasoDeUso<List<IdeaEntidad>, SinParametros> {
  final IdeaRepositorio repo;
  ObtenerIdeas(this.repo);

  @override
  Either<Falla, List<IdeaEntidad>> call(SinParametros parametros) {
    return repo.obtenerIdeas();
  }
}
