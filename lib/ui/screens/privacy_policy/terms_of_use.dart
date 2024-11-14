import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/screens/privacy_policy/policy_dailogue.dart';
import 'package:imechano/ui/styling/colors.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: "${getTranslated("term_condition_message", context)} \n ",
          style: Theme.of(context).textTheme.bodyText1,
          children: [
            TextSpan(
              text: getTranslated("terms_and_condition", context),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: buttonBlue3b5999),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showModal(
                    context: context,
                    configuration: FadeScaleTransitionConfiguration(),
                    builder: (context) {
                      return PolicyDialog(
                        // mdFileName: 'toc.md',
                        mdFileName: getTranslated('toc_file', context),
                      );
                    },
                  );
                },
            ),
            TextSpan(text: "  ${getTranslated("and", context)}  "),
            TextSpan(
              text: "${getTranslated("privacy_policy", context)}!",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: buttonBlue3b5999),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return PolicyDialog(
                        // mdFileName: 'privacy.md',
                        mdFileName:
                            getTranslated('privacy_policy_file', context),
                      );
                    },
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
