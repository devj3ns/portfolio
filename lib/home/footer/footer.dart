import 'package:flutter/material.dart';

import '../../shared/extensions.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textStyle =
        TextStyle(fontSize: 17, color: Colors.blueGrey.withOpacity(0.6));

    return ColoredBox(
      color: Colors.grey.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: context.responsiveNumber(
              onMobile: 5, onTablet: 30, onDesktop: 80),
          children: [
            TextButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '© Jens Becker ${DateTime.now().year}',
                  style: textStyle,
                ),
              ),
              onPressed: () {
                // todo
              },
            ),
            TextButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Impressum',
                  style: textStyle,
                ),
              ),
              onPressed: () {
                // todo
              },
            ),
            TextButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Datenschutz',
                  style: textStyle,
                ),
              ),
              onPressed: () {
                // todo
              },
            ),
            TextButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Lizenzen',
                  style: textStyle,
                ),
              ),
              onPressed: () {
                // todo
              },
            ),
          ],
        ),
      ),
    );
  }
}
