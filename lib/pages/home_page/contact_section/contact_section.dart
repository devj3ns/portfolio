import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_extensions/flutter_extensions.dart';

import '../../../shared/extensions.dart';
import '../../../shared/mailer.dart';
import '../../../shared/shared_widgets.dart';
import '../../../shared/socials_row/socials_row.dart';

class ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final horizontalMargin = context.screenWidth > 1500 ? 80.0 : 0.0;

    return Section(
      title: tr('contact_section_title'),
      subtitle: tr('contact_section_subtitle'),
      bottomMarginMultiplier: 2,
      child: RoundedBox(
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
        withShadow: true,
        child: context.isMobile
            ? Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _Column1(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: _Column2(),
                  ),
                ],
              )
            : IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _Column1(),
                      ),
                    ),
                    Expanded(
                      flex: context.screenWidth < 1000 ? 1 : 2,
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: _Column2(),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _Column1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final titleFontSize =
        context.responsive<double>(onMobile: 20, onTablet: 22, onDesktop: 22);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SelectableText(
              tr('contact_section_first-column_title'),
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            SelectableText(
              tr('contact_section_first-column_subtitle'),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              icon: const FaIcon(
                FontAwesomeIcons.envelope,
                color: Colors.white,
                size: 19,
              ),
              label: const Text(
                'info@jensbecker.dev',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                ),
              ),
              onPressed: () => launch('mailto:info@jensbecker.dev'),
            ).floatOnHover(),
            const SizedBox(height: 10),
            TextButton.icon(
              icon: const FaIcon(
                FontAwesomeIcons.whatsapp,
                color: Colors.white,
                size: 19,
              ),
              label: const Text(
                '0176 23867324',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                  fontSize: 17,
                ),
              ),
              onPressed: () => launch('https://wa.me/+4917623867324'),
            ).floatOnHover(),
            const SizedBox(height: 10),
            SocialsRowWithoutEmail(),
          ],
        ),
      ),
    );
  }
}

class _Column2 extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final telController = useTextEditingController();
    final messageController = useTextEditingController();

    final isSubmitting = useState(false);
    final showSuccessInfo = useState(false);

    void onFormSubmitted() async {
      if (_formKey.currentState!.validate()) {
        isSubmitting.value = true;

        await Mailer().sendEmail(
          customerEmail: emailController.text,
          customerName:
              '${firstNameController.text} ${lastNameController.text}',
          customerTel: telController.text,
          message: messageController.text,
        );

        isSubmitting.value = false;
        showSuccessInfo.value = true;
      }
    }

    return showSuccessInfo.value
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SelectableText(
                tr('contact_section_form_successfully-sent'),
                style: const TextStyle(fontSize: 17),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const FaIcon(
                FontAwesomeIcons.check,
                size: 30,
              ),
            ],
          )
        : Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: firstNameController,
                          decoration: InputDecoration(
                              labelText: tr(
                                  'contact_section_form_first-name_placeholder')),
                          validator: (value) => value.isBlank
                              ? tr('contact_section_form_first-name_validator')
                              : null,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.name,
                          controller: lastNameController,
                          decoration: InputDecoration(
                              labelText: tr(
                                  'contact_section_form_last-name_placeholder')),
                          validator: (value) => value.isBlank
                              ? tr('contact_section_form_last-name_validator')
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                              labelText:
                                  tr('contact_section_form_email_placeholder')),
                          validator: (value) => !value.isValidEmail
                              ? tr('contact_section_form_email_validator')
                              : null,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                          controller: telController,
                          decoration: InputDecoration(
                              labelText:
                                  tr('contact_section_form_phone_placeholder')),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 4,
                    maxLines: null,
                    controller: messageController,
                    decoration: InputDecoration(
                      labelText: tr('contact_section_form_message_placeholder'),
                      alignLabelWithHint: true,
                    ),
                    validator: (value) => value.isBlank
                        ? tr('contact_section_form_message_validator')
                        : null,
                  ),
                ),
                const SizedBox(height: 15),
                isSubmitting.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Button(
                        text: tr('contact_section_form_send-button'),
                        iconData: FontAwesomeIcons.paperPlane,
                        onPressed: onFormSubmitted,
                      ),
              ],
            ),
          );
  }
}
