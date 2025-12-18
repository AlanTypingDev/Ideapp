import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:ideapp/common/caso_de_uso.dart';
import 'package:ideapp/common/estado.dart';
import 'package:ideapp/idea/dominio/casos_de_uso/eliminar_caso_de_uso.dart';
import 'package:ideapp/idea/dominio/casos_de_uso/guardar_caso_de_uso.dart';
import 'package:ideapp/idea/dominio/casos_de_uso/obtener_caso_de_uso.dart';
import 'package:ideapp/idea/dominio/entidades/idea_entidad.dart';
import 'package:ideapp/idea/presentacion/cubit/idea_state.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class IdeaCubit extends Cubit<IdeaState> {
  final GuardarIdea _guardarIdea;
  final EliminarIdea _eliminarIdea;
  final ObtenerIdeas _obtenerIdeas;
  IdeaCubit(
    GuardarIdea guardarIdea,
    EliminarIdea eliminarIdea,
    ObtenerIdeas obtenerIdeas,
  ) : _guardarIdea = guardarIdea,
      _eliminarIdea = eliminarIdea,
      _obtenerIdeas = obtenerIdeas,
      super(IdeaState());

  Future<void> guardarIdea(String titulo) async {
    emit(state.copyWith(estado: Estado.cargando));
    log("Guardando idea");
    final respuesta = await _guardarIdea(
      GuardarIdeaParametros(
        IdeaEntidad(
          id: uuid.v4(),
          creadaEn: DateTime.now(),
          estado: IdeaEstado.incompleta,
          titulo: titulo,
        ),
      ),
    );
    respuesta.fold(
      (l) => emit(state.copyWith(error: l.mensaje, estado: Estado.error)),
      (r) => obtenerIdeas(),
    );
  }

  Future<void> eliminarIdea(String id) async {
    emit(state.copyWith(estado: Estado.cargando));
    final respuesta = await _eliminarIdea(EliminarIdeaParametros(id: id));
    respuesta.fold(
      (l) => emit(state.copyWith(error: l.mensaje, estado: Estado.error)),
      (r) => obtenerIdeas(),
    );
    emit(state.copyWith(estado: Estado.actualizando));
  }

  Future<void> actualizarIdea(IdeaEntidad idea) async {
    emit(state.copyWith(estado: Estado.cargando));
    log("Actualizando idea ${idea.id}");
    final respuesta = await _guardarIdea(GuardarIdeaParametros(idea));
    respuesta.fold(
      (l) => emit(state.copyWith(error: l.mensaje, estado: Estado.error)),
      (r) => obtenerIdeas(),
    );
  }

  void obtenerIdeas() {
    emit(state.copyWith(estado: Estado.cargando));
    final respuesta = _obtenerIdeas(SinParametros());

    respuesta.fold(
      (l) => emit(state.copyWith(error: l.mensaje, estado: Estado.error)),
      (r) => emit(state.copyWith(ideas: r, estado: Estado.exito)),
    );
  }
}
