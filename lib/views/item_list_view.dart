import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/item_viewmodel.dart';
import 'item_create_view.dart';
import 'item_detail_view.dart'; // Import halaman detail

class ItemListView extends StatelessWidget {
  const ItemListView({super.key});

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
              // Tombol panah menuju detail
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              // Action ketika baris item di-klik
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