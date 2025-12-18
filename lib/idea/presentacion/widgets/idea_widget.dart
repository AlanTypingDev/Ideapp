import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ideapp/idea/dominio/entidades/idea_entidad.dart';
import 'package:ideapp/idea/presentacion/cubit/idea_cubit.dart';
import 'package:intl/intl.dart';

class IdeaWidget extends StatelessWidget {
  final IdeaEntidad idea;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const IdeaWidget({
    super.key,
    required this.idea,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isComplete = idea.estado == IdeaEstado.completa;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              // Checkbox estilo TODO
              _CheckboxIndicator(
                initialValue: isComplete,
                onChanged: (checked) async {
                  final nuevoEstado = checked
                      ? IdeaEstado.completa
                      : IdeaEstado.incompleta;

                  // Construyo una nueva entidad (uso copyWith si existe)
                  final updated = idea.copyWith(estado: nuevoEstado);

                  // Llamo al cubit para persistir el cambio
                  context.read<IdeaCubit>().actualizarIdea(updated);
                },
              ),

              const SizedBox(width: 12),

              // Info
              Expanded(
                child: _IdeaInfo(idea: idea, theme: theme),
              ),

              // Fecha compacta y menú
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatDate(idea.creadaEn),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 6),
                  _ThreeDotsMenu(idea: idea),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM • HH:mm').format(date);
  }
}

/// Checkbox personalizado con ripple y tamaño fijo
class _CheckboxIndicator extends StatelessWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const _CheckboxIndicator({
    required this.initialValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () => onChanged(!initialValue),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: initialValue
              ? const Icon(
                  Icons.check_box,
                  key: ValueKey('checked'),
                  color: Colors.amber,
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  key: ValueKey('unchecked'),
                  color: Colors.grey,
                ),
        ),
      ),
    );
  }
}

/// Menú de los tres puntitos con acción de eliminar (con confirmación)
class _ThreeDotsMenu extends StatelessWidget {
  final IdeaEntidad idea;

  const _ThreeDotsMenu({required this.idea});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_MenuAction>(
      onSelected: (action) async {
        switch (action) {
          case _MenuAction.delete:
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Eliminar idea'),
                content: const Text(
                  '¿Seguro querés eliminar esta idea? Esta acción no se puede deshacer.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(false),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(true),
                    child: const Text('Eliminar'),
                  ),
                ],
              ),
            );

            if (confirmed == true) {
              context.read<IdeaCubit>().eliminarIdea(idea.id);
            }
            break;
          case _MenuAction.edit:
            // Si querés soporte para editar título, lo agregamos.
            break;
        }
      },
      itemBuilder: (_) => <PopupMenuEntry<_MenuAction>>[
        const PopupMenuItem(value: _MenuAction.delete, child: Text('Eliminar')),
        // Puedes activar editar si tenés UI para eso
        // const PopupMenuItem(value: _MenuAction.edit, child: Text('Editar')),
      ],
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Icon(Icons.more_vert, size: 20),
      ),
    );
  }
}

enum _MenuAction { delete, edit }

class _IdeaInfo extends StatefulWidget {
  final IdeaEntidad idea;
  final ThemeData theme;

  const _IdeaInfo({required this.idea, required this.theme});

  @override
  State<_IdeaInfo> createState() => _IdeaInfoState();
}

class _IdeaInfoState extends State<_IdeaInfo> {
  bool abierto = false;
  @override
  Widget build(BuildContext context) {
    final isComplete = widget.idea.estado == IdeaEstado.completa;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              abierto = !abierto;
            });
          },
          child: Text(
            widget.idea.titulo,
            style: widget.theme.textTheme.titleMedium?.copyWith(
              decoration: isComplete
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: isComplete ? Colors.grey : null,
            ),
            maxLines: abierto ? 20 : 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Icon(
              isComplete ? Icons.check_circle : Icons.circle_outlined,
              size: 14,
              color: isComplete ? Colors.green : Colors.grey,
            ),
            const SizedBox(width: 8),
            Text(
              isComplete ? 'Completada' : 'Incompleta',
              style: widget.theme.textTheme.bodySmall?.copyWith(
                color: isComplete ? Colors.green : Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
