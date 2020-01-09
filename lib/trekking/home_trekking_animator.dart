import 'package:flutter/material.dart';
import 'package:stag_animation/trekking/home_trekking.dart';

class HomeTrekkingAnimator extends StatefulWidget {
  @override
  _HomeTrekkingAnimatorState createState() => _HomeTrekkingAnimatorState();
}

class _HomeTrekkingAnimatorState extends State<HomeTrekkingAnimator>
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
      child: HomeTrekking(
        controller: _controller,
      ),
    );
  }
}
