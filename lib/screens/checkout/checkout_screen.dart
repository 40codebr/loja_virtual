import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/common/price_card.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/checkout_manager.dart';

class CheckoutScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
        checkoutManager..updateCart(cartManager),
      lazy: false,
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: const Text('Pagamento')
        ),
        body: Consumer<CheckoutManager>(
          builder: (_, checkoutManager,__){
            if(checkoutManager.loading){
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.grey[800]),
                    ),
                    const SizedBox(height: 16,),
                    Text(
                     'Processando seu pagamento',
                     style: TextStyle(
                       color: Colors.grey[800],
                       fontWeight: FontWeight.w800,
                       fontSize: 16,
                     ), 
                    )
                  ],
                ),
              );
            }
            return ListView(
              children: [
                PriceCard(
                  buttonText: 'Finalizar pedido',
                  onPressed: (){
                    checkoutManager.checkout(
                      onStockFail: (e){
                        /* scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(e),
                            backgroundColor: Colors.red,
                          )
                        ); */
                        Navigator.of(context).popUntil((route) => route.settings.name == '/cart');
                      },
                      onSuccess: () {
                        Navigator.of(context).popUntil((route) => route.settings.name == '/base');
                      }
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}