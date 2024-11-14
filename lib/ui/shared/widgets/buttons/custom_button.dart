import 'package:flutter/material.dart';
import 'package:imechano/ui/styling/colors.dart';

class CustomButton extends StatelessWidget {
  final Widget title;
  final double width;
  final Color bgColor;
  final Color borderColor;
  final Function callBackFunction;
  final double? height;

  const CustomButton({
    Key? key,
    required this.title,
    required this.width,
    required this.callBackFunction,
    required this.bgColor,
    required this.borderColor,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
        color: bgColor,
      ),
      width: MediaQuery.of(context).size.width * width,
      child: ElevatedButton(
        onPressed: () {
          callBackFunction();
        },
        style: ElevatedButton.styleFrom(
          primary: transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: title,
      ),
    );
  }
}
