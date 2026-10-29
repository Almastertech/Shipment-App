import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../components/app_text.dart';
import '../../../components/images/app_network_image.dart';
import '../../../core/resources/app_colors.dart';
import '../../../core/resources/app_images.dart';
import '../../../core/resources/app_radius.dart';
import '../../../core/resources/app_spacing.dart';
import '../../../core/resources/app_typography.dart';

class ProfileEditAvatarCard extends StatelessWidget {
  const ProfileEditAvatarCard({
    super.key,
    required this.photo,
    required this.photoLabel,
    required this.cameraLabel,
    required this.onChangePhoto,
    this.avatarUrl,
  });

  final XFile? photo;
  final String photoLabel;
  final String cameraLabel;
  final VoidCallback onChangePhoto;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    final radius = BorderRadius.circular(AppRadius.token2Xl);

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.neutral.shade900.withValues(alpha: .12),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: ColoredBox(
          color: colors.primary.shade700,
          child: SizedBox(
            height: 150,
            child: Stack(
              clipBehavior: Clip.hardEdge,
              alignment: Alignment.topCenter,
              children: <Widget>[
                PositionedDirectional(
                  top: -100,
                  end: -80,
                  child: Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.primary.shade500.withValues(alpha: .45),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.tokenM),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      _Avatar(photo: photo, avatarUrl: avatarUrl),
                      const SizedBox(height: AppSpacing.tokenL),
                      AppText(
                        photoLabel,
                        variant: AppTextVariant.labelMedium,
                        textAlign: TextAlign.center,
                        style: AppTypography.buyerMobile.label.toTextStyle(
                          color: colors.accent01.shade300,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 72,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Transform.translate(
                      offset: const Offset(27, 0),
                      child: _CameraButton(
                        label: cameraLabel,
                        onPressed: onChangePhoto,
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

class _Avatar extends StatelessWidget {
  const _Avatar({required this.photo, this.avatarUrl});

  final XFile? photo;
  final String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    final selectedPhoto = photo;
    const fallback = ColoredBox(
      color: Color(0xFF6750A4),
      child: Icon(Icons.person, color: Colors.white, size: 40),
    );
    return ClipOval(
      child: SizedBox(
        width: 80,
        height: 80,
        child: selectedPhoto == null
            ? (avatarUrl == null || avatarUrl!.isEmpty
                ? fallback
                : AppNetworkImage(
                    imageUrl: avatarUrl!,
                    width: 80,
                    height: 80,
                    error: (_) => fallback,
                  ))
            : kIsWeb
                ? Image.network(
                    selectedPhoto.path,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => fallback,
                  )
                : Image.file(
                    File(selectedPhoto.path),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => fallback,
                  ),
      ),
    );
  }
}

class _CameraButton extends StatelessWidget {
  const _CameraButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    const colors = AppColors.primitives;
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: colors.accent01.shade300,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          customBorder: const CircleBorder(),
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              border: Border.fromBorderSide(
                BorderSide(color: Colors.white, width: 2),
              ),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppImages.camera,
              width: 16,
              height: 16,
              colorFilter: const ColorFilter.mode(
                Color(0xFF16161A),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
