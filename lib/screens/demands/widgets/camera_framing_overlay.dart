import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewFill extends StatelessWidget {
  const CameraPreviewFill({super.key, required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) {
          final size = controller.value.previewSize;
          if (size == null) return CameraPreview(controller);
          final width = constraints.maxWidth;
          final height = constraints.maxHeight;
          final previewWidth = size.height;
          final previewHeight = size.width;
          final scale = math.max(width / previewWidth, height / previewHeight);
          return ClipRect(
            child: OverflowBox(
              maxWidth: previewWidth * scale,
              maxHeight: previewHeight * scale,
              child: SizedBox(
                width: previewWidth * scale,
                height: previewHeight * scale,
                child: CameraPreview(controller),
              ),
            ),
          );
        },
      );
}

class CameraFramingOverlay extends StatelessWidget {
  const CameraFramingOverlay({
    super.key,
    this.color = const Color(0xFFFFD34D),
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Center(
        child: SizedBox(
          width: math
              .max(0, math.min(MediaQuery.sizeOf(context).width - 72, 350))
              .toDouble(),
          height:
              math.min(MediaQuery.sizeOf(context).height * .46, 420).toDouble(),
          child: CustomPaint(
            painter: CornerFramePainter(color: color),
          ),
        ),
      ),
    );
  }
}

class CornerFramePainter extends CustomPainter {
  const CornerFramePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    const length = 25.0;
    const radius = 12.0;
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final paths = <Path>[
      Path()
        ..moveTo(1, radius + length)
        ..lineTo(1, radius)
        ..quadraticBezierTo(1, 1, radius, 1)
        ..lineTo(radius + length, 1),
      Path()
        ..moveTo(size.width - radius - length, 1)
        ..lineTo(size.width - radius, 1)
        ..quadraticBezierTo(size.width - 1, 1, size.width - 1, radius)
        ..lineTo(size.width - 1, radius + length),
      Path()
        ..moveTo(1, size.height - radius - length)
        ..lineTo(1, size.height - radius)
        ..quadraticBezierTo(1, size.height - 1, radius, size.height - 1)
        ..lineTo(radius + length, size.height - 1),
      Path()
        ..moveTo(size.width - radius - length, size.height - 1)
        ..lineTo(size.width - radius, size.height - 1)
        ..quadraticBezierTo(
          size.width - 1,
          size.height - 1,
          size.width - 1,
          size.height - radius,
        )
        ..lineTo(size.width - 1, size.height - radius - length),
    ];
    for (final path in paths) {
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CornerFramePainter oldDelegate) =>
      oldDelegate.color != color;
}
