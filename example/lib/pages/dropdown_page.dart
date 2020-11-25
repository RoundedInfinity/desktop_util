import 'package:desktop_util/desktop_util.dart';
import 'package:flutter/material.dart';

class DropdownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Builder(builder: (context) => CopyableText()),
        DesktopDropdownButton(
          text: Text('Dropdown 1'),
          items: [
            DesktopDropdownItem(
              title: Text('Undo'),
              leading: Icon(Icons.undo_outlined),
              trailing: Text('CTRL + Y'),
            ),
            DesktopDropdownItem(
              title: Text('Redo'),
              leading: Icon(Icons.redo_outlined),
              trailing: Text('CTRL + Z'),
            ),
            Divider(
              thickness: 1,
            ),
            DesktopDropdownItem(
              title: Text('Paste'),
              trailing: Icon(Icons.arrow_right_outlined),
            ),
            DesktopDropdownItem(
              title: Text('Paste'),
              trailing: Icon(Icons.arrow_right_outlined),
            ),
            DesktopDropdownItem(
              title: Text('Paste'),
              trailing: Icon(Icons.arrow_right_outlined),
            ),
            DesktopDropdownItem(
              title: Text('Paste'),
              trailing: Icon(Icons.arrow_right_outlined),
            ),
          ],
        ),
        DesktopDropdownButton(
          text: Text('Dropdown 2'),
          dense: true,
          items: [
            DesktopDropdownItem(
              title: Text('Bold'),
              trailing: Text('CTRL + B'),
              onClick: () {},
            ),
            DesktopDropdownItem(
              title: Text('Underlined'),
              trailing: Text('CTRL + U'),
              onClick: () {},
            ),
            Divider(
              thickness: 1,
            ),
            DesktopDropdownItem(
              title: Text('Italic'),
              trailing: Text('CTRL + I'),
              onClick: () {},
            ),
          ],
        ),
        DesktopDropdownButton(
          text: Text('Dropdown 3'),
          dense: true,
          maxHeight: 200,
          items: [
            DesktopDropdownItem(
              title: Text('Bold'),
              trailing: Text('CTRL + B'),
              onClick: () {},
            ),
            DesktopDropdownItem(
              title: Text('Underlined'),
              trailing: Text('CTRL + U'),
              onClick: () {},
            ),
            Divider(
              thickness: 1,
            ),
            DesktopDropdownItem(
              title: Text('Italic'),
              trailing: Text('CTRL + I'),
              onClick: () {},
            ),
            DesktopDropdownItem(
              title: Text('Italic'),
              trailing: Text('CTRL + I'),
              onClick: () {},
            ),
            DesktopDropdownItem(
              title: Text('Italic'),
              trailing: Text('CTRL + I'),
              onClick: () {},
            ),
            DesktopDropdownItem(
              title: Text('Italic'),
              trailing: Text('CTRL + I'),
              onClick: () {},
            ),
            DesktopDropdownItem(
              title: Text('Italic'),
              trailing: Text('CTRL + I'),
              onClick: () {},
            ),
          ],
        ),
      ],
    ));
  }
}
