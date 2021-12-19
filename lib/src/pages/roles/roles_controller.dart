import 'package:flutter/material.dart';
import 'package:proyecto_moviles/src/models/user.dart';
import 'package:proyecto_moviles/src/utils/shared_pref.dart';

class RolesController {
  BuildContext context;
  Function refresh;

  User user;
  SharedPref sharedPref = new SharedPref();

  Future init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    //Obteniendo el usuario de sesión
    user = User.fromJson(await sharedPref
        .read('user')); // Podría tardarse un momento en completarse
    refresh();
  }

  void goToPage(String route) {
    Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
  }
}
