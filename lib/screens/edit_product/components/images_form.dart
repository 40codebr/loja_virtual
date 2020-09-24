import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual/models/product.dart';
import 'package:loja_virtual/screens/edit_product/components/image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  final Product product;

  const ImagesForm(this.product);

  @override
  Widget build(BuildContext context) {

    final primaryColor = Theme.of(context).primaryColor;

    return FormField<List<dynamic>>(
      initialValue: List.from(product.images),
      builder: (state) {
        void onImageSelected(File file){
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }
        return AspectRatio(
          aspectRatio: 1.5,
          child: Carousel(
            images: state.value.map<Widget>((image) => 
              Stack(
                fit: StackFit.expand,
                children: [
                  if (image is String) 
                    Image.network(image, fit: BoxFit.cover)
                  else 
                    Image.file(image as File, fit: BoxFit.cover),
                  
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red[100],
                      onPressed: (){
                        state.value.remove(image);
                        state.didChange(state.value);
                      },
                    ),
                  )
                ],
              )
            ).toList()..add(
              Material(
                color: Colors.grey,
                child: IconButton(
                  icon: Icon(Icons.add_a_photo),
                  color: primaryColor,
                  iconSize: 50,
                  onPressed: (){
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => ImageSourceSheet(
                        onImageSelected: onImageSelected
                      )
                    );
                  },
                )
              )
            ),
            dotSize: 4,
            showIndicator: product.images.length > 1 ? true : false,
            dotBgColor: Colors.transparent,
            dotColor: primaryColor,
            dotSpacing: 15,
            autoplay: false,
          ),
        );
      },
    );
  }
}