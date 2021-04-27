import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_firebase/logic/blocs/film/fromApi/films_api_bloc.dart';
import 'package:login_firebase/logic/blocs/film/fromApi/films_api_event.dart';
import 'package:login_firebase/logic/blocs/tab/tab_bloc.dart';
import 'package:login_firebase/provider/film_api_client.dart';
import 'package:login_firebase/repositories/api_film_repository.dart';
import 'package:login_firebase/repositories/firebase_films_repository.dart';
import 'package:login_firebase/screens/finish_signup_page.dart';
import 'logic/blocs/film/films.dart';
import 'screens/home_page.dart';
import 'theme.dart';
import 'logic/blocs/authentication/authentication_bloc.dart';
import 'repositories/authentication_repository.dart';
import 'screens/login_page.dart';
import 'screens/splash_page.dart';


class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
  })  : assert(authenticationRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => AuthenticationBloc(
                    authenticationRepository: authenticationRepository)),
            BlocProvider(
                create: (_) => TabBloc()),
            BlocProvider(
                create: (_) => FilmsBloc(filmsRepository: FirebaseFilmsRepository()
                )..add(LoadFilms())),
            BlocProvider(
                create: (_) => FilmsApiBloc(apiFilmRepository: ApiFilmRepository(
                    filmApiClient: FilmApiClient(
                        httpClient: http.Client())))..add(FilmsApiRequested())),
          ],
          child: AppView())
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator!.pushAndRemoveUntil<void>(
                  HomePage.route(),
                      (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator!.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                      (route) => false,
                );
                break;
              case AuthenticationStatus.justauth:
            //     _navigator!.pushAndRemoveUntil<void>(
            // HomePage.route(),
            // (route) => false,);
                _navigator!.pushAndRemoveUntil<void>(FinishSignUpPage.route(),
                        (route) => false);
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}