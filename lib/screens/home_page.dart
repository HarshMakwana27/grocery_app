import 'package:flutter/material.dart';

import 'package:grocery_app/model/grocery_item.dart';
import 'package:grocery_app/screens/new_item_screen.dart';
import 'package:grocery_app/theme/theme.dart';
import 'package:grocery_app/widgets/grocery_item.dart';

import 'package:http/http.dart' as http;

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var items = [];

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItemScreen(),
      ),
    );
    final url = Uri.https(
        'groceryapp-5128d-default-rtdb.firebaseio.com', 'shopping-list.json');

    final response = await http.get(url);

    print(response.body);

    if (newItem == null) {
      return null;
    }
    setState(() {
      items.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      items.remove(item);
    });
    _undo(item);
  }

  void _undo(GroceryItem item) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: TextButton(
          onPressed: () {
            setState(() {
              items.add(item);
            });

            ScaffoldMessenger.of(context).clearSnackBars();
          },
          child: const Text('Undo'),
        ),
      ),
    );
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
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            return Dismissible(
              background: Container(
                color: darkTheme.colorScheme.error,
              ),
              onDismissed: (direction) {
                _removeItem(items[index]);
              },
              key: ValueKey(items[index]),
              child: GroceryItemRow(items[index]),
            );
          }),
    );
  }
}
