import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import 'dropdown.dart';

/// A class to use static functions for desktop utilities like `showSnackBar` or `showMenu`
class DesktopUtility {
  /// Show a snackbar in the [material desktop design](https://lh3.googleusercontent.com/McX7kFC9J8UqboDppQ0fBDdMbWHlodR-7FBcuB9IyHzoTYSEkEp_3ymLuhfnI8scuv4PMwNVHnPVTiaGohJSHauattiD_8owV8Mo8A=w1064-v0).
  /// Not like a normal snackbar, this widget does not need a [Scaffold Context]. It only needs a normal [BuildContext].
  ///  The snackbar uses the [SnackBarThemeData] of the `Theme.of(context)` and `MediaQuery.of(context).accessibleNavigation` to determine wether to show or skip the navigation.
  ///
  /// [content] is the widget displayed in the snackbar. Typically, this is a [Text] widget.
  ///
  /// [action] is the widget placed on the right of the snackbar.Typically, this is a [TextButton] widget.
  ///
  ///_Example_:
  /// ```
  ///           DesktopUtility.showSnackBar(
  ///             context,
  ///             content: Text('Deleted 23 Photos'),
  ///             action: TextButton(
  ///               onPressed: () {},
  ///               child: Text('UNDO'),
  ///             ),
  ///           );
  /// ```

  //TODO: Add Choosable positioning.
  static void showSnackBar(
    BuildContext context, {
    @required Widget content,
    Widget action,
    Duration duration = const Duration(seconds: 2),
  }) async {
    SnackBarThemeData theme = Theme.of(context).snackBarTheme;
    var _snackBar = _DesktopSnackbar(
      action: action,
      content: content,
      theme: theme,
    );

    var _bar = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: 20,
          right: 20,
          child: Builder(
            builder: (context) => Container(
              constraints: BoxConstraints(maxWidth: 344, maxHeight: 68),
              width: 344,
              child: Theme(
                  data: Theme.of(context).brightness == Brightness.dark
                      ? ThemeData.light()
                      : ThemeData.dark(),
                  child: _snackBar),
            ),
          ),
        );
      },
    );
    Overlay.of(context).insert(_bar);
    await Future.delayed(duration);
    _bar.remove();
  }

  /// Shows a dropdown menu for desktop. This has no appering animation and is `dense` by default.
  /// The Widget is also scrollable.
  /// Closes when you click outside it or when a scroll outside is detectet.
  ///
  /// If this dropdown is `dense`. [Dropdown menu specs](https://material.io/components/menus#specs) will apply.
  /// `dense` is `true` by default.
  ///
  ///The `items` are typically a List of [DesktopDropdownItem].
  ///`dense` only works for [DesktopDropdownItem].
  static void showMenu(BuildContext context,
      {@required final List<Widget> items,
      final bool dense = true,
      final bool short = false,
      final double maxHeight}) {
    OverlayEntry _overlayEntry;
    OverlayState overlayState;

    OverlayEntry _createOverlayEntry() {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      overlayState = Overlay.of(
        context,
      );

      final Offset target = renderBox.localToGlobal(
        Offset.zero,
        ancestor: overlayState.context.findRenderObject(),
      );
      if (Scrollable.of(context) != null) {
        Scrollable.of(context).position.addListener(() {
          if (_overlayEntry != null) {
            _overlayEntry.remove();
            _overlayEntry = null;
          }
        });
      }

      return OverlayEntry(
        builder: (context) => Stack(
          children: [
            Positioned(
              left: target.dx,
              top: target.dy + renderBox.size.height,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 50,
                  minWidth: 56,
                  maxHeight: maxHeight != null ? maxHeight : double.infinity,
                  maxWidth: short
                      ? 112
                      : dense
                          ? 320
                          : 280,
                ),
                child: Material(
                  type: MaterialType.card,
                  elevation: 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                    child: Scrollbar(
                      radius: Radius.circular(12),
                      thickness: 5,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          if (items[index] is DesktopDropdownItem) {
                            DesktopDropdownItem item = items[index];
                            return item.copyWith(dense: item.dense);
                          }
                          return items[index];
                        },
                        itemCount: items.length,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onSecondaryTap: () {
                _overlayEntry.remove();
                _overlayEntry = null;
              },
              onTap: () {
                _overlayEntry.remove();
                _overlayEntry = null;
              },
            ),
          ],
        ),
      );
    }

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry);
  }
}

class _DesktopSnackbar extends StatefulWidget {
  final Widget content;
  final Widget action;
  final SnackBarThemeData theme;

  const _DesktopSnackbar({Key key, this.content, this.action, this.theme})
      : super(key: key);
  @override
  __DesktopSnackbarState createState() => __DesktopSnackbarState();
}

class __DesktopSnackbarState extends State<_DesktopSnackbar>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 150),
      reverseDuration: Duration(milliseconds: 75),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    var _bar = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      elevation: 12,
      color: widget.theme.backgroundColor,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 16, end: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: widget.content,
              ),
            ),
            if (widget.action != null)
              TextButtonTheme(
                data: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                  ),
                ),
                child: widget.action,
              ),
          ],
        ),
      ),
    );

    return MediaQuery.of(context).accessibleNavigation
        ? _bar
        : FadeScaleTransition(
            child: _bar,
            animation:
                CurvedAnimation(parent: _controller, curve: Curves.easeOut),
          );
  }
}
