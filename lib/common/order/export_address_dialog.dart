import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:loja_virtual/models/address.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  ExportAddressDialog(this.address);

  final Address address;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Endereço de Entrega',
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: Text(
            '${address.street}, ${address.number} ${address.complement}\n'
            '${address.district}\n'
            '${address.city}/${address.state}\n'
            '${address.zipCode}',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.red),
          ),
        ),
        FlatButton(
          onPressed: () async {
            Navigator.of(context).pop();
            final file = await screenshotController.capture();
            await GallerySaver.saveImage(file.path);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Exportar'),
        ),        
      ],
    );
  }
}
