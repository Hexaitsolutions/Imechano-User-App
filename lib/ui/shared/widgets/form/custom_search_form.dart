import 'package:flutter/material.dart';
import 'package:imechano/ui/styling/colors.dart';

class CustomSearchForm extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool readOnly;
  const CustomSearchForm({
    Key? key,
    this.hintText = '',
    this.icon = Icons.visibility,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: EdgeInsets.only(right: 5, left: 5),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(
          Radius.circular(80),
        ),
      ),
      child: TextFormField(
        readOnly: readOnly,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: transparent),
            borderRadius: BorderRadius.all(
              Radius.circular(80),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: transparent),
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: transparent),
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
          hintText: hintText,
          hintStyle: TextStyle(fontFamily: 'Poppins3', fontSize: 9),
        ),
      ),
    );
  }
}
