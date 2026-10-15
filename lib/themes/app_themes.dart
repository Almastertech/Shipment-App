import 'package:flutter/material.dart';
import '../core/resources/app_colors.dart';
import '../core/resources/app_icon_size.dart';
import '../core/resources/app_radius.dart';
import '../core/resources/app_spacing.dart';
import '../core/resources/app_tap_target.dart';
import '../core/resources/app_typography.dart';

class AppThemes {
  static ThemeData get light {
    const palette = AppColors.light;
    final textTheme = AppTypography.textTheme(palette);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: palette.seed,
      brightness: Brightness.light,
    ).copyWith(
      primary: palette.surface.action,
      onPrimary: palette.text.onActionLight,
      secondary: palette.surface.actionSecondary,
      onSecondary: palette.text.onActionLight,
      tertiary: palette.surface.decorative01,
      error: palette.surface.danger,
      onError: palette.text.onActionLight,
      surface: palette.surface.primary,
      onSurface: palette.text.heading,
      onSurfaceVariant: palette.text.body,
      outline: palette.border.actionOutline,
      surfaceContainerHighest: palette.surface.natural200,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.fontFamily,
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.surface.bg,
      textTheme: textTheme,
      dividerColor: palette.border.actionOutline,
      iconTheme: IconThemeData(
        size: AppIconSize.iconM,
        color: palette.icon.primary,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size.square(AppTapTarget.iconButton),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleLarge,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: AppTapTarget.minButtonSize,
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: AppTapTarget.minButtonSize,
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(
            AppTapTarget.minInteractiveSize,
            AppTapTarget.minInteractiveSize,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.surface.inputFlatListPrimary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        hintStyle: textTheme.bodyMedium,
        prefixIconColor: palette.icon.secondary,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: colorScheme.error, width: 1.8),
        ),
      ),
      cardTheme: CardThemeData(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: palette.surface.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.xl)),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xxs,
        ),
      ),
    );
  }

  static ThemeData get dark {
    const palette = AppColors.dark;
    final textTheme = AppTypography.textTheme(palette);
    final colorScheme = ColorScheme.fromSeed(
      seedColor: palette.seed,
      brightness: Brightness.dark,
    ).copyWith(
      primary: palette.surface.action,
      onPrimary: palette.text.heading,
      secondary: palette.surface.actionSecondary,
      onSecondary: palette.text.onActionLight,
      tertiary: palette.surface.decorative01,
      error: palette.surface.danger,
      onError: palette.text.onActionLight,
      surface: palette.surface.primary,
      onSurface: palette.text.heading,
      onSurfaceVariant: palette.text.body,
      outline: palette.border.actionOutline,
      surfaceContainerHighest: palette.surface.actionDisabled,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: AppTypography.fontFamily,
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: palette.surface.bg,
      textTheme: textTheme,
      dividerColor: palette.border.actionOutline,
      iconTheme: IconThemeData(
        size: AppIconSize.iconM,
        color: palette.icon.primary,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          minimumSize: const Size.square(AppTapTarget.iconButton),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: textTheme.titleLarge,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: AppTapTarget.minButtonSize,
          elevation: 0,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: AppTapTarget.minButtonSize,
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            color: colorScheme.primary,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: const Size(
            AppTapTarget.minInteractiveSize,
            AppTapTarget.minInteractiveSize,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.xs,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.surface.inputFlatListPrimary.withValues(alpha: 0.08),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          borderSide: BorderSide(color: colorScheme.primary, width: 1.8),
        ),
      ),
      cardTheme: CardThemeData(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: palette.surface.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(AppRadius.xl)),
        ),
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xxs,
        ),
      ),
    );
  }
}
