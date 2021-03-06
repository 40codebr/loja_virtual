import 'package:flutter/material.dart';
import 'package:loja_virtual/models/admin_orders_manager.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/order.dart';
import 'package:loja_virtual/models/orders_manager.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/stores_manager.dart';
import 'package:loja_virtual/screens/address/address_screen.dart';
import 'package:loja_virtual/screens/cart/cart_screen.dart';
import 'package:loja_virtual/screens/checkout/checkout_screen.dart';
import 'package:loja_virtual/screens/confirmation/confirmation_screen.dart';
import 'package:loja_virtual/screens/product/product_screen.dart';
import 'package:loja_virtual/screens/select_product/select_product_screen.dart';
import 'package:loja_virtual/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loja_virtual/screens/base/base.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/models/products_manager.dart';
import 'package:loja_virtual/models/admin_users_manager.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/screens/signup/signup_screen.dart';
import 'package:loja_virtual/screens/edit_product/edit_product_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

  // Adiciona novo documento a coleção
  /* FirebaseFirestore.instance.doc('test/bucetao-dorado').set({
    'preco': 399.99, 'usuario': 'Deise'
  }); */

  // Pega um documento na coleção
  /* DocumentSnapshot document = await FirebaseFirestore.instance.collection('test').doc('bucetao-dorado').get();
  print(document.data()['preco']); */

  // Ouvi a mudança no documento sempre que houver mudanças
  /* FirebaseFirestore.instance.collection('test').doc('bucetao-dorado').snapshots().listen((document) {
    print(document.data()['preco']);
  }); */

  // Lista todos os documentos de uma coleção
  /* QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('test').get();
  for(DocumentSnapshot document in snapshot.docs) {
    print(document.data());
  } */

  // Lista todos os documentos da coleção e escuta a mudança
  /* FirebaseFirestore.instance.collection('test').snapshots().listen((snapshot) {
    for(DocumentSnapshot document in snapshot.docs) {
      print(document.data());
    }
  }); */
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StoresManager(),
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) =>
              cartManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, OrdersManager>(
          create: (_) => OrdersManager(),
          lazy: false,
          update: (_, userManager, ordersManager) =>
              ordersManager..updateUser(userManager.user),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminUsersManager>(
          create: (_) => AdminUsersManager(),
          lazy: false,
          update: (_, userManager, adminUsersManager) =>
              adminUsersManager..updateUser(userManager),
        ),
        ChangeNotifierProxyProvider<UserManager, AdminOrdersManager>(
          create: (_) => AdminOrdersManager(),
          lazy: false,
          update: (_, userManager, adminOrdersManager) => adminOrdersManager
            ..updateAdmin(adminEnabled: userManager.adminEnabled),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Loja virtual',
        // theme: base,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 4, 125, 141),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            elevation: 0,
          ),
          scaffoldBackgroundColor: Color(0xFFE5E8EF),
          buttonColor: Color(0xFF15130F),
          buttonTheme: ButtonThemeData(
            buttonColor: Color(0xFF15130F),
            disabledColor: Color(0xFF15130F).withAlpha(100),
            textTheme: ButtonTextTheme.normal,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/signup':
              return MaterialPageRoute(builder: (_) => SignUpScreen());
            case '/login':
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case '/product':
              return MaterialPageRoute(
                  builder: (_) => ProductScreen(settings.arguments as Product));
            case '/edit_product':
              return MaterialPageRoute(
                  builder: (_) =>
                      EditProductScreen(settings.arguments as Product));
            case '/select_product':
              return MaterialPageRoute(builder: (_) => SelectProductScreen());
            case '/cart':
              return MaterialPageRoute(
                  builder: (_) => CartScreen(), settings: settings);
            case '/address':
              return MaterialPageRoute(builder: (_) => AddressScreen());
            case '/checkout':
              return MaterialPageRoute(builder: (_) => CheckoutScreen());
            case '/confirmation':
              return MaterialPageRoute(
                builder: (_) => ConfirmationScreen(settings.arguments as Order),
              );
            case '/':
              return MaterialPageRoute(
                  builder: (_) => BaseScreen(), settings: settings);
            default:
              return MaterialPageRoute(builder: (_) => BaseScreen());
          }
        },
      ),
    );
  }
}
