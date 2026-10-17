import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AnimatedLogoPart extends StatelessWidget {
  const AnimatedLogoPart({
    super.key,
    required this.animation,
    required this.assetName,
    required this.width,
    required this.height,
    required this.beginVerticalOffset,
    required this.endVerticalOffset,
  });

  final Animation<double> animation;
  final String assetName;
  final double width;
  final double height;
  final double beginVerticalOffset;
  final double endVerticalOffset;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: SvgPicture.asset(
        assetName,
        width: width,
        height: height,
      ),
      builder: (context, child) {
        final progress = Curves.easeOutCubic.transform(animation.value);
        final verticalOffset = beginVerticalOffset +
            (endVerticalOffset - beginVerticalOffset) * progress;

        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(0, verticalOffset),
            child: child,
          ),
        );
      },
    );
  }
}
