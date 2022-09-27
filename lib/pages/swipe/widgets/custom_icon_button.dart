import 'package:flutter/material.dart';
import 'package:sitter_swipe/resources/colors.dart';

class CustomIconButton extends StatefulWidget {
  final Function onTap;
  final Icon icon;
  final EdgeInsets padding;
  const CustomIconButton(this.onTap, this.icon, this.padding, {Key? key})
      : super(key: key);

  @override
  _CustomIconButtonState createState() => _CustomIconButtonState();
}

class _CustomIconButtonState extends State<CustomIconButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.padding,
      decoration: BoxDecoration(
          color: TanPallete.tan, borderRadius: BorderRadius.circular(20.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          print("touched");
          widget.onTap();
        },
        child: Center(
          child: widget.icon,
        ),
      ),
    );
  }
}
