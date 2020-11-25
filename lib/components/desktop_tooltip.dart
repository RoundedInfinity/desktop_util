import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DesktopTooltip extends StatefulWidget {
  final Widget child;
  final String message;
  final Widget text;
  final double offset;

  const DesktopTooltip(
      {Key key, this.child, @required this.message, this.text, this.offset = 0})
      : super(key: key);
  @override
  _DesktopTooltipState createState() => _DesktopTooltipState();
}

class _DesktopTooltipState extends State<DesktopTooltip> {
  OverlayEntry _overlayEntry;
  bool hide = false;
  OverlayState overlayState;

  void showOverlay() {
    if (_overlayEntry == null) {
      _overlayEntry = _createOverlayEntry();
      Overlay.of(context).insert(_overlayEntry);
    }
  }

  void hideOverlay() {
    if (overlayState != null) {
      overlayState.setState(() {
        hide = true;
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    overlayState = Overlay.of(
      context,
      debugRequiredFor: widget,
    );

    final Offset target = renderBox.localToGlobal(
      renderBox.size.center(Offset.zero),
      ancestor: overlayState.context.findRenderObject(),
    );

    return OverlayEntry(
      builder: (context) {
        return Positioned.fill(
          child: CustomSingleChildLayout(
            delegate: _TooltipPositionDelegate(
                preferBelow: true, target: target, verticalOffset: 20),
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 24),
              child: Transform.translate(
                offset: Offset(0, widget.offset),
                child: _Tooltip(
                  message: widget.message,
                  text: widget.text,
                  hide: hide,
                  onClose: () {
                    if (_overlayEntry != null) {
                      _overlayEntry.remove();
                      _overlayEntry = null;
                      hide = false;
                    }
                  },
                  duration: Duration(milliseconds: 100),
                  reserveDuration: Duration(milliseconds: 60),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => showOverlay(),
      onExit: (event) => hideOverlay(),
      cursor: MouseCursor.uncontrolled,
      child: widget.child,
    );
  }
}

class _Tooltip extends StatefulWidget {
  final Widget text;
  final String message;
  final Duration duration;
  final Duration reserveDuration;
  final bool hide;
  final VoidCallback onClose;

  const _Tooltip(
      {Key key,
      this.text,
      this.message,
      this.duration,
      this.hide = false,
      this.onClose,
      this.reserveDuration})
      : super(key: key);

  @override
  __TooltipState createState() => __TooltipState();
}

class __TooltipState extends State<_Tooltip>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
        reverseDuration: widget.reserveDuration)
      ..addListener(() {
        if (_controller.status == AnimationStatus.dismissed && widget.hide) {
          widget.onClose();
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    widget.onClose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hide) {
      _controller.reverse();
    } else {
      _controller.forward();
    }

    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: FadeScaleTransition(
        animation: CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            widthFactor: 1.0,
            heightFactor: 1.0,
            child: widget.text == null
                ? Text(
                    widget.message,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        .copyWith(color: Colors.white, fontSize: 12),
                  )
                : widget.text,
          ),
        ),
      ),
    );
  }
}

class _TooltipPositionDelegate extends SingleChildLayoutDelegate {
  /// Creates a delegate for computing the layout of a tooltip.
  ///
  /// The arguments must not be null.
  _TooltipPositionDelegate({
    @required this.target,
    @required this.verticalOffset,
    @required this.preferBelow,
  })  : assert(target != null),
        assert(verticalOffset != null),
        assert(preferBelow != null);

  /// The offset of the target the tooltip is positioned near in the global
  /// coordinate system.
  final Offset target;

  /// The amount of vertical distance between the target and the displayed
  /// tooltip.
  final double verticalOffset;

  /// Whether the tooltip is displayed below its widget by default.
  ///
  /// If there is insufficient space to display the tooltip in the preferred
  /// direction, the tooltip will be displayed in the opposite direction.
  final bool preferBelow;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
    );
  }

  @override
  bool shouldRelayout(_TooltipPositionDelegate oldDelegate) {
    return target != oldDelegate.target ||
        verticalOffset != oldDelegate.verticalOffset ||
        preferBelow != oldDelegate.preferBelow;
  }
}
