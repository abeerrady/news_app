import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/news_app/network/local/chach_helper.dart';
import 'package:news_app/news_app/network/remote/dio_helper.dart';
import 'package:news_app/news_app/news_layout.dart';
import 'news_app/cubit/app_cubit.dart';
import 'news_app/cubit/app_states.dart';
import 'news_app/cubit/cubit.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {

  final bool isDark;
  MyApp(this.isDark);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NewsCubit()..getBusiness()..getSports()..getScience(),),
        BlocProvider(  create: (BuildContext context) => AppCubit()..changeAppMode(
    fromShared: isDark,)),
      ],
      child: BlocConsumer<AppCubit , AppStates>(
        listener: (context , state){},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark
                  ),
                  elevation: 0,
                  backgroundColor: Colors.white,
                  titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black,
                  )
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                elevation: 20,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black
                ),
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepOrange,
              ),
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                  backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: HexColor('333739'),
                      statusBarIconBrightness: Brightness.light
                  ),
                  elevation: 0,
                  backgroundColor: HexColor('333739'),
                  titleTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.white,
                  )
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20,
                backgroundColor: HexColor('333739'),
              ),

              textTheme: TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                ),
              ),
            ),
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayoutScreen(),
          );
        },
      ),
    );
  }
}

