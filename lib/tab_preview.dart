import 'package:flutter/material.dart';

class TabPreview extends StatelessWidget {
  final TextEditingController textController;
  final IconData icon;
  final bool showText;
  final bool showIcon;
  final double tabWidth; // Agrega este parámetro

  const TabPreview({
    required this.textController,
    required this.icon,
    this.showText = true,
    this.showIcon = true,
    required this.tabWidth, // Añade este parámetro
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: textController,
      builder: (context, value, child) {
        return Container(
          width: tabWidth, // Usa el valor de tabWidth
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Tab(
            text:
                showText ? (value.text.isEmpty ? 'inicial' : value.text) : null,
            icon: showIcon ? Icon(icon) : null,
          ),
        );
      },
    );
  }
}
