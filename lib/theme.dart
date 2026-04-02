import 'package:flutter/material.dart';

abstract final class AppColorTokens {
  static const background = Color.fromARGB(255, 24, 27, 33);
  static const surface = Color(0xFF1A1D24);
  static const primary = Color(0xFF1E88E5);
  static const accent = Color.fromARGB(255, 48, 52, 61);
  static const progressBar = Color(0xFF424242);
  static const textMuted = Color(0xFFB0B0B0);
  static const textPrimary = Color(0xFFF4F2F2);
  static const warning = Color(0xFFFFD600);
  static const success = Color(0xFF4CAF50);
  static const error = Color(0xFFE53935);
}

@immutable
class AppColors {
  const AppColors({
    required this.primary,
    required this.background,
    required this.accent,
    required this.warning,
    required this.success,
    required this.error,
    required this.progressBar,
  });

  final Color primary;
  final Color background;
  final Color accent;
  final Color warning;
  final Color success;
  final Color error;
  final Color progressBar;

  static AppColors lerp(AppColors? a, AppColors? b, double t) {
    return AppColors(
      primary: Color.lerp(a?.primary, b?.primary, t)!,
      background: Color.lerp(a?.background, b?.background, t)!,
      accent: Color.lerp(a?.accent, b?.accent, t)!,
      warning: Color.lerp(a?.warning, b?.warning, t)!,
      success: Color.lerp(a?.success, b?.success, t)!,
      error: Color.lerp(a?.error, b?.error, t)!,
      progressBar: Color.lerp(a?.progressBar, b?.progressBar, t)!,
    );
  }
}

@immutable
class AppTypography {
  const AppTypography({
    required this.small,
    required this.basic,
    required this.header,
    required this.pageTitle,
  });

  final TextStyle small;
  final TextStyle basic;
  final TextStyle header;
  final TextStyle pageTitle;

  static AppTypography lerp(AppTypography? a, AppTypography? b, double t) {
    return AppTypography(
      small: TextStyle.lerp(a?.small, b?.small, t)!,
      basic: TextStyle.lerp(a?.basic, b?.basic, t)!,
      header: TextStyle.lerp(a?.header, b?.header, t)!,
      pageTitle: TextStyle.lerp(a?.pageTitle, b?.pageTitle, t)!,
    );
  }
}

@immutable
class AppStyles extends ThemeExtension<AppStyles> {
  const AppStyles({required this.colors, required this.font});

  final AppColors colors;
  final AppTypography font;

  @override
  AppStyles copyWith({AppColors? colors, AppTypography? font}) {
    return AppStyles(colors: colors ?? this.colors, font: font ?? this.font);
  }

  @override
  AppStyles lerp(ThemeExtension<AppStyles>? other, double t) {
    if (other is! AppStyles) return this;
    return AppStyles(
      colors: AppColors.lerp(colors, other.colors, t),
      font: AppTypography.lerp(font, other.font, t),
    );
  }
}

final darkTheme = ThemeData(
  extensions: [
    AppStyles(
      colors: AppColors(
        primary: AppColorTokens.primary,
        background: AppColorTokens.background,
        accent: AppColorTokens.accent,
        progressBar: AppColorTokens.progressBar,
        warning: AppColorTokens.warning,
        success: AppColorTokens.success,
        error: AppColorTokens.error,
      ),
      font: AppTypography(
        small: TextStyle(fontSize: 12, color: AppColorTokens.textMuted),
        basic: TextStyle(
          fontSize: 16,
          color: AppColorTokens.textMuted,
          height: 1.5,
        ),
        header: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColorTokens.textPrimary,
        ),
        pageTitle: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w800,
          color: Colors.white,
        ),
      ),
    ),
  ],
);

extension ThemeDataStyles on ThemeData {
  AppStyles get styles => extension<AppStyles>()!;
}
