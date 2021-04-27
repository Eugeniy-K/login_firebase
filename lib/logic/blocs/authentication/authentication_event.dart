part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  const AuthenticationUserChanged(this.user);

  final UserModel user;

  @override
  List<Object> get props => [user];
}

class SignUpUserAddedEvent extends AuthenticationEvent {
  final UserModel user;

  SignUpUserAddedEvent(this.user);
}

class AuthenticationLogoutRequested extends AuthenticationEvent {}