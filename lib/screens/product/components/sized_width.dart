import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/item_size.dart';

class SizedWidth extends StatelessWidget {
  const SizedWidth({this.size});
  final ItemSize size;
  @override
  Widget build(BuildContext context) {

    final product = context.watch<Product>();
    final selected = size == product.selectedSize;

    Color color;
    if (!size.hasStock)
      color = Colors.red.withAlpha(50);
    else if(selected)
      color = Theme.of(context).primaryColor;
    else
      color = Colors.grey;

    return GestureDetector(
      onTap: (){
        if(size.hasStock){
          product.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: color,
          ),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: color, 
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6),
                  bottomLeft: Radius.circular(6),
                )
              ),
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Text(
                size.name,
                style: TextStyle(
                  fontSize: 12,
                  color: !size.hasStock ? Colors.red.withAlpha(50) : Colors.white,
                  decoration: !size.hasStock ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'R\$${size.price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  decoration: !size.hasStock ? TextDecoration.lineThrough : TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}