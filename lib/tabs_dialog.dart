// Importaciones necesarias
import 'package:flutter/material.dart';
import 'icon_list.dart';
import 'tab_provider.dart';
import 'tab_preview.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Clase principal
class TabDialog extends StatefulWidget {
  // Variables para almacenar el índice del tab y si es un nuevo tab
  final int? tabIndex;
  final bool isNewTab;

  // Constructor
  const TabDialog({this.tabIndex, this.isNewTab = false});

  // Creación del estado
  @override
  _TabDialogState createState() => _TabDialogState();
}

// Clase de estado
class _TabDialogState extends State<TabDialog> {
  // Variables para almacenar el controlador del texto, el ícono y el valor del dropdown
  TextEditingController? _textController;
  IconData? _icon;
  int segmentedControlGroupValue = 0;

  // GlobalKey para el formulario
  final _formKey = GlobalKey<FormState>();

  // Variable para manejar el foco del TextField
  FocusNode _textFocusNode = FocusNode();

  // Variable para manejar el scroll
  ScrollController _scrollController = ScrollController();

  // Inicialización del estado
  @override
  void initState() {
    super.initState();

    if (widget.tabIndex != null) {
      var tabProvider = Provider.of<TabProvider>(context, listen: false);
      _textController = TextEditingController(
        text: tabProvider.myTabs[widget.tabIndex!].text,
      );
      _icon = tabProvider.myTabs[widget.tabIndex!].icon;
    } else {
      _textController = TextEditingController();
      _icon = Icons.home;
    }

    // Añade un listener al foco del TextField
    _textFocusNode.addListener(() {
      if (_textFocusNode.hasFocus) {
        // Si el TextField tiene el foco, mueve el scroll hacia arriba
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // Función para manejar la selección del ícono
  void _handleIconSelected(IconData selectedIcon) {
    setState(() {
      _icon = selectedIcon;
    });
  }

  // Construcción de la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    var tabProvider = Provider.of<TabProvider>(context);
    var textSize = widget.tabIndex != null
        ? tabProvider.myTabs[widget.tabIndex!].textSize
        : 14.0;
    var indicatorSize = widget.tabIndex != null
        ? tabProvider.myTabs[widget.tabIndex!].getIndicatorSize()
        : 2.0;

    return SafeArea(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: AlertDialog(
          title: Text(widget.isNewTab ? 'Crear un nuevo tab' : 'Editar Tab'),
          content: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                const Text(
                  'Preview',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TabPreview(
                  textController: _textController!,
                  icon: _icon!,
                  showText: segmentedControlGroupValue != 2,
                  showIcon: segmentedControlGroupValue != 1,
                  textSize: textSize,
                  indicatorSize: indicatorSize,
                ),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Seleccionar el icono',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(_icon),
                      onPressed: () async {
                        await showDialog<IconData>(
                          context: context,
                          builder: (BuildContext context) {
                            return IconList(
                                onIconSelected: _handleIconSelected);
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(),
                const Text(
                  'Nombre del Tab',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const SizedBox(height: 15),
                TextFormField(
                  focusNode: _textFocusNode,
                  controller: _textController,
                  decoration: const InputDecoration(
                    labelText: "Nombre del Tab",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.edit),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, proporciona un nombre para el tab';
                    }
                    if (widget.isNewTab &&
                        tabProvider.myTabs.any((tab) => tab.text == value)) {
                      return 'Ya existe un tab con ese nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 15),
                const Text(
                  'Mostrar en el tab',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Wrap(
                  children: <Widget>[
                    ToggleButtons(
                      children: <Widget>[
                        Text(
                            '${segmentedControlGroupValue == 0 ? ' ✔️' : ''}Icono y texto'),
                        Text(
                            '${segmentedControlGroupValue == 1 ? ' ✔️' : ''}Icono'),
                        Text(
                            '${segmentedControlGroupValue == 2 ? ' ✔️' : ''}Texto'),
                      ],
                      isSelected: [
                        segmentedControlGroupValue == 0,
                        segmentedControlGroupValue == 1,
                        segmentedControlGroupValue == 2,
                      ],
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < 3; i++) {
                            {
                              segmentedControlGroupValue = index;
                            }
                          }
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Divider(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    TextButton(
                        child: Text(widget.isNewTab
                            ? 'Crear nuevo tab'
                            : 'Confirmar edición'),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          if (widget.tabIndex != null) {
                            if (segmentedControlGroupValue == 0) {
                              tabProvider.updateTabShowText(
                                  widget.tabIndex!, true);
                              tabProvider.updateTabShowIcon(
                                  widget.tabIndex!, true);
                            } else if (segmentedControlGroupValue == 1) {
                              tabProvider.updateTabShowText(
                                  widget.tabIndex!, false);
                              tabProvider.updateTabShowIcon(
                                  widget.tabIndex!, true);
                            } else if (segmentedControlGroupValue == 2) {
                              tabProvider.updateTabShowText(
                                  widget.tabIndex!, true);
                              tabProvider.updateTabShowIcon(
                                  widget.tabIndex!, false);
                            }
                          }

                          if (widget.isNewTab) {
                            tabProvider.addTab(_textController!.text, _icon!);
                            Fluttertoast.showToast(
                              msg: "Tab creado: ${_textController?.text}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                          } else {
                            tabProvider.editTab(widget.tabIndex!,
                                _textController!.text, _icon!);
                            Fluttertoast.showToast(
                              msg: "Tab editado: ${_textController?.text}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                            );
                          }
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
