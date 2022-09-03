import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weki/models/user/user_model.dart';
import 'package:weki/modules/register/cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  bool isPassword = true;
  IconData suffix = Icons.visibility;

  changePasswordVisibility() {
    isPassword = !isPassword;
    isPassword ? suffix = Icons.visibility : suffix = Icons.visibility_off;
    emit(RegisterChangeIconState());
  }

  userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      createUser(name: name, email: email, uId: value.user!.uid, phone: phone);
      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(RegisterFailureState(error.toString()));
    });
  }

  createUser({
    required String name,
    required String email,
    required String uId,
    required String phone,
  }) {
    UserModel model = UserModel(
      email: email,
      phone: phone,
      uId: uId,
      name: name,
      isEmailVerified: false,
      image:
          "https://img.freepik.com/free-photo/excited-happy-young-pretty-woman_171337-2005.jpg?w=740&t=st=1662053221~exp=1662053821~hmac=eae04ec0ca79550c2980c3ae952c870ceeb9b976040865bceb19c68638af4a29",
      cover:
          "https://img.freepik.com/free-photo/excited-happy-young-pretty-woman_171337-2005.jpg?w=740&t=st=1662053221~exp=1662053821~hmac=eae04ec0ca79550c2980c3ae952c870ceeb9b976040865bceb19c68638af4a29",
      bio: "Write your bio....",
    );
    FirebaseFirestore.instance
        .collection("users")
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(RegisterCreateUserSuccessState(uId));
    }).catchError((error) {
      print(error.toString());
      emit(RegisterCreateUserFailureState(error.toString()));
    });
  }
}
