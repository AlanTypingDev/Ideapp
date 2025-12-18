import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ideapp/common/estado.dart';
import 'package:ideapp/common/snackbar.dart';
import 'package:ideapp/idea/dominio/entidades/idea_entidad.dart';
import 'package:ideapp/idea/presentacion/cubit/idea_cubit.dart';
import 'package:ideapp/idea/presentacion/cubit/idea_state.dart';
import 'package:ideapp/idea/presentacion/widgets/idea_widget.dart';

class IdeasPagina extends StatelessWidget {
  const IdeasPagina({super.key});

  Future<void> _onRefresh(BuildContext context) async {
    context.read<IdeaCubit>().obtenerIdeas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis ideas'),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),
        child: BlocConsumer<IdeaCubit, IdeaState>(
          listener: (context, state) {
            if (state.estado == Estado.exito) {
              snackBar(context, state.mensaje ?? "Actualizado con éxito ✅");
            }
          },
          builder: (context, state) {
            final List<IdeaEntidad> ideas = state.ideas;
            final estado = state.estado;

            // ⏳ Loading
            if (estado == Estado.cargando) {
              return const Center(child: CircularProgressIndicator());
            }

            // 🫙 Estado vacío
            if (ideas.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      size: 64,
                      color: Colors.amber.shade300,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Todavía no guardaste ideas',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Generá una idea random y guardá las que te inspiren.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.go('/api-list'),
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text('Generar ideas'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              );
            }

            // 📋 Lista de ideas
            return Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.lightbulb, color: Colors.amber),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Tus ideas guardadas',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),

                // Lista
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => _onRefresh(context),
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: ideas.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) =>
                          IdeaWidget(idea: ideas[index]),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // CTA inferior (reemplaza FAB)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => context.go('/api-list'),
                    icon: const Icon(Icons.add),
                    label: const Text('Generar nuevas ideas'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 50),
              ],
            );
          },
        ),
      ),
    );
  }
}
