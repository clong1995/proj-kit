import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rpx/ext.dart';

ThemeData appTheme({Color? color}) {
  final TextStyle textStyle = TextStyle(fontSize: 14.r);
  color ??= const Color.fromRGBO(96, 173, 249, 1);

  const Color backgroundColor = Color.fromRGBO(247, 248, 250, 1.0);

  final bool isMobile = defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.android;

  return ThemeData(
    platform: TargetPlatform.iOS,
    primaryColor: color,
    scaffoldBackgroundColor: backgroundColor,
    splashFactory: NoSplash.splashFactory,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.white,
      toolbarHeight: isMobile ? 45.r : 30.r,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      actionsIconTheme: const IconThemeData(
        color: Colors.black,
      ),
      shape: Border(
        bottom: BorderSide(color: backgroundColor, width: isMobile ? 1.r : 5.r),
      ),
    ),
    iconTheme: IconThemeData(size: 18.r),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      elevation: 0,
      selectedItemColor: color,
      selectedLabelStyle: textStyle,
      unselectedLabelStyle: textStyle,
    ),
    cardTheme: CardTheme(
      margin: EdgeInsets.zero,
      elevation: 0,
      shadowColor: Colors.transparent,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(5.r),
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      // surface: Colors.grey.shade50,
      // surfaceTint: Colors.white,
      // onSurfaceVariant: color,
      seedColor: color,
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        disabledForegroundColor: Colors.grey,
        backgroundColor: color,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(
          horizontal: 15.r,
        ),
        textStyle: textStyle,
        minimumSize: Size(24.r, 24.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: color,
        disabledBackgroundColor: Colors.grey.shade100,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(
          horizontal: 15.r,
        ),
        textStyle: textStyle,
        minimumSize: Size(24.r, 24.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: EdgeInsets.symmetric(
          horizontal: 15.r,
        ),
        textStyle: textStyle,
        minimumSize: Size(24.r, 24.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.r),
        ),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size(24.r, 24.r),
        foregroundColor: color,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(
          horizontal: 5.r,
        ),
        textStyle: textStyle,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size(22.r, 24.r),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: textStyle,
      displayMedium: textStyle,
      displaySmall: textStyle,
      headlineLarge: textStyle,
      headlineMedium: textStyle,
      headlineSmall: textStyle,
      titleLarge: textStyle,
      titleMedium: textStyle,
      titleSmall: textStyle,
      bodyLarge: textStyle,
      bodyMedium: textStyle,
      bodySmall: textStyle,
      labelLarge: textStyle,
      labelMedium: textStyle,
      labelSmall: textStyle,
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      actionsPadding: EdgeInsets.all(10.r),
      titleTextStyle: TextStyle(
        fontSize: 10.r,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    ),
    useMaterial3: true,
  );
}
