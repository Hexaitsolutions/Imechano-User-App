import 'package:flutter/material.dart';

class LabelListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final double widthFactor;

  const LabelListTile({
    Key? key,
    required this.subtitle,
    required this.title,
    this.widthFactor = 0.4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(
              color: Colors.grey, // Border color
              width: 1.5, // Border width
            ),
            borderRadius: BorderRadius.circular(8.0)),
        width: size.width * widthFactor,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(3, 2, 3, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
              ),
              // SizedBox(
              //   height: size.height * 0.001,
              // ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 0, 12),
                child: Text(subtitle!,
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
              )
            ],
          ),
        ));
  }
}
