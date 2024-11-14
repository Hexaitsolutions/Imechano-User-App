import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../localization/language_constrants.dart';
import '../../../provider/theme_provider.dart';
import '../../../styling/colors.dart';
import 'custom_tag.dart';

class PaymentMethod extends StatelessWidget {
  PaymentMethod({Key? key}) : super(key: key);
  double hh = 0;
  double ww = 0;

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context);
    final appModelTheme = appModel;
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          CustomTag(title: 'Payment Method'),
          Row(children: [
            Icon(Icons.add, size: 15, color: red),
            SizedBox(width: 5),
            Text('Add card',
                style: TextStyle(
                  fontSize: 13,
                  color: red,
                  fontFamily: 'Poppins1',
                ))
          ])
        ]),
        Container(
          // padding: EdgeInsets.all(5),
          // width: 30,
          padding: EdgeInsets.only(left: 15.h, top: 15.h, bottom: 15.h),
          margin: EdgeInsets.only(left: ww * 0.07, right: ww * 0.05),
          decoration: BoxDecoration(
            color: appModelTheme.darkTheme ? darkmodeColor : Color(0xffE6E6E5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 20,
              ),
              SizedBox(width: 5),
              Text(
                getTranslated('additionallocationcomment', context),
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins3',
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
