import 'package:flutter/material.dart';
import 'vms.dart';

class PantallaCantor extends StatefulWidget {
  const PantallaCantor({super.key, required this.crearVm});
  final CantorVm Function() crearVm;

  @override
  State<PantallaCantor> createState() => _PantallaCantorState();
}

class _PantallaCantorState extends State<PantallaCantor> {
  late final CantorVm vm = widget.crearVm();

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: vm,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Cantor')),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (vm.sala == null)
                FilledButton(
                  onPressed: vm.crear,
                  child: const Text('Crear sala'),
                )
              else ...[
                Center(
                  child: Text(
                    'Código: ${vm.sala!.id}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const Center(child: Text('Compártelo con tus jugadores')),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: vm.cantar,
                  child: const Text('Cantar la siguiente carta'),
                ),
                SwitchListTile(
                  title: const Text('Cantar automáticamente cada 6 s'),
                  subtitle: const Text('Mantén esta pantalla abierta'),
                  value: vm.automatico,
                  onChanged: (_) => vm.alternarAutomatico(),
                ),
              ],
              if (vm.mensaje != null)
                Text(vm.mensaje!, style: const TextStyle(color: Colors.red)),
              const Divider(),
              for (final c in vm.cantadas) Text(c),
            ],
          ),
        );
      },
    );
  }
}
