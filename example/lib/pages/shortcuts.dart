import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShortcutPage extends StatefulWidget {
  @override
  _ShortcutPageState createState() => _ShortcutPageState();
}

class _ShortcutPageState extends State<ShortcutPage> {
  @override
  Widget build(BuildContext context) {
    bool shortcutPressed = false;
    return RawKeyboardListener(
      autofocus: true,
      focusNode: FocusNode(),
      onKey: (key) {
        if (key.data.isControlPressed &&
            key.physicalKey == PhysicalKeyboardKey.keyS &&
            !shortcutPressed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text('You pressed CTRL + S wow'),
            ),
          ).then((value) => shortcutPressed = false);
          shortcutPressed = true;
        }
      },
      child: Center(
          child: Text(
        'Press CTRL + S',
        style: Theme.of(context).textTheme.headline6,
      )),
    );
  }
}
