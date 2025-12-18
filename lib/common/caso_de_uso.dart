import 'package:fpdart/fpdart.dart';
import 'package:ideapp/common/falla.dart';

abstract interface class CasoDeUso<TipoExitoso, Parametros> {
  Either<Falla, TipoExitoso> call(Parametros parametros);
}

abstract interface class AsyncCasoDeUso<TipoExitoso, Parametros> {
  Future<Either<Falla, TipoExitoso>> call(Parametros parametros);
}

class SinParametros {}
