//archivo my_home_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'tab_creator_page.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maghara'),
      ),
      body: Consumer<TabProvider>(
        builder: (context, tabProvider, child) {
          return DefaultTabController(
            length: tabProvider.myTabs.length,
            child: Scaffold(
              appBar: AppBar(
                bottom: TabBar(
                  isScrollable: true,
                  tabs: tabProvider.myTabs
                      .map((tabData) => Container(
                            width: MediaQuery.of(context).size.width / 5,
                            child: Tab(
                              text: tabData.showText
                                  ? tabData.text
                                  : null, // Modifica esta línea
                              icon: tabData.showIcon
                                  ? Icon(tabData.icon)
                                  : null, // Modifica esta línea
                            ),
                          ))
                      .toList(),
                ),
              ),
              body: TabBarView(
                children: tabProvider.myTabs.map((tabData) {
                  return Center(child: Text(tabData.text));
                }).toList(),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TabCreatorPage())),
                child: const Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }
}
