import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/home_manager.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/screens/cart/cart_screen.dart';
import 'package:loja_virtual/screens/product/product_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loja_virtual/screens/base/base.dart';
import 'package:loja_virtual/models/user_manager.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual/models/products_manager.dart';
import 'package:loja_virtual/screens/login/login_screen.dart';
import 'package:loja_virtual/screens/signup/signup_screen.dart';

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
          create: (_) => HomeManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ProductsManager(),
          lazy: false,
        ),
        ChangeNotifierProxyProvider<UserManager, CartManager>(
          create: (_) => CartManager(),
          lazy: false,
          update: (_, userManager, cartManager) => 
          cartManager..updateUser(userManager),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Loja virtual',
        theme: ThemeData(
          primaryColor: Color(0xFFB42827),
          scaffoldBackgroundColor: Color(0xFF2B292A),
          appBarTheme: const AppBarTheme(
            elevation: 0,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch(settings.name) {
            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignUpScreen()
              );
            case '/login':
              return MaterialPageRoute(
                builder: (_) => LoginScreen()
              );
            case '/product':
              return MaterialPageRoute(
                builder: (_) => ProductScreen(
                  settings.arguments as Product
                )
              );
            case '/cart':
              return MaterialPageRoute(
                builder: (_) => CartScreen()
              );
            case '/base':
              return MaterialPageRoute(
                builder: (_) => BaseScreen()
              );
            default:
              return MaterialPageRoute(
                builder: (_) => BaseScreen()
              );
          }
        },
      ),
    );
  }
}