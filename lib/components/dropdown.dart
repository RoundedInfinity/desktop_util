import 'package:flutter/material.dart';

import 'utility.dart';



/// A [TextButton] that shows a material-style desktop dropdown menu when pressed.
class DesktopDropdownButton extends StatefulWidget {
  final List<Widget> items;
  /// If this dropdown is dense menu. [Dropdown menu specs](https://material.io/components/menus#specs)
  /// 
  /// is `true` by default.
  final bool dense;
  final bool short;
  final double maxHeight;
  final Text text;
  final ButtonStyle style;

  const DesktopDropdownButton(
      {Key key,
      @required this.items,
      this.dense = true,
      this.short = false,
      this.maxHeight,
      this.text, this.style})
      : super(key: key);
  @override
  _DesktopDropdownButtonState createState() => _DesktopDropdownButtonState();
}



class _DesktopDropdownButtonState extends State<DesktopDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
     
          DesktopUtility.showMenu(context,
              dense: widget.dense,
              items: widget.items,
              maxHeight: widget.maxHeight,
              short: widget.short);
        },
        child: widget.text);
  }
}
/// An item in a menu created by a [DesktopDropdownButton].
class DesktopDropdownItem extends StatelessWidget {
  /// The Widget shown before the title. 
  final Widget leading;
  final Widget title;

  /// The Widget shown after  the title. 
  final Widget trailing;

  /// If this item is in a dense list.
  /// 
  /// Will be `true` when:
  /// `DesktopUtility.showMenu()` was called with `dense = true`.
  final bool dense;
  
  /// Called when this list item was clicked.
  final VoidCallback onClick;
  const DesktopDropdownItem({
    Key key,
    this.leading,
    this.title,
    this.trailing,
    this.dense = false,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool notNull(Object o) => o != null;
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: dense ? 12 : 24, vertical: 8),
        child: Opacity(
          opacity: onClick != null ? 1 : 0.5,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              leading != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: IconTheme(
                        child: leading,
                        data: dense
                            ? Theme.of(context).iconTheme.copyWith(size: 24)
                            : Theme.of(context).iconTheme,
                      ))
                  : null,
              title,
              trailing != null ? Spacer() : null,
              trailing != null
                  ? DefaultTextStyle(
                      child: trailing,
                      style: Theme.of(context).textTheme.caption.copyWith(),
                    )
                  : null,
            ].where(notNull).toList(),
          ),
        ),
      ),
    );
  }

  DesktopDropdownItem copyWith({
    Widget leading,
    Widget title,
    Widget trailing,
    bool dense,
    VoidCallback onClick,
  }) {
    return DesktopDropdownItem(
      leading: leading ?? this.leading,
      title: title ?? this.title,
      trailing: trailing ?? this.trailing,
      dense: dense ?? this.dense,
      onClick: onClick ?? this.onClick,
    );
  }
}
