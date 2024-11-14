import 'package:flutter/material.dart';
import 'package:imechano/ui/styling/colors.dart';

class BlankLayout extends StatefulWidget {
  final Widget body;
  final bool includeAppBar;

  const BlankLayout({Key? key, required this.body, this.includeAppBar = false})
      : super(key: key);

  @override
  _BlankLayoutState createState() => _BlankLayoutState();
}

class _BlankLayoutState extends State<BlankLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !widget.includeAppBar
          ? null
          : AppBar(
              toolbarHeight: 0,
              backgroundColor: white,
              elevation: 0,
            ),
      backgroundColor: white,
      body: widget.body,
    );
  }
}