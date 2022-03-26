import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_test/modules/business_screen.dart';
import 'package:json_test/modules/science_screen.dart';
import 'package:json_test/modules/sports_screen.dart';
import 'package:json_test/shared/cubit/states.dart';
import 'package:json_test/shared/network/remote/dio_helper.dart';


// main cubit for App
class NewCubit extends Cubit<NewsStates>{
  NewCubit() :super(NewsInitialStates());
  static NewCubit get(context)=>BlocProvider.of(context);

  int currentIndex=0;
  List <BottomNavigationBarItem> bottomItem =[
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

  void changeBottom(int index){
    currentIndex =index;
    if(index==1) getSports();
    if(index==2) getScience();
    emit(NewsBottomNavStates());
  }
  List <Widget> screens =[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  List <dynamic> business=[];
  void getBusiness() {
    emit(NewsGetBusinessLoadingStates());
    if (business.length == 0) {
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country': 'eg',
            'category': 'business',
            'apiKey': '514602fe835b4da38c4b7895e731e15e',
          }
      ).then((value) {
        business = value.data['articles'];
        print(business[0]['titles']);
        emit(NewsGetBusinessSuccessStates());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetBusinessErrorStates(error.toString()));
      });
    }
    else{
      emit(NewsGetBusinessSuccessStates());
    }
  }

  List <dynamic> sports =[];
  void getSports (){
    emit(NewsGetSportsLoadingStates());
    if (sports.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'country': 'eg',
            'category': 'sports',
            'apiKey': '514602fe835b4da38c4b7895e731e15e',
          }
      ).then((value) {
        sports=value.data['articles'];
        print(sports [0]['title']);
        emit(NewsGetSportsSuccessStates());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorStates(error.toString()));
      });
    }
    else{
      emit(NewsGetSportsSuccessStates());
    }

  }


  List <dynamic> science =[];
  void getScience(){
    emit(NewsGetScienceLoadingStates());
    if (science.length==0){
      DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country':'eg',
            'category':'science',
            'apiKey':'514602fe835b4da38c4b7895e731e15e',
          }
      ).then((value){
        science =value.data['articles'];
        print(science[0]['titles']);
        emit(NewsGetScienceSuccessStates());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorStates(error.toString()));
      });
    }else {
      emit(NewsGetScienceSuccessStates());
    }

  }

}