class PetModel {
  final String id;
  final String? name;
  final double? age;
  final double? price;
  final String? imageUrl;
  final String? breed;
  final double? weight;
  final String? description;
  final String? location;
  final String? petType; 
  final bool adopted;
  final DateTime? time;

  PetModel({
    required this.id,
    this.name,
    this.age,
    this.price,
    this.imageUrl,
    this.breed,
    this.weight,
    this.description,
    this.location,
    this.petType, 
    this.adopted = false,
    this.time,
  });
}
