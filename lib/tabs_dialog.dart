//file tabdialog.dart
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
  int? segmentedControlGroupValue = 0;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _textFocusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    var tabProvider = Provider.of<TabProvider>(context, listen: false);
    if (widget.tabIndex != null) {
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

//sirve para seleccionar el icono
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
        child: Material(
            child: Column(
      children: <Widget>[
        Divider(
          color: Colors.grey,
          height: 10,
          thickness: 1,
          indent: 0,
          endIndent: 2,
        ),
        const Text(
          'Vista previa',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            fontStyle: FontStyle.italic,
          ),
        ),
        TabPreview(
          textController: _textController!,
          icon: _icon!,
          showText: segmentedControlGroupValue != 1,
          showIcon: segmentedControlGroupValue != 2,
          textSize: textSize,
          indicatorSize: indicatorSize,
        ),
        Expanded(
            child: SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 30),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const Divider(),
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
                        TextFormField(
                          focusNode: _textFocusNode,
                          controller: _textController,
                          decoration: const InputDecoration(
                            labelText: "El nombre del dinamicTab es...",
                            hintText: "cha cha chaa chaaaan",
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.edit_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, proporciona un nombre para el tab';
                            }
                            if (widget.isNewTab &&
                                tabProvider.myTabs
                                    .any((tab) => tab.text == value)) {
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
                            Container(
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: <Widget>[
                                  ChoiceChip(
                                    label: const Text(
                                      'Icono y texto',
                                    ),
                                    avatar: segmentedControlGroupValue == 0
                                        ? null
                                        : const Icon(
                                            Icons.auto_awesome_sharp,
                                          ),
                                    selected: segmentedControlGroupValue == 0,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        segmentedControlGroupValue = selected
                                            ? 0
                                            : segmentedControlGroupValue;
                                        if (widget.tabIndex != null &&
                                            selected) {
                                          tabProvider.updateTabShowText(
                                              widget.tabIndex!, true);
                                          tabProvider.updateTabShowIcon(
                                              widget.tabIndex!, true);
                                        }
                                      });
                                    },
                                  ),
                                  ChoiceChip(
                                    label:
                                        const Text('Icono', style: TextStyle()),
                                    avatar: segmentedControlGroupValue == 1
                                        ? null
                                        : const Icon(
                                            Icons.image,
                                          ),
                                    selected: segmentedControlGroupValue == 1,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        segmentedControlGroupValue = selected
                                            ? 1
                                            : segmentedControlGroupValue;
                                        if (widget.tabIndex != null &&
                                            selected) {
                                          tabProvider.updateTabShowText(
                                              widget.tabIndex!, false);
                                          tabProvider.updateTabShowIcon(
                                              widget.tabIndex!, true);
                                        }
                                      });
                                    },
                                  ),
                                  ChoiceChip(
                                    label:
                                        const Text('Texto', style: TextStyle()),
                                    avatar: segmentedControlGroupValue == 2
                                        ? null
                                        : const Icon(
                                            Icons.text_fields_sharp,
                                          ),
                                    selected: segmentedControlGroupValue == 2,
                                    onSelected: (bool selected) {
                                      setState(() {
                                        segmentedControlGroupValue = selected
                                            ? 2
                                            : segmentedControlGroupValue;
                                        if (widget.tabIndex != null &&
                                            selected) {
                                          tabProvider.updateTabShowText(
                                              widget.tabIndex!, true);
                                          tabProvider.updateTabShowIcon(
                                              widget.tabIndex!, false);
                                        }
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Divider(),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ]),
          ),
        )),
        Padding(
          padding: EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text(
                  widget.isNewTab ? 'Crear nuevo tab' : 'Confirmar edición',
                ),
                onPressed: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  String chipLabel;
                  if (segmentedControlGroupValue == 0) {
                    chipLabel = 'Icono y texto';
                  } else if (segmentedControlGroupValue == 1) {
                    chipLabel = 'Icono';
                  } else if (segmentedControlGroupValue == 2) {
                    chipLabel = 'Texto';
                  } else {
                    chipLabel = 'Ninguno';
                  }

                  //tabprovider para crear, editar y actualizar un tab
                  tabProvider.handleTab(
                    widget.tabIndex,
                    _textController!.text,
                    _icon!,
                    segmentedControlGroupValue ?? 0,
                    widget.isNewTab,
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        )
      ],
    )));
  }
}
