import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_test/shared/cubit/appcubit.dart';
import 'package:json_test/shared/cubit/cubit.dart';
import 'package:json_test/shared/cubit/states.dart';



class NewLayout extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<NewCubit , NewsStates>(
        listener:(context ,state ){},
        builder:(context ,state ){
          var cubit=NewCubit.get(context);
          return  Scaffold(
            appBar: AppBar(
              title: Text(
                ' WORLD NEWS ',
              ),
              actions: [
                IconButton(
                    onPressed: (){
                      AppCubit.get(context).changeAppMode();
                    },
                    icon: Icon(
                      Icons.brightness_4_outlined ,
                    )),
              ],
            ),
            body: cubit.screens[cubit.currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              items:cubit.bottomItem,
              currentIndex: cubit.currentIndex,
              onTap: (index){
                cubit.changeBottom(index);
              },
            ),
          );
        },
    );
  }
}
