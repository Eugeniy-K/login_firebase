import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:login_firebase/logic/blocs/tab/tab_event.dart';
import 'package:login_firebase/models/app_tab.dart';


class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.explore);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}