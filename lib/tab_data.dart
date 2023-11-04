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

  TabData({
    required this.text,
    required this.icon,
    this.hideName = false,
    this.hideIcon = false,
    this.showText = true,
    this.showIcon = true,
    this.tabWidth =
        100.0, // Establece un valor predeterminado para el ancho de la pestaña
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
  }) {
    return TabData(
      text: text ?? this.text,
      icon: icon ?? this.icon,
      showText: showText ?? this.showText,
      showIcon: showIcon ?? this.showIcon,
      tabWidth: tabWidth ?? this.tabWidth, // Actualiza el tabWidth
    );
  }
}
