import 'package:flutter/material.dart';
import 'package:proyecto_moviles/src/models/response_api.dart';
import 'package:proyecto_moviles/src/models/user.dart';
import 'package:proyecto_moviles/src/provider/push_notifications_provider.dart';
import 'package:proyecto_moviles/src/provider/users_provider.dart';
import 'package:proyecto_moviles/src/utils/my_snackbar.dart';
import 'package:proyecto_moviles/src/utils/shared_pref.dart';

class LoginController {
  BuildContext context;
  //Cuando el usuario escribe el textfield se actualiza y el controlador notifica a los listeners
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  UsersProvider usersProvider = new UsersProvider();
  PushNotificationsProvider pushNotificationsProvider =
      new PushNotificationsProvider();
  SharedPref _sharedPref = new SharedPref();

  Future init(BuildContext context) async {
    //constructor, inicializa la clase
    this.context = context;
    await usersProvider.init(context);
    User user = User.fromJson(await _sharedPref.read('user') ?? {});
    print('Usuario: ${user.toJson()}');
    //si está la sesion guardada lo manda directo a la lista de productos
    if (user?.sessionToken != null) {
      if (user.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, user.roles[0].route, (route) => false);
      }
    }
  }

  void goToRegisterPage() {
    Navigator.pushNamed(context, 'register');
  }

  void login() async {
    // se captura el email de lo escrito en el textfield
    String email = emailController.text.trim();
    //Trim elimina espacios en blanco
    String password = passwordController.text.trim();
    ResponseApi responseApi = await usersProvider.login(email, password);

    print('Respuesta object: ${responseApi}');
    print('Respuesta: ${responseApi.toJson()}');

    //si no hubo fallos en el login
    if (responseApi.success) {
      User user = User.fromJson(responseApi.data); //obteniendo el usuario
      // se almacena el usuario, 'user' = key
      _sharedPref.save('user', user.toJson());
      //pushNamedAndRemoveUntil: viaja a la pantalla y elimina el historial de pantallas

      pushNotificationsProvider.saveToken(user.id);

      print('USUARIO LOGEADO: ${user.toJson()}');
      if (user.roles.length > 1) {
        Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, user.roles[0].route, (route) => false);
      }
    } else {
      MySnackbar.show(context, responseApi.message);
    }
  }
}
