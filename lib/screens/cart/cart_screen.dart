import 'package:flutter/material.dart';
import 'package:loja_virtual/common/price_card.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/screens/cart/components/cart_tile.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
      ),
      body: Consumer<CartManager>(builder: (_, cartManager, __) {
        return cartManager.items.length == 0
            ? Text('Nada aqui')
            : ListView(
                children: [
                  Column(
                      children: cartManager.items
                          .map((cartProduct) => CartTile(cartProduct))
                          .toList()),
                  PriceCard(
                    buttonText: 'Continuar para entrega',
                    onPressed: cartManager.isCartValid
                        ? () {
                            Navigator.of(context).pushNamed('/address');
                          }
                        : null,
                  ),
                ],
              );
      }),
    );
  }
}
