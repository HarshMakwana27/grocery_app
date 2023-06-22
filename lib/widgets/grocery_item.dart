import 'package:flutter/material.dart';
import 'package:grocery_app/model/grocery_item.dart';

class GroceryItemRow extends StatelessWidget {
  const GroceryItemRow(this.item, {super.key});

  final GroceryItem item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      leading: Icon(
        Icons.square,
        color: item.category.color,
      ),
      title: Text(
        item.name,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.onBackground),
      ),
      onTap: () => {},
      trailing: Text(
        item.quantity.toString(),
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
    );
  }
}
