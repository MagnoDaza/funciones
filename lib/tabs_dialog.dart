// Importaciones necesarias
import 'package:flutter/material.dart';
import 'icon_list.dart';
import 'tab_provider.dart';
import 'tab_preview.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Importaciones necesarias

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
                Divider(),
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
                Divider(),
                const Text(
                  'Nombre del Tab',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Divider(),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                    labelText: "Nombre del Tab",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.edit),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, proporciona un nombre para el tab';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                Divider(),
                const SizedBox(height: 15),
                const Text(
                  'Mostrar en el tab',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                ToggleButtons(
                  children: <Widget>[
                    Text('✔️ Icono y texto'),
                    Text('✔️ Icono'),
                    Text('✔️ Texto'),
                  ],
                  isSelected: [
                    segmentedControlGroupValue == 0,
                    segmentedControlGroupValue == 1,
                    segmentedControlGroupValue == 2,
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < 3; i++) {
                        if (i == index) {
                          segmentedControlGroupValue = i;
                        }
                      }
                    });
                  },
                ),
                const SizedBox(height: 15),
                Divider(),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      child: Text(widget.isNewTab
                          ? 'Crear nuevo tab'
                          : 'Confirmar edición'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Resto del código...
                          Fluttertoast.showToast(
                            msg: widget.isNewTab ? "Tab creado" : "Tab editado",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        }
                      },
                    ),
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
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
