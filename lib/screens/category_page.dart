import 'package:flutter/material.dart';
import 'package:petapp/screens/details_page.dart';
import 'package:petapp/static_data/data.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key, required this.petType});
  final String petType;

  @override
  Widget build(BuildContext context) {
    // Filter the pets based on petType
    final filteredPets = listOfPetsGeneral
        .where((pet) => pet.petType?.toLowerCase() == petType.toLowerCase())
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: petType,
          child: Text(
            petType,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredPets.length,
              itemBuilder: (context, index) {
                return InkWell(onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return DetailsPage(petModel:listOfPetsGeneral.firstWhere((t)=>t.id==filteredPets[index].id) );
                  },));
                },
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: Hero(
                              tag:filteredPets[index].id,
                              child: Image.asset(filteredPets[index].imageUrl!)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(filteredPets[index].name!),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
