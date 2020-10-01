import 'package:flutter/material.dart';
import 'package:loja_virtual/screens/address/components/address_card.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
      ),
      body: ListView(
        children: <Widget>[
          AddressCard(),
        ],
      ),
    );
  }
}