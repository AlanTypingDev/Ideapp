import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ideapp/idea/presentacion/api_cubit/api_cubit.dart';
import 'package:ideapp/idea/presentacion/cubit/idea_cubit.dart';
import 'package:ideapp/idea/presentacion/generar_ideas_pagina.dart';
import 'package:ideapp/idea/presentacion/ideas_pagina.dart';
import 'package:ideapp/inyectar_dependencias.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await iniciarDependencias();

  runApp(const MainApp());
}

final _router = GoRouter(
  initialLocation: '/ideas',
  routes: [
    GoRoute(
      path: '/api-list',
      builder: (context, state) => const GenerarIdeasPagina(),
    ),
    GoRoute(
      path: '/ideas',
      builder: (context, state) => const IdeasPagina(),
      routes: [
        GoRoute(
          path: ':ideaId',
          builder: (context, state) => const Placeholder(),
        ),
      ],
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<IdeaCubit>()..obtenerIdeas()),
        BlocProvider(create: (_) => sl<ApiCubit>()),
      ],
      child: MaterialApp.router(routerConfig: _router),
    );
  }
}
