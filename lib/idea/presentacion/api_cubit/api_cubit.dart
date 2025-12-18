import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:ideapp/common/estado.dart';
import 'package:ideapp/idea/presentacion/api_cubit/api_state.dart';

/// =======================
/// Constantes
/// =======================

const _groqUrl = 'https://api.groq.com/openai/v1/chat/completions';
const _model = 'llama-3.3-70b-versatile';
const _timeout = Duration(seconds: 10);

/// =======================
/// HTTP CLIENT
/// =======================

Future<Map<String, dynamic>> _postGroq(String prompt, String apiKey) async {
  final response = await http
      .post(
        Uri.parse(_groqUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode({
          'model': _model,
          'messages': [
            {
              'role': 'system',
              'content':
                  'Eres un generador creativo de micro-ideas. Evita repetir temas comunes ',
            },
            {'role': 'user', 'content': prompt},
          ],
          'temperature': 1,
        }),
      )
      .timeout(_timeout);

  if (response.statusCode != 200) {
    throw Exception('Groq ${response.statusCode}: ${response.body}');
  }

  return jsonDecode(response.body) as Map<String, dynamic>;
}

/// =======================
/// PARSER DE RESPUESTA
/// =======================

String _extraerContenido(Map<String, dynamic> data) {
  final choices = data['choices'];

  if (choices is List && choices.isNotEmpty) {
    final choice = choices.first;

    if (choice['message']?['content'] is String) {
      return choice['message']['content'];
    }

    if (choice['text'] is String) {
      return choice['text'];
    }
  }

  throw Exception('Formato de respuesta no soportado');
}

/// =======================
/// CASO DE USO SIMPLE
/// =======================

Future<List<String>> pedirIdeas(String prompt) async {
  final apiKey = dotenv.env['API_KEY'];

  if (apiKey == null || apiKey.isEmpty) {
    throw Exception('API_KEY inválida. Revisá el .env y dotenv.load()');
  }

  final data = await _postGroq(prompt, apiKey);
  final contenido = _extraerContenido(data);

  log(
    '✅ Respuesta cruda: ${contenido.substring(0, contenido.length.clamp(0, 200))}',
  );

  return _parsearIdeas(contenido);
}

/// =======================
/// PARSER DE IDEAS
/// =======================

List<String> _parsearIdeas(String texto) {
  return texto
      .split(RegExp(r'\n?\d+\.\s'))
      .map((e) => e.trim())
      .where((e) => e.isNotEmpty)
      .toList();
}

/// =======================
/// CUBIT
/// =======================

class ApiCubit extends Cubit<ApiState> {
  ApiCubit() : super(ApiState());

  Future<void> generarNuevasIdeas(String prompt) async {
    emit(ApiState(estado: Estado.cargando));
    log('🚀 Generando ideas');

    try {
      final resultados = await Future.wait(
        List.generate(3, (_) => pedirIdeas(prompt)),
      );

      final ideasFinales = resultados.expand((e) => e).toList();

      log('🎯 Ideas finales: $ideasFinales');

      emit(ApiState(estado: Estado.exito, ideas: ideasFinales));
    } catch (e, st) {
      log('❌ Error generando ideas', error: e, stackTrace: st);

      emit(ApiState(estado: Estado.error, error: e.toString()));
    }
  }
}
