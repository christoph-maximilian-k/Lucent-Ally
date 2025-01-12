import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Labels.
import '/main.dart';

// Config.
import '/config/app_icons.dart';

// Models.
import '/data/models/licences/licence_item.dart';
import '/data/models/failure.dart';

// Widgets.
import '/widgets/customs/custom_base_page.dart';

class DisplayLicencesSheet extends StatelessWidget {
  final LicenceItem licenceItem;

  const DisplayLicencesSheet({
    super.key,
    required this.licenceItem,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBasePage(
      isModalSheet: true,
      // Page is loading.
      pageIsLoading: false,
      pageHasError: false,
      pageFailure: Failure.initial(),
      pageErrorButtonLabel: '',
      onPageErrorButtonPressed: () => Navigator.of(context).pop(),
      // Common Failure.
      failure: Failure.initial(),
      onDismissFailure: () {},
      // On horizontal pop route.
      onHorizontalPopRoute: () => Navigator.of(context).pop(),
      // Leading icon button.
      leadingIconButtonIcon: AppIcons.back,
      onLeadingIconButtonPressed: () => Navigator.of(context).pop(),
      // Floating action button.
      floatingActionBarDisabled: true,
      // Content.
      content: [
        ListView.builder(
          itemCount: licenceItem.licences.length,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            // Convenience variables.
            final LicenseEntry licenseEntry = licenceItem.licences[index];
            final List<LicenseParagraph> paragraphs = licenseEntry.paragraphs.toList();

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    labels.displayLicencesSheetCurrentLicense(license: index + 1),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 10.0),
                  ...List<Widget>.generate(
                    paragraphs.length,
                    (index) {
                      return Text(
                        paragraphs[index].text,
                        style: Theme.of(context).textTheme.displayMedium,
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
