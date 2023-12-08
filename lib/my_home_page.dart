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
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: tabProvider.myTabs.map((tabData) {
                    return _buildTab(tabData.text, tabData.icon,
                        tabData.showText, tabData.showIcon);
                  }).toList(),
                ),
                title: Text('Tabs Demo'),
              ),
              body: TabBarView(
                children: tabProvider.myTabs.map((tabData) {
                  return Center(
                    child: tabData.showText
                        ? Text(
                            tabData.text,
                            style: TextStyle(fontSize: tabData.textSize),
                          )
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

  Widget _buildTab(String text, IconData icon, bool showText, bool showIcon) {
    return Tab(
      icon: showIcon ? Icon(icon) : null,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: showText ? Text(text) : null,
      ),
    );
  }
}
