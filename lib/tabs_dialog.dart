import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'icon_list.dart';
import 'tab_provider.dart';
import 'tab_preview.dart';

class TabDialog extends StatefulWidget {
  final int? tabIndex;
  final bool isNewTab;

  const TabDialog({this.tabIndex, this.isNewTab = false});

  @override
  _TabDialogState createState() => _TabDialogState();
}

class _TabDialogState extends State<TabDialog> {
  TextEditingController? _textController;
  IconData? _icon;
  String dropdownValue = 'Mostrar icono y nombre';
  double _tabWidth = 100; // Valor predeterminado para el ancho del tab

  @override
  void initState() {
    super.initState();
    if (widget.tabIndex != null) {
      _textController = TextEditingController(
        text: Provider.of<TabProvider>(context, listen: false)
            .myTabs[widget.tabIndex!]
            .text,
      );
      _icon = Provider.of<TabProvider>(context, listen: false)
          .myTabs[widget.tabIndex!]
          .icon;
      _tabWidth = Provider.of<TabProvider>(context, listen: false)
          .myTabs[widget.tabIndex!]
          .tabWidth;
    } else {
      _textController = TextEditingController();
      _icon = Icons.home;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isNewTab ? 'Crear un nuevo tab' : 'Editar Tab'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            Text('Preview', style: TextStyle(fontSize: 14)),
            if (_textController != null && _icon != null)
              TabPreview(
                textController: _textController!,
                icon: _icon!,
                showText: dropdownValue != 'Solo el icono',
                showIcon: dropdownValue != 'Solo el texto',
                tabWidth: _tabWidth, // Muestra el ancho del tab en tiempo real
              ),
            SizedBox(height: 15),
            Text('Selecciona el icono', style: TextStyle(fontSize: 14)),
            IconButton(
              icon: Icon(_icon),
              onPressed: () async {
                IconData? selectedIcon = await showDialog<IconData>(
                  context: context,
                  builder: (BuildContext context) {
                    return IconList();
                  },
                );
                if (selectedIcon != null) {
                  setState(() {
                    _icon = selectedIcon;
                  });
                }
              },
            ),
            SizedBox(height: 15),
            Text('Nombre del Tab', style: TextStyle(fontSize: 14)),
            TextField(
              controller: _textController,
              decoration: InputDecoration(hintText: "Nombre del Tab"),
            ),
            SizedBox(height: 15),
            Text('Mostrar en el tab', style: TextStyle(fontSize: 14)),
            SizedBox(height: 15),
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
              items: <String>[
                'Mostrar icono y nombre',
                'Solo el texto',
                'Solo el icono'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 15),
            Text('Tamaño del tab', style: TextStyle(fontSize: 14)),
            Tooltip(
              message: 'Desliza para ajustar el tamaño del tab',
              child: Slider(
                value: _tabWidth,
                min: 50,
                max: 200,
                onChanged: (double value) {
                  setState(() {
                    _tabWidth = value;
                  });
                },
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child:
              Text(widget.isNewTab ? 'Crear nuevo tab' : 'Confirmar edición'),
          onPressed: () {
            if (_textController != null &&
                _icon != null &&
                _textController!.text.isNotEmpty) {
              int? tabIndex;
              if (!widget.isNewTab) {
                tabIndex = widget.tabIndex!;
                Provider.of<TabProvider>(context, listen: false).updateTab(
                  tabIndex,
                  _textController!.text,
                  _icon!,
                  tabWidth: _tabWidth, // Actualiza el ancho del tab al editarlo
                );
                Fluttertoast.showToast(
                  msg: "Tab actualizado",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                );
              } else {
                bool tabExists =
                    Provider.of<TabProvider>(context, listen: false)
                        .myTabs
                        .any((tab) => tab.text == _textController!.text);
                if (tabExists) {
                  Fluttertoast.showToast(
                    msg: "No se pueden tener tabs con el mismo nombre",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                } else {
                  Provider.of<TabProvider>(context, listen: false).addTab(
                      _textController!.text, _icon!,
                      tabWidth: _tabWidth);
                  tabIndex = Provider.of<TabProvider>(context, listen: false)
                          .myTabs
                          .length -
                      1;
                  Fluttertoast.showToast(
                    msg: "Tab creado",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                  );
                  _textController!.clear();
                  FocusScope.of(context).unfocus();
                }
              }
              if (dropdownValue == 'Solo el texto') {
                Provider.of<TabProvider>(context, listen: false)
                    .updateTabShowIcon(tabIndex!, false);
                Provider.of<TabProvider>(context, listen: false)
                    .updateTabShowText(tabIndex!, true);
              } else if (dropdownValue == 'Solo el icono') {
                Provider.of<TabProvider>(context, listen: false)
                    .updateTabShowIcon(tabIndex!, true);
                Provider.of<TabProvider>(context, listen: false)
                    .updateTabShowText(tabIndex!, false);
              } else {
                Provider.of<TabProvider>(context, listen: false)
                    .updateTabShowIcon(tabIndex!, true);
                Provider.of<TabProvider>(context, listen: false)
                    .updateTabShowText(tabIndex!, true);
              }
            } else {
              Fluttertoast.showToast(
                msg: "Por favor, proporciona un nombre para el tab",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
              );
            }
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
