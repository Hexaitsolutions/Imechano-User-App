import 'package:flutter/material.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../styling/colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    final appModelTheme = appModel;
    return Divider(
      thickness: 10,
      color: appModelTheme.darkTheme ? darkmodeColor : apptransbackcolor,
    );
  }
}
