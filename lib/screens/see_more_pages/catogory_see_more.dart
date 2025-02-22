import 'package:flutter/material.dart';
import 'package:petapp/static_data/data.dart';

class CategorySeeMorePage extends StatelessWidget {
  const CategorySeeMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
            tag: 'Categories',
            child: Material(
                child: Text(
              "Categories",
              style:  Theme.of(context).textTheme.headlineMedium,
            ))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            petCategories.length,
            (index) {
              return Card(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: Image.asset(categoryimages[index]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(petCategories[index]),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
