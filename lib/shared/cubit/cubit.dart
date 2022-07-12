import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/shared/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

ThemeMode appmode =ThemeMode.dark;
bool isDark = false;
void changeAppMode(){
  isDark = !isDark;
  emit(AppChangeModeState());
}
}