import 'package:flutter/material.dart';
import 'package:proyecto_moviles/src/models/user.dart';
import 'package:proyecto_moviles/src/utils/shared_pref.dart';

class DeliveryOrdersListController {
  BuildContext context;
  Function refresh;
  SharedPref _sharedPref = new SharedPref();
  GlobalKey<ScaffoldState> key = new GlobalKey<ScaffoldState>();

  User user;

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }

  void logout() {
    _sharedPref.logout(context, user.id);
  }

  void openDrawer() {
    key.currentState.openDrawer();
  }

  void goToRoles() {
    Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
  }
}
