import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'desktop_tooltip.dart';

class DesktopIcon extends StatefulWidget {
  final Icon icon;
  final MouseCursor mouseCursor;
  final VoidCallback onPressed;
  final String tooltip;

  const DesktopIcon(
      {Key key,
      @required this.icon,
      this.mouseCursor,
      @required this.onPressed,
      this.tooltip})
      : super(key: key);
  @override
  _DesktopIconState createState() => _DesktopIconState();
}

class _DesktopIconState extends State<DesktopIcon> {
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    Widget button = IconButton(
      color: isHovered ? Colors.black54 : Colors.black45,
      hoverColor: Colors.transparent,
      icon: widget.icon,
      mouseCursor: widget.mouseCursor ?? SystemMouseCursors.click,
      onPressed: () {
        widget.onPressed();
      },
    );
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovered = false;
        });
      },
      child: widget.tooltip != null
          ? DesktopTooltip(message: widget.tooltip, child: button)
          : button,
    );
  }
}
