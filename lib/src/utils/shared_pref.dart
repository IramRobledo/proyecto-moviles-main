import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_moviles/src/provider/users_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  void save(String key, value) async {
    //almacenar nueva informacion en el storage
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value)); //lo que se quiere guardar
  }

  Future<dynamic> read(String key) async {
    //método que obtiene la información
    final prefs = await SharedPreferences.getInstance();
    // si no existe ninguna llave con ese valor retorna null
    if (prefs.getString(key) == null) return null;

    return json.decode(prefs.getString(key));
  }

  Future<bool> contains(String key) async {
    //método para saber si existe la información
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  Future<bool> remove(String key) async {
    //método para eliminar un dato
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  void logout(BuildContext context, String idUser) async {
    UsersProvider usersProvider = new UsersProvider();
    usersProvider.init(context);
    await usersProvider.logout(idUser);
    //elimina la key
    await remove('user');
    Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
  }
}
