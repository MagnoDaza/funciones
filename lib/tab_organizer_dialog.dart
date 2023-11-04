// archivo tab_organizer_dialog.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'tab_data.dart';

class TabOrganizerDialog extends StatefulWidget {
  @override
  _TabOrganizerDialogState createState() => _TabOrganizerDialogState();
}

class _TabOrganizerDialogState extends State<TabOrganizerDialog> {
  late List<TabData> workingTabs;

  @override
  void initState() {
    super.initState();
    workingTabs =
        List.from(Provider.of<TabProvider>(context, listen: false).myTabs);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Organizar los tabs'),
      content: Container(
        height: MediaQuery.of(context).size.height *
            0.5, // Ajusta este valor según tus necesidades
        child: ReorderableListView(
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) {
                newIndex -= 1;
              }
              final TabData item = workingTabs.removeAt(oldIndex);
              workingTabs.insert(newIndex, item);
            });
          },
          children: workingTabs.map((tabData) {
            return ListTile(
              key: Key(tabData.text),
              leading: Icon(tabData.icon),
              title: Text(tabData.text),
            );
          }).toList(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Confirmar'),
          onPressed: () {
            Provider.of<TabProvider>(context, listen: false).myTabs =
                workingTabs;
            Fluttertoast.showToast(
              msg: "Cambios guardados",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
