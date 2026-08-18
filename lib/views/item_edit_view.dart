import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item.dart';
import '../viewmodels/item_viewmodel.dart';

class ItemEditView extends StatefulWidget {
  final Item item;

  const ItemEditView({super.key, required this.item});

  @override
  State<ItemEditView> createState() => _ItemEditViewState();
}

class _ItemEditViewState extends State<ItemEditView> {
  late TextEditingController _nameController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    // Isi TextField dengan data awal item yang diedit
    _nameController = TextEditingController(text: widget.item.name);
    _descController = TextEditingController(text: widget.item.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _updateData() {
    final newName = _nameController.text;
    final newDesc = _descController.text;

    if (newName.isEmpty) return;

    // 1. Eksekusi fungsi update di ViewModel
    context.read<ItemViewModel>().updateItem(widget.item.id, newName, newDesc);

    // 2. Tutup halaman edit & kembali ke halaman sebelumnya
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Item',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Item',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateData,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Simpan Perubahan'),
            ),
          ],
        ),
      ),
    );
  }
}