import 'package:desktop_util/desktop_util.dart';
import 'package:flutter/material.dart';

class ButtonsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        child: Text('Show Snackbar'),
        onPressed: () {
          DesktopUtility.showSnackBar(
            context,
            content: Text('Deleted 23 Photos'),
            action: TextButton(
              onPressed: () {},
              child: Text('UNDO'),
            ),
          );
        },
      ),
    );
  }
}
