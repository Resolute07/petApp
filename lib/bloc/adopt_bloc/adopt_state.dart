
abstract class AdoptionState {}

class InitialAdoptionState extends AdoptionState {}

class AdoptedPetsState extends AdoptionState {
  final List<Map<String, String>> adoptedPets;

  AdoptedPetsState({required this.adoptedPets});
}
