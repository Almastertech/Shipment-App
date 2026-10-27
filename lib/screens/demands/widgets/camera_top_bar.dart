import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class CameraTopBar extends StatelessWidget {
  const CameraTopBar({
    super.key,
    required this.categoryIndex,
    required this.onClose,
    this.onHelp,
  });

  final int categoryIndex;
  final VoidCallback onClose;
  final VoidCallback? onHelp;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final progress = categoryIndex + 1;
    final title = switch (categoryIndex) {
      0 => l10n.cameraGuideTitle,
      1 => l10n.demandDetailsEvidencePackaging,
      _ => l10n.demandDetailsEvidenceDamageVideo,
    };
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.paddingOf(context).top + 12,
        20,
        8,
      ),
      child: Column(
        children: <Widget>[
          Row(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              IconButton.filledTonal(
                tooltip: l10n.cameraHelp,
                onPressed: onHelp ?? () {},
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0x332B2E3A),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.help_outline_rounded),
              ),
              const Spacer(),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: const Color(0x332B2E3A),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  child: Text(
                    '$progress ${isAr ? 'من' : 'of'} 3',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const Spacer(),
              IconButton.filledTonal(
                tooltip: l10n.close,
                onPressed: onClose,
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0x332B2E3A),
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
