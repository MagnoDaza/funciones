// Importa los paquetes necesarios
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'tab_data.dart';

// Define la clase TabProvider con ChangeNotifier para permitir que los widgets se suscriban a cambios
class TabProvider with ChangeNotifier {
  // Declara las variables que se utilizarán
  List<TabData> myTabs = [
    TabData(
      text: 'Result 1',
      icon: Icons.home,
      isDeletable: false,
      indicatorSize: 'Result 1'
          .length
          .toDouble(), // Ajusta el tamaño del indicador al tamaño del texto
    )
  ];

  // Agrega un ValueNotifier para el ancho del tab
  ValueNotifier<double> tabWidthNotifier = ValueNotifier<double>(100.0);

  List<TabData> _tempTabs = [];
  bool get customNamesEnabled => _customNamesEnabled;
  bool _customNamesEnabled = true;
  bool showText = true;
  bool get showIcons => _showIcons;
  bool _showIcons = true;
  int _expandedPanelIndex = -1;
  bool _isSliderEnabled = true;
  bool get isSliderEnabled => _isSliderEnabled;

  int get expandedPanelIndex => _expandedPanelIndex;

  void togglePanelExpansion(int index) {
    _expandedPanelIndex = (_expandedPanelIndex == index) ? -1 : index;
    notifyListeners();
  }

  bool isPanelExpanded(int index) {
    return _expandedPanelIndex == index;
  }

  void addTab(String name, IconData icon, {double tabWidth = 100.0}) {
    myTabs.add(TabData(
      text: name,
      icon: icon,
      tabWidth: tabWidth ?? 50.0,
    ));
    notifyListeners();
    Fluttertoast.showToast(
      msg: "El largo del indicador del tab activo es ${myTabs.last.textSize}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
    // Actualiza el ValueNotifier con el nuevo ancho del tab
    tabWidthNotifier.value = myTabs.last.tabWidth;
  }

  void editTab(int index, String name, IconData icon,
      {double tabWidth = 100.0}) {
    myTabs[index] =
        myTabs[index].copyWith(text: name, icon: icon, tabWidth: tabWidth);
    notifyListeners();
  }

  void updateTabWidth(int index, double tabWidth) {
    myTabs[index].tabWidth = tabWidth;
    notifyListeners();
  }

  void removeTab(int index) {
    myTabs.removeAt(index);
    notifyListeners();
  }

  void toggleCustomNamesEnabled() {
    _customNamesEnabled = !_customNamesEnabled;
    if (_customNamesEnabled) {
      for (TabData tab in myTabs) {
        tab.showText = true;
        tab.showIcon = true;
      }
    } else {
      showText = true;
      _showIcons = true;
    }
    notifyListeners();
  }

  void showToastOnToggleCustomNames() {
    Fluttertoast.showToast(
      msg: customNamesEnabled
          ? "Nombres e iconos personalizados habilitados"
          : "Nombres e iconos personalizados deshabilitados",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
    if (!customNamesEnabled) {
      toggleShowText();
    }
  }

  void saveState() {
    _tempTabs = myTabs.map((tab) => tab.copyWith()).toList();
  }

  void applyChanges() {
    if (_tempTabs.isNotEmpty) {
      myTabs = _tempTabs;
      notifyListeners();
    }
  }

  void toggleShowText() {
    if (_showIcons) {
      showText = !showText;
      for (TabData tab in myTabs) {
        tab.showText = showText;
      }
      notifyListeners();
    }
  }

  void toggleShowIcons() {
    if (showText) {
      _showIcons = !_showIcons;
      for (TabData tab in myTabs) {
        tab.showIcon = _showIcons;
      }
      notifyListeners();
    }
  }

  void updateTabShowText(int index, bool showText) {
    myTabs[index].showText = showText;
    notifyListeners();
  }

  void updateTabShowIcon(int index, bool showIcon) {
    myTabs[index].showIcon = showIcon;
    notifyListeners();
  }

  void reorderTabs(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final TabData tab = myTabs.removeAt(oldIndex);
    myTabs.insert(newIndex, tab);
    notifyListeners();
  }

  void updateTabOrder(List<TabData> newOrder) {
    myTabs = newOrder;
    notifyListeners();
  }

  double getIndicatorSize(int index) {
    if (index < 0 || index >= myTabs.length) {
      return 50.0;
    }
    return myTabs[index].showText
        ? myTabs[index].text.length.toDouble()
        : myTabs[index].indicatorSize;
  }
}
