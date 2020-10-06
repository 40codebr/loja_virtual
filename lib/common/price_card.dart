import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:provider/provider.dart';

class PriceCard extends StatelessWidget {
  const PriceCard({this.buttonText, this.onPressed});

  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final productsPrice = cartManager.productsPrice;
    final deliveryPrice = cartManager.deliveryPrice;
    final totalPrice = cartManager.totalPrice;
    final buttonColor = Theme.of(context).buttonColor;

    return Card(
      elevation: 12,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Resumo do pedido',
              textAlign: TextAlign.start,
              style: TextStyle(
                color: buttonColor,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Subtotal',
                  style: TextStyle(color: buttonColor),
                ),
                Text(
                  'R\$${productsPrice.toStringAsFixed(2)}',
                  style: TextStyle(color: buttonColor),
                )
              ],
            ),
            const Divider(),
            if (deliveryPrice != null) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Entrega',
                    style: TextStyle(color: buttonColor),
                  ),
                  Text(
                    'R\$${deliveryPrice.toStringAsFixed(2)}',
                    style: TextStyle(color: buttonColor),
                  )
                ],
              ),
              const Divider(),
            ],
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: buttonColor,
                  ),
                ),
                Text(
                  'R\$ ${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              disabledColor: Theme.of(context).primaryColor.withAlpha(100),
              textColor: Colors.white,
              onPressed: onPressed,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
