import 'package:flutter/material.dart';
import 'package:loja_virtual/common/empty_card.dart';
import 'package:loja_virtual/common/login_card.dart';
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
      body: Consumer<CartManager>(
        builder: (_, cartManager, __) {
          if (cartManager.user == null) {
            return LoginCard();
          }
          return cartManager.items.isEmpty
            ? EmptyCard(
              title: 'Nenhum produto no carrinho.',
              iconData: Icons.remove_shopping_cart_outlined,
            )
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
        },
      ),
    );
  }
}
