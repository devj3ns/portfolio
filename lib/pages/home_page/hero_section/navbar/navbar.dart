import 'package:flutter/material.dart';

import '../../../../shared/extensions.dart';
import '../../home_page.dart';
import 'desktop_navbar.dart';
import 'mobile_navbar.dart';

class NavBar extends StatelessWidget {
  const NavBar(this.scrollToSection);
  final Function(SectionEnum) scrollToSection;

  @override
  Widget build(BuildContext context) {
    final margin = context.responsive<EdgeInsets>(
      onMobile: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      onTablet: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      onDesktop: const EdgeInsets.symmetric(vertical: 30, horizontal: 60),
    );

    return Padding(
      padding: margin,
      child: context.isMobile
          ? MobileNavBar(scrollToSection)
          : DesktopNavBar(scrollToSection),
    );
  }
}
