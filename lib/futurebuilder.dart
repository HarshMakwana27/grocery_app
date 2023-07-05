import 'package:flutter/material.dart';
import 'package:grocery_app/data/categories.dart';
import 'dart:convert';

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
  String? _error;
  var _isLoading = true;
  late Future<List<GroceryItem>> _loadedItems;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

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

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(
        'groceryapp-5128d-default-rtdb.firebaseio.com', 'shopping-list.json');

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch data. Please try again later.');
    }

    if (response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    return loadedItems;
  }

  void _removeItem(GroceryItem item) async {
    final index = items.indexOf(item);
    setState(() {
      items.remove(item);
    });

    final url = Uri.https('groceryapp-5128d-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    final response = await http.delete(url);

    if (response.statusCode >= 400) {
      // Optional: Show error message
      setState(() {
        items.insert(index, item);
      });
    }
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

  Future<void> _refresh() async {
    setState(() {
      _loadItems();
    });
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
      body: FutureBuilder(
        future: _loadedItems,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.data!.isEmpty) {
            return const Center(child: Text("Nothing to show, List is empty"));
          }

          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return Dismissible(
                  background: Container(
                    color: darkTheme.colorScheme.error,
                  ),
                  onDismissed: (direction) {
                    _removeItem(snapshot.data![index]);
                  },
                  key: ValueKey(snapshot.data![index]),
                  child: GroceryItemRow(snapshot.data![index]),
                );
              });
        }),
      ),
    );
  }
}
