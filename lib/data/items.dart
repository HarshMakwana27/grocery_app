import 'package:grocery_app/data/categories.dart';
import 'package:grocery_app/model/categories.dart';
import 'package:grocery_app/model/grocery_item.dart';

final items = [
  GroceryItem(
      id: '1',
      name: 'Milk',
      quantity: 5,
      category: categories[Categories.dairy]!),
  GroceryItem(
      id: '2',
      name: 'Maggie',
      quantity: 5,
      category: categories[Categories.spices]!),
];
