import 'package:flutter/material.dart';
import 'package:loja_virtual/models/order.dart';
import 'package:loja_virtual/screens/orders/components/order_product_tile.dart';

class OrdersTile extends StatelessWidget {
  final Order order;

  const OrdersTile(this.order);

  @override
  Widget build(BuildContext context) {
    final colorPrimary = Theme.of(context).primaryColor;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.formattedId,
                  style: TextStyle(
                    color: colorPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'R\$${order.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 14
                  ),
                ),
              ],
            ),
            Text(
              'Em preparação',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: colorPrimary,
                  fontSize: 14,
               ),
            ),
          ],
        ),
        children: [
          Column(
            children: order.items.map((e) => OrderProductTile(e)).toList(),
          )
        ],
      ),
    );
  }
}