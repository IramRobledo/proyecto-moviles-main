import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:proyecto_moviles/src/api/environment.dart';
import 'package:proyecto_moviles/src/models/mercado_pago_document_type.dart';
import 'package:proyecto_moviles/src/models/mercado_pago_payment_method_installments.dart';
import 'package:proyecto_moviles/src/models/order.dart';
import 'package:proyecto_moviles/src/models/user.dart';
import 'package:proyecto_moviles/src/utils/shared_pref.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MercadoPagoProvider {
  String _urlMercadoPago = 'api.mercadopago.com';
  String _url = Environment.API_DELIVERY;
  final _mercadoPagoCredentials = Environment.mercadoPagoCredentials;

  BuildContext context;
  User user;

  Future init(BuildContext context, User user) {
    this.context = context;
    this.user = user;
  }

  Future<List<MercadoPagoDocumentType>> getIdentificationTypes() async {
    try {
      final url = Uri.https(_urlMercadoPago, '/v1/identification_types',
          {'access_token': _mercadoPagoCredentials.accessToken});

      final res = await http.get(url);
      final data = json.decode(res.body);
      final result = new MercadoPagoDocumentType.fromJsonList(data);

      return result.documentTypeList;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<Response> createPayment({
    String cardId,
    double transactionAmount,
    String issuerId,
    String emailCustomer,
    String cardToken,
    String identificationType,
    String identificationNumber,
    Order order,
  }) async {
    try {
      final url = Uri.http(_url, '/api/payments/createPay');

      Map<String, dynamic> body = {
        'order': order,
        'card_id': cardId,
        'description': 'Delivery App',
        'transaction_amount': transactionAmount,
        'installments': 1,
        'payment_method_id': 'visa',
        'token': cardToken,
        'payer': {
          'email': emailCustomer,
        }
      };

      String bodyParams = json.encode(body);

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': user.sessionToken
      };

      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, user.id);
        return null;
      }

      return res;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<MercadoPagoPaymentMethodInstallments> getInstallments(
      String bin, double amount) async {
    try {
      final url =
          Uri.https(_urlMercadoPago, '/v1/payment_methods/installments', {
        'access_token': _mercadoPagoCredentials.accessToken,
        'bin': bin,
        'amount': '${amount}'
      });

      final res = await http.get(url);
      final data = json.decode(res.body);
      print('DATA INSTALLMENTS: $data');

      final result =
          new MercadoPagoPaymentMethodInstallments.fromJsonList(data);

      return result.installmentList.first;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<http.Response> createCardToken({
    String cvv,
    String expirationYear,
    int expirationMonth,
    String cardNumber,
    String documentNumber,
    String documentId,
    String cardHolderName,
  }) async {
    try {
      final url = Uri.https(_urlMercadoPago, '/v1/card_tokens',
          {'public_key': _mercadoPagoCredentials.publicKey});

      final body = {
        'security_code': cvv,
        'expiration_year': expirationYear,
        'expiration_month': expirationMonth,
        'card_number': cardNumber,
        'cardholder': {
          'identification': {
            'number': documentNumber,
            'type': documentId,
          },
          'name': cardHolderName
        },
      };

      final res = await http.post(url, body: json.encode(body));

      return res;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
