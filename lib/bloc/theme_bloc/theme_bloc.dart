import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:petapp/bloc/theme_bloc/theme_events.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(ThemeMode.light)) {
    on<ToggleThemeEvent>((event, emit) {
    
      emit(ThemeState(event.isDarkMode ? ThemeMode.dark : ThemeMode.light));
    });
  }
}
