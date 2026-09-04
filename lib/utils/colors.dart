import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// ألوان التطبيق
class AppColors {
  // الألوان الأساسية
  static const primary = Color(0xFF6366F1); // أزرق بنفسجي
  static const secondary = Color(0xFF10B981); // أخضر
  static const accent = Color(0xFFF59E0B); // برتقالي
  static const danger = Color(0xFFEF4444); // أحمر
  static const warning = Color(0xFFEAB308); // أصفر
  static const success = Color(0xFF10B981); // أخضر
  static const info = Color(0xFF3B82F6); // أزرق

  // ألوان النصوص
  static const textPrimary = Color(0xFF1F2937);
  static const textSecondary = Color(0xFF6B7280);
  static const textTertiary = Color(0xFF9CA3AF);

  // ألوان الخلفيات
  static const bgLight = Color(0xFFFAFAFA);
  static const bgDark = Color(0xFF111827);
  static const bgCard = Color(0xFFFFFFFF);
  static const bgCardDark = Color(0xFF1F2937);

  // ألوان الحدود
  static const borderLight = Color(0xFFE5E7EB);
  static const borderDark = Color(0xFF374151);
}

/// الثيمات (المواضيع)
class AppThemes {
  /// الثيم الفاتح
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.bgLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: AppColors.bgCard,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: AppColors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.textSecondary,
      ),
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: AppColors.primary,
    ),
  );

  /// الثيم المظلم
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.bgDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F2937),
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardTheme(
      color: AppColors.bgCardDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: AppColors.textTertiary,
      ),
    ),
    cupertinoOverrideTheme: const CupertinoThemeData(
      primaryColor: AppColors.primary,
    ),
  );
}
