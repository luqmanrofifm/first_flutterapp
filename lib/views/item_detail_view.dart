import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../viewmodels/item_viewmodel.dart';
import 'item_edit_view.dart'; // Import Halaman Edit

class ItemDetailView extends StatelessWidget {
  final Item item;

  const ItemDetailView({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // Ambil data terbaru dari List ViewModel berdasarkan ID
    final viewModel = context.watch<ItemViewModel>();
    final currentItem = viewModel.items.firstWhere(
          (element) => element.id == item.id,
      orElse: () => item,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Item'),
        actions: [
          // Tombol Edit di AppBar Halaman Detail
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemEditView(item: currentItem),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nama Item:',
              style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              currentItem.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const Divider(height: 32, thickness: 1),

            const Text(
              'Deskripsi:',
              style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              currentItem.description.isEmpty ? '(Tidak ada deskripsi)' : currentItem.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}