import 'package:flutter/material.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';
import 'package:loja_virtual/models/cart_product.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  const CartTile(this.cartProduct);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: Card(
        elevation: 12,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(
                  cartProduct.product.images.first,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartProduct.product.name,
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'Tamanho: ${cartProduct.size}',
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ),
                      Consumer<CartProduct>(builder: (_, cartProduct, __) {
                        if (cartProduct.hasStock)
                          return Text(
                            'R\$${cartProduct.unitPrice.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          );
                        else
                          return Text('Sem estoque suficiente',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                              ));
                      })
                    ],
                  ),
                ),
              ),
              Consumer<CartProduct>(builder: (_, cartProduct, __) {
                return Column(children: [
                  CustomIconButton(
                    iconData: Icons.add,
                    color: primaryColor,
                    onTap: cartProduct.increment,
                  ),
                  Text(
                    '${cartProduct.quantity}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  CustomIconButton(
                    iconData: Icons.remove,
                    color: cartProduct.quantity > 1 ? primaryColor : Colors.grey,
                    onTap: cartProduct.decrement,
                  ),
                ]);
              })
            ],
          ),
        ),
      ),
    );
  }
}
