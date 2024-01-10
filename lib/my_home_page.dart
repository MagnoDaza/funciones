import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tab_provider.dart';
import 'tab_creator_page.dart';
import 'tab_data.dart';

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
                bottom: MyTabBar(tabs: tabProvider.myTabs),
                title: Text('TabsDemo'),
              ),
              body: MyTabBarView(tabs: tabProvider.myTabs),
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

class MyTabBar extends PreferredSize {
  final List<TabData> tabs;

  MyTabBar({required this.tabs})
      : super(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: TabBar(
              dividerColor: Colors.transparent,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: tabs
                  .map(
                    (tabData) => _buildTab(tabData.text, tabData.icon,
                        tabData.showText, tabData.showIcon),
                  )
                  .toList(),
            ));

  static Widget _buildTab(
      String text, IconData icon, bool showText, bool showIcon) {
    return Tab(
      icon: showIcon ? Icon(icon) : null,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: showText ? Text(text) : null,
      ),
    );
  }
}

class MyTabBarView extends StatelessWidget {
  final List<TabData> tabs;

  MyTabBarView({required this.tabs});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: tabs.map((tabData) {
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
    );
  }
}
