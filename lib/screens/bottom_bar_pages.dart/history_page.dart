import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petapp/bloc/adopt_bloc/adopt_bloc.dart';
import 'package:petapp/bloc/adopt_bloc/adopt_state.dart';
import 'package:petapp/models/pet_model.dart';
import 'package:petapp/screens/details_page.dart';
import 'package:petapp/static_data/data.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  void _navigateToDetails(BuildContext context, PetModel petDetails) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(petModel: petDetails),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<AdoptionBloc, AdoptionState>(
        builder: (context, state) {
          if (state is AdoptedPetsState && state.adoptedPets.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: state.adoptedPets.length,
              itemBuilder: (context, index) {
                final pet = state.adoptedPets[index];
                final petDetails =
                    listOfPetsGeneral.firstWhere((p) => pet['id'] == p.id);

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DetailsPage(petModel: petDetails);
                        },
                      ),
                    );
                  },
                  child: _buildPetCard(context, pet, petDetails),
                );
              },
            );
          } else {
            return _showNoPetsAdopted();
          }
        },
      ),
    );
  }

  Widget _showNoPetsAdopted() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pets,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          const AnimatedOpacity(
            opacity: 1.0,
            duration: Duration(seconds: 2),
            child: Text(
              "No pets adopted yet.",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPetCard(
      BuildContext context, Map<String, dynamic> pet, PetModel petDetails) {
    return InkWell(
      onTap: () => _navigateToDetails(context, petDetails),
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Hero(
                    tag: pet['id']!,
                    child: Image.asset(
                      petDetails.imageUrl!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.contain,
                      color: Colors.black.withOpacity(0.2),
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        petDetails.name!,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(petDetails.breed ?? "Pup"),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(Icons.calendar_today,
                              size: 16, color: Colors.blueAccent),
                          const SizedBox(width: 8),
                          Text(
                            'Adopted on: ${pet["adoptedAt"].toString()}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
