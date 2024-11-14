import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget {
  final String imageUrl;

  ImageDialog({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding:
          EdgeInsets.only(top: size.height * 0.05, bottom: size.height * 0.02),
      child: InteractiveViewer(
        child: Image.network(
          imageUrl,
          width: size.width * 0.9,
          //  width: 300,
          //  height: 300,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
