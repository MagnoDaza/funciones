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
                  ExpansionPanelList(
                    elevation: 1,
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (int index, bool isExpanded) {
                      tabProvider.togglePanelExpansion(index);
                    },
                    children: [
                      ExpansionPanel(
                        body: Column(
                          children: [
                            const SizedBox(height: 15),
                            SwitchListTile(
                              title: const Text('Muestra el nombre e icono'),
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
                                    : 'No se muestra el nombre y el icono. Ahora puedes hacer otros cambios',
                              ),
                            ),
                          ],
                        ),
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: const Text(
                                'Configuración general de visualización'),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(children: [
                                  const Icon(Icons.info, color: Colors.grey),
                                  const SizedBox(width: 8),
                                  Text(
                                      'Los cambios realizados en esta sección solo afectan a los DinamicsTabs creados anteriormente.',
                                      maxLines:
                                          3, // Puedes ajustar esto según tus necesidades
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.grey)),
                                ]),
                              ],
                            ),
                          );
                        },
                        isExpanded: tabProvider.isPanelExpanded(0),
                      ),
                      ExpansionPanel(
                        body: Column(
                          children: [
                            RadioListTile(
                              title: const Text('Mostrar texto'),
                              subtitle: Text(
                                tabProvider.showText
                                    ? 'Ahora se ve solo los nombres'
                                    : 'No se muestran los textos',
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
                                    ? 'No se muestran los iconos'
                                    : 'Ahora se muestran los iconos',
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
                            subtitle: Row(
                              children: [
                                const Icon(Icons.info, color: Colors.grey),
                                const SizedBox(width: 8),
                                Text('Información adicional',
                                    style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          );
                        },
                        isExpanded: tabProvider.isPanelExpanded(1),
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
