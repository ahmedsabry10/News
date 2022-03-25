import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:json_test/new_layout.dart';
import 'package:json_test/shared/cubit/appcubit.dart';
import 'package:json_test/shared/cubit/cubit.dart';
import 'package:json_test/shared/cubit/states.dart';
import 'package:json_test/shared/network/local/cache_helper.dart';
import 'package:json_test/shared/network/remote/dio_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark=CacheHelper.getBoolean(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create:
            (context)=>NewCubit()..getBusiness()),
        BlocProvider(create: (BuildContext context)=>AppCubit()..changeAppMode(
          fromShared: isDark,
        ),)
      ],

            child: BlocConsumer< AppCubit ,AppStates>(
            listener: (context ,state){},
            builder: (context ,state){
              return  MaterialApp(
                title: 'Flutter Demo',
                theme: ThemeData(
                    primarySwatch: Colors.deepOrange,
                    scaffoldBackgroundColor:Colors.white,
                    appBarTheme: AppBarTheme(
                      titleSpacing: 20.0,
                        backgroundColor: Colors.white,
                        elevation: 0.0,
                        backwardsCompatibility: false,
                  systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  statusBarColor: Colors.white,
                  ),
                        titleTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        iconTheme: IconThemeData(
                          color: Colors.black,
                        )
                    ),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      backgroundColor: Colors.white,
                    ),
                    textTheme: TextTheme(
                        bodyText1: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )
                    )
                ),

                // Dark theme
                darkTheme: ThemeData(
                   scaffoldBackgroundColor: HexColor('333739'),
                    primarySwatch: Colors.deepOrange,
                    backgroundColor: HexColor('333739'),
                    appBarTheme: AppBarTheme(
                      backgroundColor:  HexColor('333739'),
                      titleSpacing: 20.0,
                      backwardsCompatibility: false,
                      elevation: 0.0,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.light,
                        statusBarColor: HexColor('333739'),
                      ),
                      titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      iconTheme: IconThemeData(
                        color: Colors.white,
                      ),
                    ),
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      unselectedItemColor: Colors.grey,
                      backgroundColor: HexColor('333739'),
                    ),
                    textTheme: TextTheme(
                        bodyText1: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,

                        )
                    )
                ),
                themeMode:AppCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light,
                home: NewLayout(),
                debugShowCheckedModeBanner: false,
              );
            }
          ),

        );
  }
}


