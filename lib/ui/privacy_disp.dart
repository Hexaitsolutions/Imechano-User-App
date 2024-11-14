import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:imechano/localization/language_constrants.dart';
import 'package:imechano/ui/shared/widgets/appbar/custom_appbar_widget.dart';

class PolicyScreen extends StatelessWidget {
  final String mdFileName;

  PolicyScreen({required this.mdFileName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBar(
        title: getTranslated('privacy_policy', context),
        //menuItem: 'assets/svg/Menu.svg',
        imageicon: 'assets/svg/Arrow_alt_left.svg',
        home: 'assets/svg/homeicon.svg',
        action2: 'assets/svg/ball.svg',
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 150)).then((value) {
          return rootBundle
              .loadString(getTranslated("term_privacy_lang", context));
          //    ('assets/$mdFileName')
        }),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Markdown(
              data: snapshot.data.toString(),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
