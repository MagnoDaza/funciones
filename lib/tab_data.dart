// En tab_data.dart

import 'package:flutter/material.dart';

class TabData {
  String text;
  IconData icon;
  bool hideName;
  bool hideIcon;
  bool showText;
  bool showIcon;
  double tabWidth; // Agrega este campo
  bool isDeletable;
  double textSize;
  double containerSize;
  double indicatorSize;

  TabData({
    required this.text,
    required this.icon,
    this.isDeletable = true,
    this.hideName = false,
    this.hideIcon = false,
    this.showText = true,
    this.showIcon = true,
    this.tabWidth =
        100.0, // Establece un valor predeterminado para el ancho de la pestaña

    this.textSize = 50, // Tamaño predeterminado del texto
    this.containerSize = 100, // Tamaño predeterminado del contenedor
    this.indicatorSize = 50, // Tamaño predeterminado del indicador
  });

  void toggleHideName() {
    hideName = !hideName;
    showText = !hideName;
  }

  void toggleHideIcon() {
    hideIcon = !hideIcon;
    showIcon = !hideIcon;
  }

  TabData copyWith({
    String? text,
    IconData? icon,
    bool? showText,
    bool? showIcon,
    double? tabWidth, // Agrega el parámetro tabWidth
    double? textSize,
    double? containerSize,
    double? indicatorSize,
  }) {
    return TabData(
      text: text ?? this.text,
      icon: icon ?? this.icon,
      showText: showText ?? this.showText,
      showIcon: showIcon ?? this.showIcon,
      tabWidth: tabWidth ?? this.tabWidth, // Actualiza el tabWidth
      containerSize: containerSize ?? this.containerSize,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      isDeletable: this.isDeletable,
      textSize: textSize ?? this.textSize,
    );
  }
}
