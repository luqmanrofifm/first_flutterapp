import 'package:first_app/views/item_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/item_viewmodel.dart';
import 'views/item_view.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ItemViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ItemListView(),
    );
  }
}