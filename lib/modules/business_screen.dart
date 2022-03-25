import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_test/components/component.dart';
import 'package:json_test/shared/cubit/cubit.dart';
import 'package:json_test/shared/cubit/states.dart';

class BusinessScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewCubit ,NewsStates>(
        listener:(context ,state){} ,
      builder:(context ,state) {
          var list=NewCubit.get(context).business;
        return articleBuilder(list ,context);
      }
      );
  }
}
