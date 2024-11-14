import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTag extends StatelessWidget {
  final String title;
  CustomTag({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
          fontSize: 13.sp,
          fontFamily: 'Poppins3',
        ));
  }
}
