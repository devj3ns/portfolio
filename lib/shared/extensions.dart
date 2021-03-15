import 'package:flutter/material.dart';

import 'shared_widgets.dart';

double _mobileBreakpoint = 0;
double _tabletBreakpoint = 750;
double _desktopBreakpoint = 1220;

extension ContextExtensions on BuildContext {
  // Responsive
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  Size get screenSize => mediaQuery.size;

  double get screenWidth => screenSize.width;

  double get screenHeight => screenSize.height;

  bool get isMobile =>
      screenWidth >= _mobileBreakpoint && screenWidth < _tabletBreakpoint;

  bool get isTablet =>
      screenWidth >= _tabletBreakpoint && screenWidth < _desktopBreakpoint;

  bool get isDesktop => screenWidth >= _desktopBreakpoint;

  double? responsiveNullableNumber({
    double? onMobile,
    double? onTablet,
    double? onDesktop,
  }) {
    return isMobile
        ? onMobile
        : isTablet
            ? onTablet
            : isDesktop
                ? onDesktop
                : null;
  }

  double responsiveNumber({
    required double onMobile,
    required double onTablet,
    required double onDesktop,
  }) {
    return isMobile
        ? onMobile
        : isTablet
            ? onTablet
            : onDesktop;
  }

  EdgeInsets responsiveEdgeInsets({
    required EdgeInsets onMobile,
    required EdgeInsets onTablet,
    required EdgeInsets onDesktop,
  }) {
    return isMobile
        ? onMobile
        : isTablet
            ? onTablet
            : onDesktop;
  }

  Widget responsiveWidget({
    required Widget onMobile,
    required Widget onTablet,
    required Widget onDesktop,
  }) {
    return isMobile
        ? onMobile
        : isTablet
            ? onTablet
            : onDesktop;
  }
}

extension NullableStringExtensions on String? {
  bool get isNotBlank => this != null && this!.trim().isNotEmpty;

  bool get isBlank => !isNotBlank;

  bool get isValidEmail =>
      isNotBlank &&
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(this!);
}

extension WidgetExtensions on Widget {
  Widget floatOnHover() => TranslateOnHover(child: this);
}
