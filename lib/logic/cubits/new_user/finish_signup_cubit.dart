import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:login_firebase/entities/user_entity.dart';
import 'package:login_firebase/logic/blocs/authentication/authentication_bloc.dart';
import 'package:login_firebase/logic/cubits/new_user/finish_signup_state.dart';
import 'package:login_firebase/models/user.dart';
import 'package:login_firebase/repositories/authentication_repository.dart';

class FinishSignupCubit extends Cubit<FinishSignupState> {

  FinishSignupCubit()
    : super(const FinishSignupState());

  // final AuthenticationRepository _authenticationRepository;
  // StreamSubscription<User>? _userFirebaseSubscription;

  void userNameChanged(String value) {
    emit(state.copyWith(name: value));
  }

  Future<UserModel?> addNewUser() async {
    if (state.userName == '') return null;
    emit(state.copyWith(status: ProgressStatus.inProgress));
    // emit(state.copyWith(status: FormzStatus.submissionInProgress));
    var fireUser = FirebaseAuth.instance.currentUser;
    var firestoreInstance = FirebaseFirestore.instance;
    UserModel? user = null;

    ///создаём пользователя
    try {
      firestoreInstance.collection('users').doc(fireUser!.uid).set(
          {
            "email": fireUser.email,
            "id": fireUser.uid,
            "name": state.userName,
            "photo": "photo"
          }
      ).then((value) => null);
    } catch (_) {
      Exception('Exception');
    }

    ///получаем созданного пользователя
    await firestoreInstance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.data()['id'] == fireUser?.uid)
          user = UserModel.fromEntity(UserEntity.fromSnapshot(element));
      });
    });
    if (user != null)
      return user;
    else return null;
  }

  @override
  Future<void> close() {
    return super.close();
  }

}