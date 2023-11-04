//archivo: main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';
import 'tab_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TabProvider(),
      child: MyApp(),
    ),
  );
}
