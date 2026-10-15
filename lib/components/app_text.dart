import 'package:flutter/material.dart';

import '../core/resources/app_colors.dart';
import '../core/resources/app_typography.dart';
import '../l10n/app_localizations.dart';

typedef AppTextLocalizationResolver = String Function(AppLocalizations l10n);

enum AppTextVariant {
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,
}

class AppText extends StatelessWidget {
  const AppText(
    this.value, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
  })  : localizationResolver = null,
        textSpan = null;

  const AppText.localized(
    this.localizationResolver, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
  })  : value = null,
        textSpan = null;

  const AppText.rich(
    this.textSpan, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textDirection,
  })  : value = null,
        localizationResolver = null;

  final String? value;
  final AppTextLocalizationResolver? localizationResolver;
  final InlineSpan? textSpan;
  final AppTextVariant variant;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;
  final TextDirection? textDirection;

  @override
  Widget build(BuildContext context) {
    final resolvedText = _resolveText(context);
    final baseStyle = _resolveVariantStyle(
      AppTypography.textTheme(context.appColors),
    );
    final mergedStyle = baseStyle?.merge(style) ?? style;

    final span = textSpan;
    if (span != null) {
      return Text.rich(
        span,
        style: mergedStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        maxLines: maxLines,
        overflow: overflow,
        softWrap: softWrap,
      );
    }

    return Text(
      resolvedText,
      style: mergedStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }

  String _resolveText(BuildContext context) {
    if (value != null) return value!;

    final resolver = localizationResolver;
    if (resolver != null) {
      final l10n = AppLocalizations.of(context);
      if (l10n != null) return resolver(l10n);
    }

    return '';
  }

  TextStyle? _resolveVariantStyle(TextTheme textTheme) {
    return switch (variant) {
      AppTextVariant.headlineLarge => textTheme.headlineLarge,
      AppTextVariant.headlineMedium => textTheme.headlineMedium,
      AppTextVariant.headlineSmall => textTheme.headlineSmall,
      AppTextVariant.titleLarge => textTheme.titleLarge,
      AppTextVariant.titleMedium => textTheme.titleMedium,
      AppTextVariant.titleSmall => textTheme.titleSmall,
      AppTextVariant.bodyLarge => textTheme.bodyLarge,
      AppTextVariant.bodyMedium => textTheme.bodyMedium,
      AppTextVariant.bodySmall => textTheme.bodySmall,
      AppTextVariant.labelLarge => textTheme.labelLarge,
      AppTextVariant.labelMedium => textTheme.labelMedium,
      AppTextVariant.labelSmall => textTheme.labelSmall,
    };
  }
}
