import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news/layout/news_app/cubit/cubit.dart';
import 'package:news/layout/news_app/cubit/states.dart';
import 'package:news/layout/news_app/news_layout.dart';
import 'package:news/shared/bloc_observer.dart';
import 'package:news/shared/cubit/cubit.dart';
import 'package:news/shared/cubit/states.dart';
import 'package:news/shared/network/local/cache_helper.dart';
import 'package:news/shared/network/remote/dio_helper.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getBoolean(key:'isDark');
  BlocOverrides.runZoned(
        () {
          DioHelper.init();

      runApp( MyApp(isDark!));
    },
    blocObserver: MyBlocObserver(),
  );



}
class MyApp extends StatelessWidget{

  final bool isDark;
  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
  return BlocProvider(
    create: (BuildContext context)=>NewsCubit()..getBusiness()..getSports()..getscience()..changeAppMode(
      fromShared: isDark,
    ),
    child: BlocConsumer<NewsCubit,NewsStates>(
      listener: (context ,state){},
      builder: (context,state){
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,
            ),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: AppBarTheme(
              centerTitle: true,
              actionsIconTheme: IconThemeData(
                color: Colors.black,
              ),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,

              ),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark,
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,

            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              elevation: 20.0,
            ),
            textTheme:TextTheme(
              bodyText1:TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),

            ),

          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor:HexColor('333739'),
            primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(


              actionsIconTheme: IconThemeData(
                color: Colors.white,
              ),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,

              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: HexColor('333739'),
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: HexColor('333739'),
              elevation: 0.0,

            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: HexColor('333739'),
            ),
            textTheme:TextTheme(
              bodyText1:TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),

            ),


          ),
          themeMode: NewsCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          home: Directionality(
            textDirection: TextDirection.ltr,
            child: NewsLayout(),
          ),
        );
      },
    ),
  );
  }

}