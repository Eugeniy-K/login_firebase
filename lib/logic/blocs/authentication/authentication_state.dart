part of 'authentication_bloc.dart';

enum AuthenticationStatus { authenticated, unauthenticated, unknown, justauth }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user = UserModel.empty,
  });

  const AuthenticationState.unknown() : this._();

  const AuthenticationState.authenticated(UserModel user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.justauth(UserModel user)
      : this._(status: AuthenticationStatus.justauth, user: user);

  final AuthenticationStatus status;
  final UserModel user;

  @override
  List<Object> get props => [status, user];
}