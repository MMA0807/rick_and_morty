import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit(ThemeMode themeMode) : super(ThemeState(themeMode: themeMode));

  void toggleTheme(bool isLight) {
    final themeMode = isLight ? ThemeMode.dark : ThemeMode.light;

    emit(state.copyWith(themeMode: themeMode));
  }
}
