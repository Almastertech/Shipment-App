import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shipments/core/resources/app_colors.dart';

class EvidenceThumbnail extends StatefulWidget {
  const EvidenceThumbnail({
    super.key,
    required this.evidence,
    required this.onTap,
    required this.semanticLabel,
  });

  final XFile evidence;
  final VoidCallback onTap;
  final String semanticLabel;

  @override
  State<EvidenceThumbnail> createState() => _EvidenceThumbnailState();
}

class _EvidenceThumbnailState extends State<EvidenceThumbnail> {
  late Future<Uint8List> _imageBytes;

  @override
  void initState() {
    super.initState();
    _imageBytes = widget.evidence.readAsBytes();
  }

  @override
  void didUpdateWidget(covariant EvidenceThumbnail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.evidence.path != widget.evidence.path) {
      _imageBytes = widget.evidence.readAsBytes();
    }
  }

  @override
  Widget build(BuildContext context) {
    const size = 42.0;
    return Semantics(
      button: true,
      label: widget.semanticLabel,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: size,
            height: size,
            child: FutureBuilder<Uint8List>(
              future: _imageBytes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.memory(
                    snapshot.data!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        _thumbnailFallback(),
                  );
                }
                return _thumbnailFallback();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _thumbnailFallback() => ColoredBox(
        color: AppColors.primitives.neutral.shade200,
        child: Icon(
          Icons.image_outlined,
          color: AppColors.primitives.neutral.shade600,
          size: 21,
        ),
      );
}
