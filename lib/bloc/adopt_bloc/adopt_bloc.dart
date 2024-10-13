
import 'package:bloc/bloc.dart';
import 'package:petapp/bloc/adopt_bloc/adopt_event.dart';
import 'package:petapp/bloc/adopt_bloc/adopt_state.dart';
import 'package:intl/intl.dart';

class AdoptionBloc extends Bloc<AdoptionEvent, AdoptionState> {
  List<Map<String, String>> adoptedPets = [];

  AdoptionBloc() : super(InitialAdoptionState()) {
    on<AdoptPetEvent>((event, emit) {
     
      final adoptionTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
      adoptedPets.add({
        'id':event.id,
        'petName': event.petName,
        'adoptedAt': adoptionTime,
      });
      emit(AdoptedPetsState(adoptedPets: List.from(adoptedPets)));
    });

    on<LoadAdoptedPetsEvent>((event, emit) {
      emit(AdoptedPetsState(adoptedPets: adoptedPets));
    });
  }
}
