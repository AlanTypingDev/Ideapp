import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ideapp/common/estado.dart';
import 'package:ideapp/common/snackbar.dart';
import 'package:ideapp/idea/presentacion/api_cubit/api_cubit.dart';
import 'package:ideapp/idea/presentacion/api_cubit/api_state.dart';
import 'package:ideapp/idea/presentacion/cubit/idea_cubit.dart';

class GenerarIdeasPagina extends StatefulWidget {
  const GenerarIdeasPagina({super.key});

  @override
  State<GenerarIdeasPagina> createState() => _GenerarIdeasPaginaState();
}

class _GenerarIdeasPaginaState extends State<GenerarIdeasPagina> {
  String? _selectedIdea;

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<ApiCubit>().generarNuevasIdeas(
        "Idea random para hacer. Máximo 25 palabras. NO repitas jardinería, cocinar ni lectura. Entrega UNA idea original, concreta y distinta en <=25 palabras.",
      ),
    );
  }

  void _regenerarIdeas() {
    setState(() => _selectedIdea = null);
    context.read<ApiCubit>().generarNuevasIdeas(
      "Genera UNA sola idea original y concreta para hacer ahora. Máximo 25 palabras. Prohibido: jardinería, cocinar, leer (y sin sinónimos). No des explicaciones ni listas. Entrega solo la idea.",
    );
  }

  void _toggleIdea(String idea) {
    setState(() {
      _selectedIdea = (_selectedIdea == idea) ? null : idea;
    });
  }

  void _guardarIdea(BuildContext context) {
    if (_selectedIdea == null) {
      snackBar(context, "Seleccione una idea primero.");
      return;
    }
    context.read<IdeaCubit>().guardarIdea(_selectedIdea!);
    snackBar(context, "Idea guardada ✅");
    context.go("/ideas");
  }

  Widget _buildIdeaTile(String idea, bool selected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: selected ? Colors.amber.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: selected
                ? Colors.amber.withOpacity(0.2)
                : Colors.black.withOpacity(0.03),
            blurRadius: selected ? 10 : 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        title: Text(idea, style: const TextStyle(fontSize: 16, height: 1.3)),
        leading: Icon(
          selected ? Icons.check_circle : Icons.circle_outlined,
          color: selected ? Colors.green.shade700 : Colors.grey.shade400,
        ),

        onTap: () => _toggleIdea(idea),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go("/ideas"),
        ),
        title: const Text("Generar ideas"),
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(16),

        child: BlocConsumer<ApiCubit, ApiState>(
          listener: (context, state) {
            if (state.estado == Estado.error) {
              snackBar(context, state.error ?? 'Error desconocido');
            }
          },
          builder: (context, state) {
            final ideas = state.ideas ?? [];
            final estado = state.estado;

            if (estado == Estado.cargando) {
              return const Center(child: CircularProgressIndicator());
            }

            if (estado == Estado.error && ideas.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('No se pudieron obtener ideas.'),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _regenerarIdeas,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                    ),
                  ],
                ),
              );
            }

            if (ideas.isEmpty) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('No hay ideas por ahora.'),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: _regenerarIdeas,
                      icon: const Icon(Icons.lightbulb),
                      label: const Text('Generar ideas'),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                // Header / instrucción
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      const Icon(Icons.lightbulb_outline, color: Colors.amber),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Elige una idea. Tap en una card para seleccionar. También podés copiarla.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // IMPORTANT: Expanded envuelve al RadioGroup para dar altura finita al ListView
                Expanded(
                  child: RadioGroup<String>(
                    groupValue: _selectedIdea,
                    onChanged: (value) {
                      if (value != null) _toggleIdea(value);
                    },
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: ideas.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final idea = ideas[index];
                        final selected = idea == _selectedIdea;
                        return _buildIdeaTile(idea, selected);
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Botón regenerar abajo de la lista
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _regenerarIdeas,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Regenerar ideas'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Acción principal (Elegir y guardar)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _selectedIdea == null
                              ? null
                              : () => _guardarIdea(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            _selectedIdea == null ? 'Elegir idea' : 'Guardar',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 38),
              ],
            );
          },
        ),
      ),
    );
  }
}
