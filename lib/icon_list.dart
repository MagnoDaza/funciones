import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class IconList extends StatefulWidget {
  final Function(IconData) onIconSelected;

  IconList({required this.onIconSelected});

  @override
  _IconListState createState() => _IconListState();
}

class _IconListState extends State<IconList> {
  late PageController _pageController;
  final int iconsPerPage = 25; // Número de iconos por página

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Text('Selecciona un icono'),
      ),
      contentPadding: EdgeInsets.all(16.0),
      children: [
        Container(
          width: double.maxFinite,
          height: 200, // Ajusta según sea necesario
          child: PageView.builder(
            controller: _pageController,
            itemCount: (allIcons.length / iconsPerPage).ceil(),
            itemBuilder: (context, pageIndex) {
              final startIconIndex = pageIndex * iconsPerPage;
              final endIconIndex = (pageIndex + 1) * iconsPerPage;
              final visibleIcons = allIcons.sublist(
                startIconIndex,
                endIconIndex.clamp(0, allIcons.length),
              );

              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // 5 columnas por fila
                  crossAxisSpacing: 16.0, // Espacio entre columnas
                  mainAxisSpacing: 16.0, // Espacio entre filas
                ),
                itemCount: visibleIcons.length,
                itemBuilder: (context, index) {
                  final iconIndex = startIconIndex + index;
                  return InkWell(
                    onTap: () {
                      widget.onIconSelected(allIcons[iconIndex]);
                      Navigator.of(context).pop();
                    },
                    child: Icon(visibleIcons[index]),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

// Lista de todos los iconos disponibles en Flutter y Font Awesome
List<IconData> allIcons = [
  // Iconos de Flutter
  Icons.ac_unit,
  Icons.access_alarm,
  Icons.access_alarms,
  Icons.access_time,
  Icons.accessibility,
  Icons.accessible,
  Icons.account_balance,
  Icons.account_balance_wallet,
  Icons.account_box,
  Icons.account_circle,
  Icons.ac_unit,
  Icons.add,
  Icons.add_a_photo,
  Icons.add_alarm,
  Icons.add_alert,
  Icons.add_box,
  Icons.add_circle,
  Icons.add_circle_outline,
  Icons.add_location,
  Icons.add_shopping_cart,

  //iconos cupertino
  //
  CupertinoIcons.add,
  CupertinoIcons.book,
  CupertinoIcons.info,
  CupertinoIcons.play_arrow,
  CupertinoIcons.profile_circled,
  CupertinoIcons.video_camera_solid,
];
