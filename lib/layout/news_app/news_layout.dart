import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/layout/news_app/cubit/cubit.dart';
import 'package:news/layout/news_app/cubit/states.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit= NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News App',
            ),
            actions: [
             IconButton(
                 onPressed: (){},
                 icon: Icon(
                   Icons.search,
                 ),
             ),
              IconButton(
                onPressed: (){
                  NewsCubit.get(context).changeAppMode();
                },
                icon: Icon(
                  Icons.brightness_4_outlined,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentindex,
            items:cubit.bottomItems ,
            onTap: (index){
            cubit.ChangeBottomNavBar(index);
            },
          ),

        );
      },
    );
  }
}