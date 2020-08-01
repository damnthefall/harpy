import 'package:flutter/material.dart';
import 'package:harpy/components/common/animations/animation_constants.dart';

/// Builds an [AnimatedSize] widget with the [child].
///
/// Used to allow using the [AnimatedSize] without having to make a widget
/// stateful.
class CustomAnimatedSize extends StatefulWidget {
  const CustomAnimatedSize({
    @required this.child,
    this.duration = kShortAnimationDuration,
    this.curve = Curves.easeOutCubic,
  });

  final Widget child;

  final Duration duration;

  final Curve curve;

  @override
  _CustomAnimatedSizeState createState() => _CustomAnimatedSizeState();
}

class _CustomAnimatedSizeState extends State<CustomAnimatedSize>
    with SingleTickerProviderStateMixin<CustomAnimatedSize> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      duration: widget.duration,
      curve: widget.curve,
      alignment: Alignment.center,
      child: widget.child,
    );
  }
}
