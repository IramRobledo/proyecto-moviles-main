import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:proyecto_moviles/src/provider/push_notifications_provider.dart';
import 'package:proyecto_moviles/src/utils/my_colors.dart';

PushNotificationsProvider pushNotificationsProvider =
    new PushNotificationsProvider();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  pushNotificationsProvider.initPushNotifications();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pushNotificationsProvider.onMessageListener();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App Flutter',
      debugShowCheckedModeBanner: false,
      //para quitar la etiqueta de debug
      navigatorKey: navigatorKey,
      initialRoute: 'login',
      routes: routes,
      theme: ThemeData(
        primaryColor: MyColors.primaryColor,
        // fontFamily: 'Roboto',
      ),
    );
  }
}
