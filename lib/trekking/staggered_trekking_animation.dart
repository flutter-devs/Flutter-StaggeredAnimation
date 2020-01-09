import 'package:flutter/material.dart';
import 'package:stag_animation/trekking/staggered_trekking.dart';

class StaggeredTrekkingAnimation extends StatefulWidget {
  @override
  _StaggeredTrekkingAnimationState createState() =>
      _StaggeredTrekkingAnimationState();
}

class _StaggeredTrekkingAnimationState extends State<StaggeredTrekkingAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3500),
      vsync: this,
    );
    _controller.forward();
  }

  Future<void> _playAnimation() async {
    try {
      await _controller.forward().orCancel;
      await _controller.reverse().orCancel;
    } on TickerCanceled {
      // the animation got canceled, probably because we were disposed
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        _playAnimation();
      },
      child: StaggeredTrekking(
        controller: _controller,
      ),
    );
  }
}
