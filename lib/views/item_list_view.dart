import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/item_viewmodel.dart';
import 'item_create_view.dart';
import 'item_detail_view.dart';
import 'item_edit_view.dart';

class ItemListView extends StatelessWidget {
  const ItemListView({super.key});

  // Fungsi untuk menampilkan Pop-up Dialog Konfirmasi Hapus
  void _showDeleteDialog(BuildContext context, String id, String itemName) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hapus Item'),
        content: Text('Apakah Anda yakin ingin menghapus "$itemName"?'),
        actions: [
          // Tombol Batal
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          // Tombol Hapus (Action Delete)
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              // 1. Eksekusi hapus di ViewModel
              context.read<ItemViewModel>().deleteItem(id);
              // 2. Tutup pop-up dialog
              Navigator.pop(ctx);
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ItemViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Item')),
      body: viewModel.items.isEmpty
          ? const Center(child: Text('Belum ada data'))
          : ListView.builder(
        itemCount: viewModel.items.length,
        itemBuilder: (context, index) {
          final item = viewModel.items[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              title: Text(item.name),
              subtitle: Text(
                item.description,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tombol Edit
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ItemEditView(item: item),
                        ),
                      );
                    },
                  ),
                  // Tombol Delete (Memicu Dialog Pop-up)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _showDeleteDialog(context, item.id, item.name);
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ItemDetailView(item: item),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ItemCreateView()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}