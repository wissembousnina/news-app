import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app/cubit/states.dart';
import 'package:news/modules/business/business.dart';
import 'package:news/modules/science/science.dart';
import 'package:news/modules/settings/settings.dart';
import 'package:news/modules/sports/sports.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context)=>BlocProvider.of(context);
  int currentindex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business,
        ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),


  ];
  List<Widget> screens = [
  BusinessScreen(),
  SportsScreen(),
  ScienceScreen(),

  ];
  void ChangeBottomNavBar(int index){
    currentindex = index;
    if(index == 1)
      getSports();
    if(index==2)
      getscience();
    emit(NewsBottomNavState());
  }
  List<dynamic> business=[];
  void getBusiness(){
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country':'eg',
          'category':'business',
          'apiKey':'9c759fc320594a5f9d6b0f96d71f314e',
        }
    ).then((value) {
      //print(value.data['articles']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print('error when getting data ${error.toString()}');
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }
  List<dynamic> sports=[];
  void getSports(){
    emit(NewsGetSportsLoadingState());
    if(sports.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'sports',
            'apiKey':'9c759fc320594a5f9d6b0f96d71f314e',
          }
      ).then((value) {
        //print(value.data['articles']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print('error when getting data ${error.toString()}');
        emit(NewsGetSportsErrorState(error.toString()));
      });
    }else{
      emit(NewsGetSportsSuccessState());

    }

  }
  List<dynamic> science=[];
  void getscience(){
    emit(NewsGetScienceLoadingState());
    if(science.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country':'eg',
            'category':'science',
            'apiKey':'9c759fc320594a5f9d6b0f96d71f314e',
          }
      ).then((value) {
        //print(value.data['articles']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print('error when getting data ${error.toString()}');
        emit(NewsGetScienceErrorState(error.toString()));
      });

    }else{
      emit(NewsGetScienceSuccessState());

    }

  }
  ThemeMode appmode =ThemeMode.dark;
  bool isDark = false;
  void changeAppMode({bool? fromShared}){
    if(fromShared!= null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }
}