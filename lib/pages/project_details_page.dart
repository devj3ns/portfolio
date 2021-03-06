import 'package:beamer/beamer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_extensions/flutter_extensions.dart';

import '../shared/extensions.dart';
import '../shared/shared_widgets.dart';
import 'home_page/projects_section/models/project.dart';

class ProjectDetailPage extends StatelessWidget {
  const ProjectDetailPage(this.project);
  final Project project;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = context.isMobile ? 15.0 : context.screenWidth / 6;
    final verticalPadding = context.isMobile ? 25.0 : 75.0;
    final horizontalImagePadding =
        context.isMobile ? 0.0 : horizontalPadding / 2;
    final locale = context.locale == const Locale('de') ? 'de' : 'en';

    return Scaffold(
      body: Center(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  tooltip: tr('back-tooltip'),
                  onPressed: () {
                    context.canBeamBack
                        ? context.beamBack()
                        : context.beamToNamed('/');
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.chevronLeft,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 5),
                Flexible(
                  child: SelectableText(
                    project.name,
                    style: const TextStyle(fontSize: 25),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            // todo: Translate images (mockups).
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalImagePadding),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      project.mockupUrl,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 4,
                spacing: 4,
                children: project.tags
                    .split(',')
                    .map((tag) => TextChip(text: tag))
                    .toList(),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Wrap(
                alignment: WrapAlignment.center,
                runSpacing: 4,
                spacing: 4,
                children:
                    project.tools.map((tag) => TextChip(text: tag)).toList(),
              ),
            ),
            const SizedBox(height: 30),
            SelectableText(
              project.description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            if (project.playStoreUrl.isNotBlank ||
                project.appStoreUrl.isNotBlank) ...[
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (project.playStoreUrl.isNotBlank)
                    SizedBox(
                      height: context.isMobile ? 40 : 50,
                      child: InkWell(
                        onTap: () => launch(project.playStoreUrl!),
                        child: Image.asset(
                            'assets/images/badges/$locale/play_store_badge.png'),
                      ),
                    ),
                  if (project.appStoreUrl.isNotBlank) ...[
                    const SizedBox(width: 15),
                    SizedBox(
                      height: context.isMobile ? 40 : 50,
                      child: InkWell(
                        onTap: () => launch(project.appStoreUrl!),
                        child: Image.asset(
                            'assets/images/badges/$locale/app_store_badge.png'),
                      ),
                    ),
                  ]
                ],
              )
            ]
          ],
        ),
      ),
    );
  }
}
