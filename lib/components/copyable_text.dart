import 'package:desktop_util/desktop_util.dart';
import 'package:flutter/material.dart';


class CopyableText extends StatefulWidget {
  @override
  _CopyableTextState createState() => _CopyableTextState();
}

class _CopyableTextState extends State<CopyableText> {
  String text = 'Right click meee';

  @override
  Widget build(BuildContext context) {
    String _selectedText = text;
    return GestureDetector(
      child: SelectableText(
        text,
        onSelectionChanged: (selection, cause) {
          _selectedText = selection.textInside(text);
        },
      ),
      onSecondaryTap: () {
        print('menueus');
        DesktopUtility.showMenu(
          context,
          dense: true,
          short: true,
          items: [
            DesktopDropdownItem(
              title: Text('copy'),
              onClick: () {
                
              },
            ),
            DesktopDropdownItem(title: Text('Redo')),
            Divider(
              thickness: 1,
            ),
            DesktopDropdownItem(title: Text('Paste')),
          ],
        );
      },
    );
  }
}
