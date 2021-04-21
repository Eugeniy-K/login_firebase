
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login_firebase/logic/blocs/authentication/authentication_bloc.dart';
import 'package:login_firebase/logic/blocs/tab/tab_bloc.dart';
import 'package:login_firebase/logic/blocs/tab/tab_event.dart';
import 'package:login_firebase/models/app_tab.dart';
import 'package:login_firebase/widgets/explore.dart';
import 'package:login_firebase/widgets/profile.dart';
import 'package:login_firebase/widgets/tab_selector.dart';
import 'package:login_firebase/widgets/watchlist.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
    return Scaffold(
      body: Center(
        child: BlocBuilder<TabBloc, AppTab>(
          builder: (context, activeTab) {
            if (activeTab == AppTab.explore) {
              return Explore();
            }
            if (activeTab == AppTab.witchlist) {
              return Watchlist();
            }
            else return Profile(user);
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<TabBloc, AppTab>(
        builder: (context, activeTab) {
          return TabSelector(
              activeTab: activeTab,
              onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)));
        },
      ),
    );
  }
}
