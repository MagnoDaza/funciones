import 'package:flutter/material.dart';

class TabPreview extends StatelessWidget {
  final TextEditingController textController;
  final IconData icon;
  final bool showText;
  final bool showIcon;
  final double textSize;
  final double indicatorSize;

  const TabPreview({
    required this.textController,
    required this.icon,
    this.showText = true,
    this.showIcon = true,
    required this.textSize,
    required this.indicatorSize,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: textController,
      builder: (context, value, child) {
        final text = showText ? value.text : null;
        final tabWidth = text != null
            ? text.length * 10.0
            : 100.0; // Ajusta el ancho del tab según la longitud del texto
        return Container(
          width: tabWidth,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showIcon) Icon(icon, size: 24),
              if (showText && showIcon) const SizedBox(height: 8),
              if (showText)
                Text(
                  (text?.isEmpty ?? true) ? 'Result 1' : text!,
                  style: TextStyle(fontSize: textSize),
                ),
              if (showText && text != null && text.isNotEmpty)
                Container(
                  height: indicatorSize,
                  width: double.infinity,
                  color: Colors.blue,
                ),
            ],
          ),
        );
      },
    );
  }
}
