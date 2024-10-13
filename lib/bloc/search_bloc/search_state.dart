import 'package:petapp/models/pet_model.dart';
import 'package:equatable/equatable.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}
class SearchEmpty extends SearchState {}

class SearchLoaded extends SearchState {
  final List<PetModel> filteredPets;
  const SearchLoaded(this.filteredPets);
  
  @override
  List<Object> get props => [filteredPets];
}

class SearchError extends SearchState {
  final String? errorMesage;
  const SearchError(this.errorMesage);
}
