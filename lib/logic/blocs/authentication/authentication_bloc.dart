import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_firebase/models/user.dart';
import 'package:login_firebase/repositories/authentication_repository.dart';
import 'package:meta/meta.dart';
import 'package:pedantic/pedantic.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const AuthenticationState.unknown()) {
    _userSubscription = _authenticationRepository.user.listen(
          (user) => add(AuthenticationUserChanged(user)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  late StreamSubscription<UserModel> _userSubscription;
  StreamSubscription? _usersFirebaseSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is AuthenticationUserChanged) {
      UserModel? user = await _authenticationRepository.checkUsers(event.user);
      yield _mapAuthenticationUserChangedToState(event.user, user);
    }
    if (event is SignUpUserAddedEvent) {
      yield _mapSignUpUserAdded(event.user);
    }
    else if (event is AuthenticationLogoutRequested) {
      unawaited(_authenticationRepository.logOut());
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _usersFirebaseSubscription?.cancel();
    return super.close();
  }

  AuthenticationState _mapAuthenticationUserChangedToState(
      UserModel? currentUser, UserModel? fireUser)  {
    if (currentUser != UserModel.empty) {
      if (fireUser != null)
        return AuthenticationState.authenticated(fireUser);
      return AuthenticationState.justauth(currentUser!);
    } else
      return AuthenticationState.unauthenticated();

    // return user != User.empty
    //     ? AuthenticationState.authenticated(user)
    //     : const AuthenticationState.unauthenticated();
  }


  bool checkUserId(List<UserModel> users, UserModel user) {
    for (int i = 0; i < users.length; i++) {
      if (users[i].id == user.id)
        return true;
    }
    return false;
  }

  UserModel? getUserId(List<UserModel> users, UserModel user) {
    for (int i = 0; i < users.length; i++) {
      if (users[i].id == user.id)
        return users[i];
    }
    return null;
  }

  AuthenticationState _mapSignUpUserAdded(UserModel user) {
    return AuthenticationState.authenticated(user);
  }

}