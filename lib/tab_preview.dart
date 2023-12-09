// file tabpreview.dartt
import 'package:flutter/material.dart';

// Define la clase TabPreview como un widget sin estado
class TabPreview extends StatelessWidget {
  // Declara las variables que se utilizarán
  final TextEditingController textController;
  final IconData icon;
  final bool showText;
  final bool showIcon;
  final double textSize;
  final double indicatorSize;

  // Constructor de la clase
  const TabPreview({
    required this.textController,
    required this.icon,
    this.showText = true,
    this.showIcon = true,
    required this.textSize,
    required this.indicatorSize,
  });

  // Método para construir el widget
  @override
  Widget build(BuildContext context) {
    // Utiliza un ValueListenableBuilder para escuchar los cambios en el textController
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: textController,
      builder: (context, value, child) {
        // Define el texto a mostrar
        String text = showText
            ? (value.text.isEmpty
                ? 'Nombre del tab'
                : value.text.padRight(4, ' '))
            : '';
        // Define el ícono a mostrar
        final tabIcon = showIcon ? icon : Icons.tab;
        // Ajusta el ancho del tab según la longitud del texto
        final tabWidth = text.length < 4 ? 80.0 : text.length * 20.0;
        // Construye el widget
        return DefaultTabController(
          length: 1,
          child: Container(
            width: tabWidth,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Crea la barra de tabs
                TabBar(
                  tabs: [
                    Tab(
                      // Muestra el ícono si showIcon es verdadero
                      icon: showIcon ? Icon(tabIcon, size: 24) : null,
                      // Muestra el texto si showText es verdadero
                      child: showText
                          ? FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(text),
                            )
                          : null,
                    ),
                  ],
                ),
                // Crea el indicador
              ],
            ),
          ),
        );
      },
    );
  }
}
