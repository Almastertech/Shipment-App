import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../components/app_text.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';
import '../../../l10n/app_localizations.dart';

class DemandReviewEvidenceGrid extends StatelessWidget {
  const DemandReviewEvidenceGrid({
    super.key,
    required this.evidence,
    required this.optionalPhotos,
    required this.onRetakeEvidence,
    required this.onAddOptionalPhoto,
  });

  final List<XFile?> evidence;
  final List<XFile?> optionalPhotos;
  final ValueChanged<int> onRetakeEvidence;
  final ValueChanged<int> onAddOptionalPhoto;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final nextOptionalIndex = optionalPhotos.indexWhere((p) => p == null);
    final optionalAddIndex = nextOptionalIndex == -1 ? 0 : nextOptionalIndex;
    final hasOptionalPhoto =
        optionalPhotos.isNotEmpty && optionalPhotos.first != null;

    return Row(
      children: <Widget>[
        for (var index = 0; index < 3; index++) ...<Widget>[
          if (index > 0) const SizedBox(width: AppSpacing.tokenXs),
          Expanded(
            child: DemandReviewEvidenceTile(
              evidence: evidence[index],
              video: index == 2,
              label: switch (index) {
                0 => l10n.demandReviewLabelPhoto,
                1 => l10n.demandReviewPackagingPhoto,
                _ => l10n.demandReviewVideo,
              },
              onTap: () => onRetakeEvidence(index),
            ),
          ),
        ],
        const SizedBox(width: AppSpacing.tokenXs),
        Expanded(
          child: DemandReviewEvidenceTile(
            evidence: optionalPhotos.isEmpty ? null : optionalPhotos.first,
            label: l10n.demandReviewAdditionalPhoto,
            onTap: () => onAddOptionalPhoto(optionalAddIndex),
            isAddTile: !hasOptionalPhoto,
          ),
        ),
      ],
    );
  }
}

class DemandReviewEvidenceTile extends StatefulWidget {
  const DemandReviewEvidenceTile({
    super.key,
    required this.evidence,
    required this.label,
    required this.onTap,
    this.video = false,
    this.isAddTile = false,
  });

  final XFile? evidence;
  final String label;
  final VoidCallback onTap;
  final bool video;
  final bool isAddTile;

  @override
  State<DemandReviewEvidenceTile> createState() =>
      _DemandReviewEvidenceTileState();
}

class _DemandReviewEvidenceTileState extends State<DemandReviewEvidenceTile> {
  Future<Uint8List>? _evidenceBytes;

  @override
  void initState() {
    super.initState();
    _loadEvidence(widget.evidence, widget.video);
  }

  @override
  void didUpdateWidget(covariant DemandReviewEvidenceTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_sameFile(oldWidget.evidence, widget.evidence) ||
        oldWidget.video != widget.video) {
      _loadEvidence(widget.evidence, widget.video);
    }
  }

  bool _sameFile(XFile? first, XFile? second) {
    if (identical(first, second)) return true;
    final firstPath = first?.path;
    final secondPath = second?.path;
    return firstPath != null && firstPath.isNotEmpty && firstPath == secondPath;
  }

  void _loadEvidence(XFile? evidence, bool video) {
    _evidenceBytes = evidence != null && !video ? evidence.readAsBytes() : null;
  }

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Semantics(
      button: true,
      label: widget.label,
      child: GestureDetector(
        onTap: widget.onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 92,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                if (widget.evidence != null && !widget.video)
                  FutureBuilder<Uint8List>(
                    future: _evidenceBytes,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.memory(snapshot.data!, fit: BoxFit.cover);
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Skeletonizer(
                          enabled: true,
                          child: ColoredBox(color: colors.neutral.shade300),
                        );
                      }
                      if (snapshot.hasError) {
                        return ColoredBox(
                          color: colors.neutral.shade300,
                          child: const Center(
                            child: Icon(Icons.broken_image_outlined),
                          ),
                        );
                      }
                      return ColoredBox(color: colors.neutral.shade300);
                    },
                  )
                else
                  ColoredBox(
                    color: widget.video
                        ? colors.neutral.shade800
                        : colors.neutral.shade300,
                    child: Center(
                      child: Icon(
                        widget.isAddTile
                            ? Icons.add_rounded
                            : widget.video
                                ? Icons.play_arrow_rounded
                                : Icons.image_outlined,
                        color: Colors.white,
                        size: widget.isAddTile ? 28 : 32,
                      ),
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    color: Colors.black.withValues(alpha: .68),
                    child: AppText(
                      widget.label,
                      variant: AppTextVariant.labelSmall,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.buyerMobile.caption.toTextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
