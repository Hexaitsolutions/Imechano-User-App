import 'package:flutter/material.dart';

class SwipeScroll extends StatefulWidget {
  @override
  _SwipeScrollState createState() => _SwipeScrollState();
}

class _SwipeScrollState extends State<SwipeScroll> {
  ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          print(details.delta.dy);
          if (details.delta.dy > 0) {
            // swipe down
            _controller.animateTo(_controller.offset + 50,
                duration: Duration(milliseconds: 300), curve: Curves.linear);
          } else if (details.delta.dy < 0) {
            // swipe up
            _controller.animateTo(_controller.offset - 50,
                duration: Duration(milliseconds: 300), curve: Curves.linear);
          }
        },
        child: ListView.builder(
          controller: _controller,
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Item $index'),
            );
          },
        ),
      ),
    );
  }
}
