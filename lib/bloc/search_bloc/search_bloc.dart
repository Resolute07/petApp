
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petapp/bloc/search_bloc/search_event.dart';
import 'package:petapp/bloc/search_bloc/search_state.dart';
import 'package:petapp/models/pet_model.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final List<PetModel> pets;

  SearchBloc(this.pets) : super(SearchInitial()) {
    on<SearchQueryChanged>((event, emit) {
      emit(SearchLoading());

      if (event.query.isEmpty) {
        emit( SearchEmpty());
      } else {
      
       
        
       final filteredPets = pets.where((pet) {
         
          final petName = pet.name?.toLowerCase() ?? '';
          final petBreed = pet.breed?.toLowerCase() ?? '';
          final queryLower = event.query.toLowerCase();

          return petName.contains(queryLower) || petBreed.contains(queryLower);
        });
        if(filteredPets.isEmpty){
          emit(const SearchLoaded( []));
        }
        else{
          emit(SearchLoaded(filteredPets.toList()));
        }
        
      }
    });
  }
}