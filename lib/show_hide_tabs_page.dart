// File: show_hide_tabs_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowHideTabsPage extends StatelessWidget {
  const ShowHideTabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mostrar nombre del tab'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<TabProvider>(
            builder: (context, tabProvider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 15),
                  const Divider(),
                  const SizedBox(height: 15),
                  Text(
                    'Nombres e iconos personalizados',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  SwitchListTile(
                    title: const Text('Nombre e icono personalizado'),
                    value: tabProvider.customNamesEnabled,
                    onChanged: (bool value) {
                      tabProvider.toggleCustomNamesEnabled();
                      Fluttertoast.showToast(
                        msg: tabProvider.customNamesEnabled
                            ? "Nombres e iconos personalizados habilitados"
                            : "Nombres e iconos personalizados deshabilitados",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                      );
                    },
                    subtitle: Text(
                      tabProvider.customNamesEnabled
                          ? 'Se muestra el nombre y el icono'
                          : 'No se muestra el nombre e icono',
                    ),
                  ),
                  const SizedBox(height: 20),
                  ExpansionPanelList(
                    elevation: 1,
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (int index, bool isExpanded) {},
                    children: [
                      ExpansionPanel(
                        body: Column(
                          children: [
                            RadioListTile(
                              title: const Text('Mostrar texto'),
                              subtitle: Text(
                                tabProvider.showText
                                    ? 'Se muestra todo'
                                    : 'No se muestra todo',
                              ),
                              value: true,
                              groupValue: tabProvider.showText,
                              onChanged: tabProvider.customNamesEnabled
                                  ? null
                                  : (bool? value) {
                                      tabProvider.toggleShowText();
                                      tabProvider.toggleShowIcons();
                                    },
                            ),
                            RadioListTile(
                              title: const Text('Mostrar icono'),
                              subtitle: Text(
                                tabProvider.showText
                                    ? 'Se muestra todo'
                                    : 'No se muestra todo',
                              ),
                              value: false,
                              groupValue: tabProvider.showText,
                              onChanged: tabProvider.customNamesEnabled
                                  ? null
                                  : (bool? value) {
                                      tabProvider.toggleShowText();
                                      tabProvider.toggleShowIcons();
                                    },
                            ),
                          ],
                        ),
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: const Text('Configuración de visualización'),
                          );
                        },
                        isExpanded: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  const SizedBox(height: 15),
                  Text('Información', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 15),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
