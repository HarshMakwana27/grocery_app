import 'package:flutter/material.dart';
import 'package:grocery_app/data/items.dart';
import 'package:grocery_app/screens/new_item_screen.dart';
import 'package:grocery_app/widgets/grocery_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  void _addItem() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewItemScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Grocery List'),
        actions: [
          IconButton(onPressed: _addItem, icon: const Icon(Icons.add)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          for (final item in items) GroceryItemRow(item),
        ]),
      ),
    );
  }
}
