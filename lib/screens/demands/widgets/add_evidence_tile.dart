import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipments/core/resources/app_colors.dart';
import 'package:shipments/core/resources/app_radius.dart';
import 'package:shipments/screens/demands/widgets/dash_border_painter.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AddEvidenceTile extends StatefulWidget {
  const AddEvidenceTile({
    super.key,
    required this.semanticLabel,
    required this.photo,
    required this.onTap,
  });

  final String semanticLabel;
  final XFile? photo;
  final VoidCallback onTap;

  @override
  State<AddEvidenceTile> createState() => _AddEvidenceTileState();
}

class _AddEvidenceTileState extends State<AddEvidenceTile> {
  Future<Uint8List>? _photoBytes;

  @override
  void initState() {
    super.initState();
    _loadPhoto(widget.photo);
  }

  @override
  void didUpdateWidget(covariant AddEvidenceTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_sameFile(oldWidget.photo, widget.photo)) {
      _loadPhoto(widget.photo);
    }
  }

  bool _sameFile(XFile? first, XFile? second) {
    if (identical(first, second)) return true;
    final firstPath = first?.path;
    final secondPath = second?.path;
    return firstPath != null && firstPath.isNotEmpty && firstPath == secondPath;
  }

  void _loadPhoto(XFile? photo) {
    _photoBytes = photo?.readAsBytes();
  }

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;

    return Semantics(
      button: true,
      label: widget.semanticLabel,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.tokenXl),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(AppRadius.tokenXl),
          child: CustomPaint(
            painter: DashedBorderPainter(color: colors.neutral.shade400),
            child: SizedBox(
              height: 64,
              child: Center(
                child: widget.photo == null
                    ? Icon(
                        Icons.add_rounded,
                        color: colors.neutral.shade600,
                        size: 30,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(AppRadius.tokenXl),
                        child: FutureBuilder<Uint8List>(
                          future: _photoBytes,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Skeletonizer(
                                enabled: true,
                                child: Icon(
                                  Icons.photo_outlined,
                                  color: colors.neutral.shade600,
                                  size: 24,
                                ),
                              );
                            }
                            if (snapshot.hasError || !snapshot.hasData) {
                              return Icon(
                                Icons.photo_outlined,
                                color: colors.neutral.shade600,
                                size: 24,
                              );
                            }
                            return Image.memory(
                              snapshot.data!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 64,
                            );
                          },
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
