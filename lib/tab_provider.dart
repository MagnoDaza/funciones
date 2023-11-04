//archivo tab_provider.dart

import 'package:flutter/material.dart';
import 'tab_data.dart';

class TabProvider with ChangeNotifier {
  List<TabData> myTabs = [TabData(text: 'Tab 1', icon: Icons.home)];
  List<TabData> _tempTabs = [];
  List<TabData> get tempTabs => _tempTabs; // Getter for _tempTabs

  bool get customNamesEnabled => _customNamesEnabled;
  bool _customNamesEnabled = true;
  bool showText = true;
  bool get showIcons => _showIcons;
  bool _showIcons = true;

  void addTab(String name, IconData icon) {
    myTabs.add(TabData(text: name, icon: icon));
    notifyListeners();
  }

  void updateTab(int index, String name, IconData icon) {
    myTabs[index].text = name;
    myTabs[index].icon = icon;
    notifyListeners();
  }

  void removeTab(int index) {
    myTabs.removeAt(index);
    notifyListeners();
  }

  void toggleCustomNamesEnabled() {
    _customNamesEnabled = !_customNamesEnabled;
    if (_customNamesEnabled) {
      showText = true;
      _showIcons = true;
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
}
