import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:proyecto_moviles/src/pages/login/login_controller.dart';
import 'package:proyecto_moviles/src/utils/my_colors.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginController _con = new LoginController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _con.init(context); //se inicializa el controlador
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, //para centrar el contenedor
        child: Stack(
          //stack para sobreponer objetos
          children: [
            Positioned(
              top: -90,
              left: -100,
              child: _circleLogin(),
            ),
            Positioned(
              child: _textLogin(),
              top: 60,
              left: 25,
            ), //Positioned sirve para ubicar elementos
            SingleChildScrollView(
              child: Column(
                children: [
                  _imageBanner(),
                  _textFieldEmail(),
                  _textFieldPassword(),
                  _buttonLogin(),
                  _textDontHaveAccount()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textLogin() {
    return Text(
      'LOGIN',
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
          fontFamily: 'Roboto'),
    );
  }

  Widget _circleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: MyColors.primaryColor,
      ),
    );
  }

  Widget _textDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '¿No tienes una cuenta?',
          style: TextStyle(color: MyColors.primaryColor, fontSize: 17),
        ),
        SizedBox(
          width: 7,
        ),
        GestureDetector(
          onTap: _con.goToRegisterPage,
          child: Text(
            'Regístrate',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: MyColors.primaryColor,
                fontSize: 17),
          ),
        ),
      ],
    );
  }

  Widget _buttonLogin() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
      child: ElevatedButton(
        onPressed: _con.login,
        child: Text('INGRESAR'),
        style: ElevatedButton.styleFrom(
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(vertical: 15)),
      ),
    );
  }

  Widget _textFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.passwordController,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Contraseña',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            prefixIcon: Icon(
              Icons.lock,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _textFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 5),
      decoration: BoxDecoration(
          color: MyColors.primaryOpacityColor,
          borderRadius: BorderRadius.circular(30)),
      child: TextField(
        controller: _con.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Correo electronico',
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(15),
            hintStyle: TextStyle(
              color: MyColors.primaryColorDark,
            ),
            prefixIcon: Icon(
              Icons.email,
              color: MyColors.primaryColor,
            )),
      ),
    );
  }

  Widget _imageBanner() {
    return Container(
      margin: EdgeInsets.only(
        top: 125,
        bottom: MediaQuery.of(context).size.height * 0.10,
      ),
      child: Image.asset(
        'assets/img/logo.png',
        width: 200,
        height: 200,
      ),
    );
  }
}
