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
                  indicatorWeight:
                      2.0, // Ajusta el tamaño del indicador según tus necesidades
                  tabs: tabProvider.myTabs.map((tabData) {
                    return Container(
                      width: tabData.tabWidth,
                      child: Tab(
                        text: tabData.showText ? tabData.text : null,
                        icon: tabData.showIcon ? Icon(tabData.icon) : null,
                      ),
                    );
                  }).toList(),
                ),
              ),
              body: TabBarView(
                children: tabProvider.myTabs.map((tabData) {
                  return Center(
                    child: tabData.showText
                        ? Text(tabData.text)
                        : tabData.showIcon
                            ? Icon(tabData.icon)
                            : Container(),
                  );
                }).toList(),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TabCreatorPage(),
                  ),
                ),
                child: const Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }
}
