import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/layout/cubit/states.dart';
import 'package:weki/models/user/user_model.dart';
import 'package:weki/shared/components/constants.dart';
import 'package:weki/shared/network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  UserModel? userModel;

  getUserData() {
    emit(AppGetDataLoadingState());
    FirebaseFirestore.instance.collection("users").doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data()!);
      emit(AppGetDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetDataFailureState(error.toString()));
    });
  }
}
