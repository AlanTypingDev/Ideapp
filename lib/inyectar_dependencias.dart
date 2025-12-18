import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ideapp/idea/data/fuentes_de_data/idea_fuente_local.dart';
import 'package:ideapp/idea/data/fuentes_de_data/idea_fuente_local_impl.dart';
import 'package:ideapp/idea/data/repositorio/idea_repositorio_impl.dart';
import 'package:ideapp/idea/dominio/casos_de_uso/eliminar_caso_de_uso.dart';
import 'package:ideapp/idea/dominio/casos_de_uso/guardar_caso_de_uso.dart';
import 'package:ideapp/idea/dominio/casos_de_uso/obtener_caso_de_uso.dart';
import 'package:ideapp/idea/dominio/entidades/idea_entidad.dart';
import 'package:ideapp/idea/dominio/modelos/idea_modelo.dart';
import 'package:ideapp/idea/dominio/repositorio/idea_repositorio.dart';
import 'package:ideapp/idea/presentacion/api_cubit/api_cubit.dart';
import 'package:ideapp/idea/presentacion/cubit/idea_cubit.dart';

final sl = GetIt.instance;

Future<void> iniciarDependencias() async {
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(IdeaEstadoAdapter());
  Hive.registerAdapter(IdeaModeloAdapter());

  // cubits
  sl.registerLazySingleton(
    () => IdeaCubit(sl<GuardarIdea>(), sl<EliminarIdea>(), sl<ObtenerIdeas>()),
  );

  sl.registerLazySingleton(() => ApiCubit());

  // hive-
  sl.registerLazySingleton<Box<IdeaModelo>>(
    () => Hive.box<IdeaModelo>("ideas"),
  );
  await Hive.openBox<IdeaModelo>("ideas");
  // fuente de data
  sl.registerFactory<IdeaFuenteLocal>(() => IdeaFuenteLocalImpl(sl()));
  // repositorio
  sl.registerFactory<IdeaRepositorio>(() => IdeaRepositorioImpl(sl()));
  // casos de uso
  sl.registerFactory(() => GuardarIdea(sl()));
  sl.registerFactory(() => EliminarIdea(sl()));
  sl.registerFactory(() => ObtenerIdeas(sl()));
}
