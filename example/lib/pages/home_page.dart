import 'package:desktop_util/desktop_util.dart';
import 'package:desktop_util_example/pages/shortcuts.dart';
import 'package:desktop_util_example/pages/testing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


import 'buttons_page.dart';
import 'dropdown_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 3;
  List<Widget> destinations = [
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DesktopTooltip(
            child: IconButton(icon: Icon(Icons.share), onPressed: () {}),
            message: 'Share',
          ),
          ButtonBar(
            children: [
              DesktopIcon(
                icon: Icon(Icons.format_align_center_outlined),
                onPressed: () {},
                tooltip: 'Align center',
              ),
              DesktopIcon(
                icon: Icon(Icons.format_align_justify_outlined),
                onPressed: () {},
                tooltip: 'Align justify',
              ),
              DesktopIcon(
                icon: Icon(Icons.format_align_left_outlined),
                onPressed: () {},
                tooltip: 'Align left',
              ),
            ],
            alignment: MainAxisAlignment.start,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: DesktopTooltip(
              child: TextField(),
              message: 'Name',
              offset: 20,
            ),
          ),
          DesktopIcon(
            icon: Icon(Icons.save_outlined),
            onPressed: () {},
            tooltip: 'Save ⌘ + S',
          ),
        ],
      ),
    ),
    DropdownPage(),
    ShortcutPage(),
    ButtonsPage(),
    TestingPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.black87),
              actions: [
                DesktopTooltip(
                  message: 'Share',
                  child: IconButton(
                      icon: Icon(Icons.share_outlined),
                      onPressed: () {},
                      hoverColor: Colors.transparent),
                ),
                IconButton(icon: Icon(Icons.share_outlined), onPressed: () {}),
              ],
              leading: Icon(
                Icons.menu_outlined,
                color: Colors.black,
              ),
              title: Text(
                'Some app',
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: Colors.black,
                    ),
              ),
              backgroundColor: Colors.white,
            ),
          ],
          body: Row(children: [
            NavigationRail(
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.all,
              destinations: [
                NavigationRailDestination(
                  icon: Icon(Icons.text_fields_outlined),
                  selectedIcon: Icon(Icons.text_fields_rounded),
                  label: Text('Tooltips'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.menu_open_outlined),
                  selectedIcon: Icon(Icons.menu_open_rounded),
                  label: Text('Dropdowns'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.keyboard_outlined),
                  selectedIcon: Icon(Icons.keyboard_rounded),
                  label: Text('Shortcuts'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.mouse_outlined),
                  selectedIcon: Icon(Icons.mouse_rounded),
                  label: Text('Buttons'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.science_outlined),
                  selectedIcon: Icon(Icons.science_rounded),
                  label: Text('Testing'),
                ),
              ],
              selectedIndex: _selectedIndex,
            ),
            VerticalDivider(thickness: 1, width: 1),
            Expanded(child: destinations[_selectedIndex])
          ]),
        ),
      ),
    );
  }
}
