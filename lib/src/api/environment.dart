import 'package:proyecto_moviles/src/models/mercado_pago_credentials.dart';

class Environment {
  static const String API_DELIVERY = "192.168.0.15:3000";
  static const String API_KEY_MAPS = "AIzaSyAp9gehanGRPeqfWF9hTyPbK_KyWMsKj1k";

  static MercadoPagoCredentials mercadoPagoCredentials = MercadoPagoCredentials(
      publicKey: 'TEST-92001396-64c8-4ecc-a628-4e7ce44e6953',
      accessToken:
          'TEST-5603669237883404-121103-40bdc7236cc3a1495b2cfc5ec98e4c64-261550727');
}
