import 'package:flutter/material.dart';
import 'package:loja_virtual/models/item_size.dart';
import 'package:loja_virtual/common/custom_icon_button.dart';

class EditItemSize extends StatelessWidget {

  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  const EditItemSize({Key key, this.size, this.onRemove, this.onMoveUp, this.onMoveDown}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.name,
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
            validator: (name){
              if(name.isEmpty)
                return 'Inválido';
              return null;
            },
            onChanged: (name) => size.name = name,
          ),
        ),
        const SizedBox(width: 4),
        Expanded(
          flex: 20,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            validator: (stock){
              if(int.tryParse((stock)) == null)
                return 'Inválido';
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse((stock)),
          )
        ),
        const SizedBox(width: 4),
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              prefixText: 'R\$',
              labelText: 'Preço',
              isDense: true,
            ),
            validator: (price){
              if(num.tryParse((price)) == null)
                return 'Inválido';
              return null;
            },
            onChanged: (price) => size.price = num.tryParse((price)),
          )
        ),
        CustomIconButton(
          iconData: Icons.remove,
          color: Theme.of(context).primaryColor,
          onTap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          onTap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          onTap: onMoveDown,
        ),
      ],
    );
  }
}