import 'package:flutter/material.dart';

class TabPreview extends StatelessWidget {
  final TextEditingController textController;
  final IconData icon;
  final bool showText;
  final bool showIcon;
  final double textSize;
  final double indicatorSize;

  const TabPreview({
    required this.textController,
    required this.icon,
    this.showText = true,
    this.showIcon = true,
    required this.textSize,
    required this.indicatorSize,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: textController,
      builder: (context, value, child) {
        String text = showText
            ? (value.text.isEmpty
                ? 'Nombre del tab'
                : value.text.padRight(4, ' '))
            : '';
        final tabIcon = showIcon ? icon : Icons.tab;
        final tabWidth = text.length < 4 ? 80.0 : text.length * 20.0;
        return DefaultTabController(
          length: 1,
          child: Container(
            width: tabWidth,
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Material(
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    dividerColor: Colors.transparent,
                    tabs: [
                      Tab(
                        icon: showIcon ? Icon(tabIcon, size: 24) : null,
                        child: showText
                            ? FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(text),
                              )
                            : null,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
