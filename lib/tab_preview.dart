import 'package:flutter/material.dart';

class TabPreview extends StatelessWidget {
  final TextEditingController textController;
  final IconData icon;
  final bool showText;
  final bool showIcon;
  final double textSize;
  final double tabWidth;

  const TabPreview({
    required this.textController,
    required this.icon,
    this.showText = true,
    this.showIcon = true,
    required this.textSize,
    required this.tabWidth,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: textController,
      builder: (context, value, child) {
        final text = showText ? value.text : null;

        // Calcula el ancho del texto
        final textPainter = TextPainter(
          text: TextSpan(text: text, style: TextStyle(fontSize: textSize)),
          textDirection: TextDirection.ltr,
        )..layout(minWidth: 0, maxWidth: double.infinity);

        final containerWidth = textPainter
            .size.width; // Usa el ancho del texto como el ancho del contenedor
        final indicatorWidth = textPainter
            .size.width; // Usa el ancho del texto como el ancho del indicador

        return Container(
          width: containerWidth,
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
            ],
          ),
        );
      },
    );
  }
}
