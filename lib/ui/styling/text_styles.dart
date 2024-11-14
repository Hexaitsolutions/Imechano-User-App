import 'package:flutter/material.dart';

import 'colors.dart';

class TextStyles {
  static const TextStyle bold30 = const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle bold30Black = bold30.copyWith(color: black);
  static final TextStyle bold30White =
      bold30.copyWith(color: white, fontSize: 26, fontFamily: 'Poppins3');

  static const TextStyle regular16 = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle regular20 = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle regular20Black = regular20.copyWith(color: black);
  static final TextStyle regular20White =
      regular20.copyWith(color: white, fontSize: 13, fontFamily: 'OpenSans1');
  static final TextStyle regular16Black = regular16.copyWith(color: black);
  static final TextStyle regular16White = regular16.copyWith(color: white);
  static final TextStyle regular16Red = regular16.copyWith(color: red);
}
