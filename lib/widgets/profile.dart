import 'package:flutter/material.dart';
import 'package:login_firebase/logic/blocs/authentication/authentication_bloc.dart';
import 'package:login_firebase/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatelessWidget {

  Profile(this._user);
  UserModel _user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              child: Icon(Icons.account_circle),
            ),
            Text('Hello ${_user.name}'),
            Text(_user.email),
            Text(_user.id),
          ],
        ),
      ),
    );
  }
}
