import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobilitem2miage/core/services/LocationService.dart';
import 'package:mobilitem2miage/core/services/RemoveBgService.dart';
import 'package:mobilitem2miage/core/services/dao/UserDao.dart';
import 'package:mobilitem2miage/core/services/state/AppState.dart';
import 'package:mobilitem2miage/core/viewmodels/HomeModel.dart';
import 'package:mobilitem2miage/ui/views/BaseView.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {

  @override
  Widget build(BuildContext context) {

    var locationProvider = Provider.of<LocationService>(context);
    var userDao = Provider.of<UserDao>(context);
    var appState = Provider.of<AppState>(context);

    return BaseView<HomeModel>(
      onModelReady: (model) {
        /// Get user location everytime it change
        model.updateUserLocation(locationProvider, userDao, appState.user);
      },
      builder: (context, model, child) {
        return Scaffold(
          key: GlobalKey(),
          body: model.pages[model.currentIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF809cc5),
                  offset: Offset(0.0, -1.0),
                )
              ],
              color: Colors.white,
            ),
            child: BottomNavigationBar(
              backgroundColor: Color(0xFF809cc5),
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.white,
              selectedItemColor: Color(0xFF50627b),
              onTap: (int) {
                model.onTappedBar(int);
              },
              currentIndex: model.currentIndex,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.mapMarked, size: 20.0),
                  title: Text("Carte"),
                ),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.atlas, size: 20.0),
                    title: Text("Lieu")
                ),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.solidUser, size: 20.0),
                    title: Text("Compte")
                ),
              ],
            ),
          )
        );
      },
    );
  }
}