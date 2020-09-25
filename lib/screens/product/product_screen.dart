import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/cart_manager.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/models/user_manager.dart';
import 'package:loja_virtual/screens/product/components/sized_width.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen(this.product);

  final Product product;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            product.name
          ),
          centerTitle: true,
          actions: [
            IconButton(icon: Icon(Icons.shopping_cart),
            onPressed: () =>  Navigator.of(context).pushNamed('/cart')            
            ),
            Consumer<UserManager>(
              builder: (_, userManager, __){
                if(userManager.adminEnabled){
                  return IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: (){
                      Navigator.of(context).pushReplacementNamed('/edit_product',
                      arguments: product);
                    },
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            )
          ],
        ),
        body: ListView(
          children: [
            AspectRatio(
              aspectRatio: 1.5,
              child: Carousel(
                images: product.images.map((e) => NetworkImage(e)).toList(),
                dotSize: 4,
                showIndicator: product.images.length > 1 ? true : false,
                dotBgColor: Colors.transparent,
                dotColor: primaryColor,
                dotSpacing: 15,
                autoplay: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Text(
                      'A partir de:',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    'R\$${product.basePrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:16.0, bottom: 8.0),
                    child: Text(
                      'Descrição:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:16.0, bottom: 8.0),
                    child: Text(
                      'Tamanhos:',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: product.sizes.map((s) => SizedWidth(size: s)).toList(),
                  ),
                  const SizedBox(height: 40,),
                  product.hasStock ?
                  Consumer2<UserManager, Product>(
                    builder: (_, userManager, product, __){
                      return SizedBox(
                        height: 44,
                        child: RaisedButton.icon(
                          icon: Icon(
                            userManager.isLogged
                            ? Icons.add_shopping_cart_outlined
                            : Icons.lock_open_outlined
                          ),
                          disabledColor: primaryColor.withAlpha(100),
                          color: primaryColor,
                          textColor: Colors.white,
                          label: Text(
                            userManager.isLogged
                              ? 'Adcionar ao carrinho'
                              : 'Entre para comprar' 
                          ),
                          onPressed: product.selectedSize != null 
                              ? (){
                                if (userManager.isLogged) {
                                  context.read<CartManager>().addToCart(product);
                                  Navigator.of(context).pushNamed('/cart');
                                } else {
                                  Navigator.of(context).pushNamed('/login');
                                }
                              } 
                              : null,
                        ),
                      );
                    }
                  )
                  : Container(
                    color: primaryColor.withOpacity(.095),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Text(
                        'Não há estoque para este produto.',
                        style: TextStyle(
                          fontSize: 16,
                          color: primaryColor,
                        ),
                      ),
                    )
                  )
                ],
              ),
            ),
          ]
        ),
      ),
    );
  }
}