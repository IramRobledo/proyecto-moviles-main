import 'package:flutter/cupertino.dart';
import 'package:proyecto_moviles/src/pages/client/address/create/client_address_create_page.dart';
import 'package:proyecto_moviles/src/pages/client/address/list/client_address_list_page.dart';
import 'package:proyecto_moviles/src/pages/client/address/map/client_address_map_page.dart';
import 'package:proyecto_moviles/src/pages/client/orders/create/client_orders_create_page.dart';
import 'package:proyecto_moviles/src/pages/client/orders/list/client_orders_list_page.dart';
import 'package:proyecto_moviles/src/pages/client/orders/map/client_orders_map_page.dart';
import 'package:proyecto_moviles/src/pages/client/payments/create/client_payments_create_page.dart';

import 'package:proyecto_moviles/src/pages/client/payments/installments/client_payments_installments_page.dart';
import 'package:proyecto_moviles/src/pages/client/payments/status/client_payments_status_page.dart';
import 'package:proyecto_moviles/src/pages/client/products/list/client_products_list_page.dart';
import 'package:proyecto_moviles/src/pages/client/update/client_update_page.dart';
import 'package:proyecto_moviles/src/pages/delivery/orders/list/delivery_orders_list_page.dart';
import 'package:proyecto_moviles/src/pages/delivery/orders/map/delivery_orders_map_page.dart';
import 'package:proyecto_moviles/src/pages/login/login_page.dart';
import 'package:proyecto_moviles/src/pages/register/register_page.dart';
import 'package:proyecto_moviles/src/pages/market/categories/create/market_categories_create_page.dart';
import 'package:proyecto_moviles/src/pages/market/orders/list/market_orders_list_page.dart';
import 'package:proyecto_moviles/src/pages/market/products/create/market_products_create_page.dart';
import 'package:proyecto_moviles/src/pages/roles/roles_page.dart';

final Map<String, WidgetBuilder> routes = {
  'login': (BuildContext context) => LoginPage(),
  'register': (BuildContext context) => RegisterPage(),
  'roles': (BuildContext context) => RolesPage(),
  'client/products/list': (BuildContext context) => ClientProductsListPage(),
  'client/update': (BuildContext context) => ClientUpdatePage(),
  'client/orders/create': (BuildContext context) => ClientOrdersCreatePage(),
  'client/address/list': (BuildContext context) => ClientAddressListPage(),
  'client/address/create': (BuildContext context) => ClientAddressCreatePage(),
  'client/address/map': (BuildContext context) => ClientAddressMapPage(),
  'client/orders/list': (BuildContext context) => ClientOrdersListPage(),
  'client/orders/map': (BuildContext context) => ClientOrdersMapPage(),
  'client/payments/create': (BuildContext context) =>
      ClientPaymentsCreatePage(),
  'client/payments/installments': (BuildContext context) =>
      ClientPaymentsInstallmentsPage(),
  'client/payments/status': (BuildContext context) =>
      ClientPaymentsStatusPage(),
  'market/orders/list': (BuildContext context) =>
      MarketOrdersListPage(),
  'market/categories/create': (BuildContext context) =>
      MarketCategoriesCreatePage(),
  'market/products/create': (BuildContext context) =>
      MarketProductsCreatePage(),
  'delivery/orders/list': (BuildContext context) => DeliveryOrdersListPage(),
  'delivery/orders/map': (BuildContext context) => DeliveryOrdersMapPage(),
};
