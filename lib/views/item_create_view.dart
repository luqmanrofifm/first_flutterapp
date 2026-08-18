import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/item_viewmodel.dart';

class ItemCreateView extends StatefulWidget {
  const ItemCreateView({super.key});

  @override
  State<ItemCreateView> createState() => _ItemCreateViewState();
}

class _ItemCreateViewState extends State<ItemCreateView> {
  // Controller untuk membaca isi inputan teks
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  void _saveData() {
    final name = _nameController.text;
    final desc = _descController.text;

    if (name.isEmpty) return;

    // 1. Eksekusi fungsi simpan ke ViewModel
    context.read<ItemViewModel>().addItem(name, desc);

    // 2. Tutup halaman ini & balik ke halaman sebelumnya
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Baru'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Nama
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nama Item',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Input Deskripsi
            TextField(
              controller: _descController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Item',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Simpan
            ElevatedButton(
              onPressed: _saveData,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}