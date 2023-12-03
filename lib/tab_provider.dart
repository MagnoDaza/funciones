// File: tab_provider.dart

import 'package:flutter/material.dart';
import 'tab_data.dart';
import 'package:fluttertoast/fluttertoast.dart';

class TabProvider with ChangeNotifier {
  List<TabData> myTabs = [
    TabData(text: 'Result 1', icon: Icons.home, isDeletable: false)
  ];
  List<TabData> _tempTabs = [];
  bool get customNamesEnabled => _customNamesEnabled;
  bool _customNamesEnabled = true;
  bool showText = true;
  bool get showIcons => _showIcons;
  bool _showIcons = true;
  int _expandedPanelIndex = -1; // Índice del panel expandido
  bool _isSliderEnabled = true; // Agrega esta línea

  bool get isSliderEnabled => _isSliderEnabled; // Agrega este método

  int get expandedPanelIndex => _expandedPanelIndex;

  void togglePanelExpansion(int index) {
    _expandedPanelIndex = (_expandedPanelIndex == index) ? -1 : index;
    notifyListeners();
  }

  bool isPanelExpanded(int index) {
    return _expandedPanelIndex == index;
  }

  void addTab(String name, IconData icon, {double tabWidth = 100.0}) {
    myTabs.add(TabData(text: name, icon: icon, tabWidth: tabWidth));
    notifyListeners();
  }

  void updateTab(int index, String name, IconData icon,
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

    // Verificar si el switch está apagado
    if (!customNamesEnabled) {
      // Solo activar toggleShowText si el switch está apagado
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
}
