import 'package:ideapp/common/estado.dart';

class ApiState {
  final List<String>? ideas;
  final Estado estado;
  final String? error;
  ApiState({this.ideas, this.estado = Estado.inicial, this.error});
}
