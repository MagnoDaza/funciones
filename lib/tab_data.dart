import 'package:flutter/material.dart';

class TabData {
  String text;
  IconData icon;
  bool hideName;
  bool hideIcon;
  bool showText;
  bool showIcon;
  double tabWidth;
  bool isDeletable;
  double textSize;
  double containerSize;
  double indicatorSize;
  int segmentedControlGroupValue;

  TabData({
    required this.text,
    required this.icon,
    this.isDeletable = true,
    this.hideName = false,
    this.hideIcon = false,
    this.showText = true,
    this.showIcon = true,
    this.tabWidth = 100.0,
    this.textSize = 50,
    this.containerSize = 100,
    this.indicatorSize = 50,
    required this.segmentedControlGroupValue,
  });

  double getIndicatorSize() {
    return showText ? textSize : 0.0;
  }

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
    double? tabWidth,
    double? textSize,
    double? containerSize,
    double? indicatorSize,
    int?
        segmentedControlGroupValue, // Añade segmentedControlGroupValue como un parámetro opcional
  }) {
    return TabData(
      text: text ?? this.text,
      icon: icon ?? this.icon,
      showText: showText ?? this.showText,
      showIcon: showIcon ?? this.showIcon,
      tabWidth: tabWidth ?? this.tabWidth,
      containerSize: containerSize ?? this.containerSize,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      isDeletable: this.isDeletable,
      textSize: textSize ?? this.textSize,
      segmentedControlGroupValue: segmentedControlGroupValue ??
          this.segmentedControlGroupValue, // Usa el valor proporcionado o el valor actual
    );
  }
}
