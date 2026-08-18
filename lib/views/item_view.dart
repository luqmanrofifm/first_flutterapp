import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/item_viewmodel.dart';

class ItemView extends StatelessWidget {
  const ItemView({super.key});

  void _showEditDialog(BuildContext context, String id, String currentName) {
    final controller = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Edit Item'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'Nama baru'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ItemViewModel>().updateItem(id, controller.text);
              Navigator.pop(ctx);
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final viewModel = context.watch<ItemViewModel>(); // Mendengarkan perubahan data

    return Scaffold(
      appBar: AppBar(title: const Text('CRUD Sederhana (MVVM)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- FORM CREATE ---
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Item Baru',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<ItemViewModel>().addItem(textController.text, '');
                    textController.clear();
                  },
                  child: const Text('Tambah'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // --- LIST READ, UPDATE, DELETE ---
            Expanded(
              child: viewModel.items.isEmpty
                  ? const Center(child: Text('Belum ada data'))
                  : ListView.builder(
                itemCount: viewModel.items.length,
                itemBuilder: (context, index) {
                  final item = viewModel.items[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _showEditDialog(context, item.id, item.name),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => context.read<ItemViewModel>().deleteItem(item.id),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}