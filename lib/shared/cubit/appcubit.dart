import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_test/shared/cubit/states.dart';
import 'package:json_test/shared/network/local/cache_helper.dart';


// cubit for theme
class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(AppInitialStates());

  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark=false;
  void changeAppMode({bool fromShared})
  {
    if(fromShared != null){
      isDark=fromShared;
      emit(AppChangeModeStates());
    }else{
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark
      ).then((value) {
        emit(AppChangeModeStates());
      });
    }

  }
}

