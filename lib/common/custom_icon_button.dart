import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  final IconData iconData;
  final Color color;
  final VoidCallback onTap;
  final double size;
  final bool decoration;

  const CustomIconButton({this.iconData, this.color = Colors.black, this.onTap, this.size, this.decoration = false});

  @override
  Widget build(BuildContext context) {
    final buttonColor = Theme.of(context).buttonColor;

    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: decoration ? buttonColor : Colors.transparent,
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Icon(
                iconData,
                color: onTap != null ? color : Colors.grey[400],
                size: size ?? 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}