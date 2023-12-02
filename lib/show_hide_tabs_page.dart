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
                        canTapOnHeader: true,
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return ListTile(
                            title: const Text('Configuración de visualización'),
                            subtitle: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.info, color: Colors.grey),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Wrap(
                                    children: [
                                      Text(
                                        'Los cambios solo afectan a los DinamicsTabs creados con anterioridad.',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                          ;
                        },
                        body: Wrap(
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
                                      : "Ahora puedes ocultar todos los nombre o iconos",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );
                              },
                              subtitle: Text(
                                tabProvider.customNamesEnabled
                                    ? 'Se muestra el nombre y el icono'
                                    : 'No se muestra el nombre y el icono.',
                              ),
                            ),
                            const SizedBox(height: 15),
                            Divider(),
                            const SizedBox(height: 15),
                            ListTile(
                              title: const Text('Vista personalizada'),
                              subtitle: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.info, color: Colors.grey),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Wrap(
                                      children: [
                                        Text(
                                          'Ahora puedes que hacer tus potenciales clientes solo vean el solo el icono o el texto del DinamicTabs.',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
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
                        isExpanded: tabProvider.isPanelExpanded(0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Divider(),
                  const SizedBox(height: 15),
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
