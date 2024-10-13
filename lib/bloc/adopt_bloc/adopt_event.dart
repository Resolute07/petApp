


abstract class AdoptionEvent {}

class AdoptPetEvent extends AdoptionEvent {
  final String petName;
  final String id;

  AdoptPetEvent({required this.petName, required this.id});
}

class LoadAdoptedPetsEvent extends AdoptionEvent {}
