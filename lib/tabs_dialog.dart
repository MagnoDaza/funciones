import 'package:flutter/material.dart';
import 'icon_list.dart';
import 'tab_provider.dart';
import 'tab_preview.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  int segmentedControlGroupValue = 0;
  final _formKey = GlobalKey<FormState>();
  FocusNode _textFocusNode = FocusNode();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.tabIndex != null) {
      var tabProvider = Provider.of<TabProvider>(context, listen: false);
      _textController = TextEditingController(
        text: tabProvider.myTabs[widget.tabIndex!].text,
      );
      _icon = tabProvider.myTabs[widget.tabIndex!].icon;
      segmentedControlGroupValue =
          tabProvider.getTabSegmentedControlGroupValue(widget.tabIndex!);
    } else {
      _textController = TextEditingController();
      _icon = Icons.home;
      segmentedControlGroupValue = 0;
    }
    _textFocusNode.addListener(() {
      if (_textFocusNode.hasFocus) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _handleIconSelected(IconData selectedIcon) {
    setState(() {
      _icon = selectedIcon;
    });
  }

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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Wrap(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        // Aquí es donde necesitas agregar el código para los botones segmentados
                      ],
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
                        if (segmentedControlGroupValue == -1) {
                          Fluttertoast.showToast(
                            msg: "Por favor, selecciona un botón segmentado",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                          return;
                        }
                        if (widget.tabIndex != null) {
                          tabProvider.updateTab(
                            widget.tabIndex!,
                            _textController!.text,
                            _icon!,
                            segmentedControlGroupValue,
                          );
                        }
                        if (widget.isNewTab) {
                          tabProvider.addTab(
                            _textController!.text,
                            _icon!,
                            segmentedControlGroupValue,
                          );
                          Fluttertoast.showToast(
                            msg: "Tab creado: ${_textController?.text}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Tab editado: ${_textController?.text}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                          );
                        }
                        Navigator.of(context).pop();
                      },
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
