import 'package:flutter/material.dart';
import 'package:sink/theme/palette.dart' as Palette;

class RoundedButton extends StatelessWidget {
  final Function? onPressed;
  final String text;
  final BorderRadius radius;
  final Color buttonColor;

  RoundedButton({
    required this.onPressed,
    required this.text,
    BorderRadius? radius,
    Color? buttonColor,
  })  : this.radius = radius ?? BorderRadius.circular(5.0),
        this.buttonColor = buttonColor ?? Colors.lightGreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: radius),
          primary: buttonColor,
          onPrimary: Colors.white,
          // disabledColor: Colors.grey,
        ),
        onPressed: onPressed != null ? () => onPressed!() : null,
        child: Text(text),
      ),
    );
  }
}

class LoadingButton extends StatelessWidget {
  final BorderRadius radius;
  final Color buttonColor;

  LoadingButton({BorderRadius? radius, Color? buttonColor})
      : this.radius = radius ?? BorderRadius.circular(5.0),
        this.buttonColor = buttonColor ?? Colors.lightGreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: radius), backgroundColor: buttonColor,
          // disabledColor: Palette.disabled,
        ),
        onPressed: null,
        child: SizedBox(
          width: 16.0,
          height: 16.0,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }
}
