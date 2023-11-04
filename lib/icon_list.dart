import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IconList extends StatefulWidget {
  @override
  _IconListState createState() => _IconListState();
}

class _IconListState extends State<IconList> {
  final int _iconsPerPage = 25;

  @override
  Widget build(BuildContext context) {
    final int _totalPages = (icons.length / _iconsPerPage).ceil();

    return SimpleDialog(
      title: const Text('Selecciona un icono'),
      children: List.generate(_totalPages, (page) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (page < _totalPages - 1)
              ? _iconsPerPage
              : icons.length % _iconsPerPage,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (BuildContext context, int index) {
            int iconIndex = page * _iconsPerPage + index;
            return IconButton(
              icon: Icon(icons[iconIndex]),
              onPressed: () {
                Navigator.pop(context, icons[iconIndex]);
              },
            );
          },
        );
      }),
    );
  }
}

const List<IconData> icons = [
  Icons.ac_unit,
  Icons.access_alarm,
  Icons.favorite,
  CupertinoIcons.heart_fill,
  CupertinoIcons.ant_circle_fill,
];
