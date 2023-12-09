//file tabcreatorpage.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'tabs_dialog.dart';
import 'show_hide_tabs_page.dart';
import 'tab_organizer_dialog.dart';

class TabCreatorPage extends StatefulWidget {
  final int? tabIndex;
  const TabCreatorPage({this.tabIndex});

  @override
  _TabCreatorPageState createState() => _TabCreatorPageState();
}

class _TabCreatorPageState extends State<TabCreatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Creador de DinamicsTabs'),
        actions: [
          const Tooltip(
            message: 'Información general',
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.info_outline, color: Colors.grey),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Administra tus DinamicsTabs',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Crear DinamicsTabs',
                          style: TextStyle(fontSize: 16),
                        ),
                        Row(
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
                      ],
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const TabDialog(isNewTab: true);
                        },
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Nuevo'),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Mostrar Tabs',
                        style: TextStyle(fontSize: 16),
                      ),
                      Tooltip(
                        message: 'Haz clic para mostrar u ocultar tabs',
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.info_outline, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ShowHideTabsPage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.visibility),
                    label: const Text('Mostrar Tabs'),
                    style: ElevatedButton.styleFrom(primary: Colors.deepOrange),
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Organizar Tabs',
                        style: TextStyle(fontSize: 16),
                      ),
                      Tooltip(
                        message: 'Haz clic para organizar tus tabs',
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.info_outline, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return TabOrganizerDialog();
                        },
                      );
                    },
                    icon: const Icon(Icons.sort),
                    label: const Text('Organizar Tabs'),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Divider(),
              const SizedBox(height: 15),
              const Text('Mis DinamicsTabs',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 15),
              Expanded(
                child: ListView(
                  children:
                      Provider.of<TabProvider>(context).myTabs.map((tabData) {
                    return ListTile(
                      key: Key(tabData.text),
                      leading: tabData.showIcon
                          ? Icon(tabData.icon)
                          : Container(
                              width: 50.0,
                              child: Row(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Icon(tabData.icon),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(right: 5.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Icon(Icons.visibility_off,
                                          size: 18.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      title: tabData.showText
                          ? Text(tabData.text)
                          : Row(
                              children: [
                                Text(tabData.text),
                                const Padding(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        Icon(Icons.visibility_off, size: 18.0),
                                  ),
                                ),
                              ],
                            ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () {
                              int tabIndex = Provider.of<TabProvider>(context,
                                      listen: false)
                                  .myTabs
                                  .indexOf(tabData);
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return TabDialog(tabIndex: tabIndex);
                                },
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete,
                                color:
                                    tabData.isDeletable ? null : Colors.grey),
                            onPressed: tabData.isDeletable
                                ? () {
                                    Provider.of<TabProvider>(context,
                                            listen: false)
                                        .removeTab(Provider.of<TabProvider>(
                                                context,
                                                listen: false)
                                            .myTabs
                                            .indexOf(tabData));
                                    Fluttertoast.showToast(
                                      msg: "Tab eliminado",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                    );
                                  }
                                : null,
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
