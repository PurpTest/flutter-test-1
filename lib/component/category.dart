import 'package:flutter/material.dart';
import 'package:product_list/cubit/product_list_cubit.dart';
import 'package:product_list/model/category_model.dart';

class Category extends StatefulWidget {
  final List<String> category;
  final ProductListCubit cubit;
  const Category({super.key, required this.cubit, required this.category});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  String? _selectedCategory;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Produts'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Category',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: _selectedCategory,
              hint: const Text('Select Category'),
              isExpanded: true,
              items: [
                const DropdownMenuItem(
                    value: null, child: Text('All Categories')),
                ...widget.category.map((category) {
                  return DropdownMenuItem(
                      value: category, child: Text(category));
                }).toList(),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            widget.cubit.resetFilters();
            Navigator.pop(context);
          },
          child: Text("Reset"),
        ),
        TextButton(
          onPressed: () {
            final criteria = FilterCriteria(category: _selectedCategory);
            widget.cubit
                .filterProducts(widget.cubit.searchQuery, criteria: criteria);
            Navigator.pop(context);
          },
          child: const Text("Filter"),
        ),
      ],
    );
  }
}
