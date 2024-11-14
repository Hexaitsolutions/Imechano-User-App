// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:imechano/ui/provider/theme_provider.dart';
import 'package:imechano/ui/styling/colors.dart';
import 'package:provider/provider.dart';

class CustomForm extends StatelessWidget {
  final String hintText;
  final String imagePath;
  final bool isSuffix;
  final IconData icon;
  final bool readOnly;
  final bool ObscureText;
  final Color fillColor;
  final TextEditingController controller;
  final dynamic validationform;
  const CustomForm({
    Key? key,
    this.hintText = '',
    required this.imagePath,
    this.isSuffix = false,
    this.icon = Icons.visibility,
    this.readOnly = false,
    this.ObscureText = false,
    required this.controller,
    required this.validationform,
    required this.fillColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    dynamic appModelTheme;
    final appModel = Provider.of<AppModel>(context);
    appModelTheme = appModel;
    return Container(
      child: TextFormField(
        style: TextStyle(
            fontFamily: "Poppins3",
            color: appModelTheme.darkTheme ? white : black),
        validator: validationform,
        readOnly: readOnly,
        controller: controller,
        obscureText: ObscureText,
        decoration: InputDecoration(
            fillColor: fillColor,
            filled: true,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage(imagePath),
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontFamily: 'Poppins3', color: black),
            prefixIconConstraints: BoxConstraints(minWidth: 40),
            suffixIcon: isSuffix
                ? Icon(
                    icon,
                    color: Colors.grey,
                  )
                : null),
      ),
    );
  }
}
