//file tabprovider.dartt
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'tab_data.dart';

class TabProvider with ChangeNotifier {
  List<TabData> myTabs = [
    TabData(
      text: 'Result 1',
      icon: Icons.home,
      isDeletable: true,
      indicatorSize: 'Result 1'.length.toDouble(),
      segmentedControlGroupValue: 0, // Nuevo campo
    ),
  ];

  ValueNotifier<double> tabWidthNotifier = ValueNotifier<double>(100.0);
  List<TabData> _tempTabs = [];
  bool get customNamesEnabled => _customNamesEnabled;
  bool _customNamesEnabled = true;
  bool showText = true;
  bool get showIcons => _showIcons;
  bool _showIcons = true;
  int _expandedPanelIndex = -1;
  int get expandedPanelIndex => _expandedPanelIndex;

  void togglePanelExpansion(int index) {
    _expandedPanelIndex = (_expandedPanelIndex == index) ? -1 : index;
    notifyListeners();
  }

  int getTabSegmentedControlGroupValue(int index) {
    return myTabs[index].segmentedControlGroupValue;
  }

  bool isPanelExpanded(int index) {
    return _expandedPanelIndex == index;
  }

  void addTab(String name, IconData icon, int segmentedControlGroupValue,
      {double tabWidth = 100.0}) {
    myTabs.add(
      TabData(
        text: name,
        icon: icon,
        tabWidth: tabWidth ?? 50.0,
        segmentedControlGroupValue: segmentedControlGroupValue, // Nuevo campo
      ),
    );
// Actualiza el estado del chip seleccionado
    updateTabShowText(myTabs.length - 1, segmentedControlGroupValue != 1);
    updateTabShowIcon(myTabs.length - 1, segmentedControlGroupValue != 2);

    notifyListeners();
  }

  void editTab(
      int index, String name, IconData icon, int segmentedControlGroupValue,
      {double tabWidth = 100.0}) {
    myTabs[index] = myTabs[index].copyWith(
      text: name,
      icon: icon,
      tabWidth: tabWidth,
      segmentedControlGroupValue: segmentedControlGroupValue, // Nuevo campo
    );
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
    return myTabs[index].indicatorSize;
  }

  void updateTab(
      int index, String name, IconData icon, int segmentedControlGroupValue,
      {double tabWidth = 100.0}) {
    myTabs[index] = myTabs[index].copyWith(
      text: name,
      icon: icon,
      tabWidth: tabWidth,
      segmentedControlGroupValue: segmentedControlGroupValue, // Nuevo campo
    );
    notifyListeners();
  }

  void handleTab(int? index, String name, IconData icon,
      int segmentedControlGroupValue, bool isNewTab,
      {double tabWidth = 100.0}) {
    if (isNewTab) {
      addTab(
        name,
        icon,
        segmentedControlGroupValue,
        tabWidth: tabWidth,
      );
      Fluttertoast.showToast(
        msg: "Tab creado: $name",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else if (index != null) {
      updateTab(
        index,
        name,
        icon,
        segmentedControlGroupValue,
        tabWidth: tabWidth,
      );
      Fluttertoast.showToast(
        msg: "Tab editado: $name",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }
}
