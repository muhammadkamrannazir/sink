import 'package:flutter/material.dart';

class ClickableArrow extends StatelessWidget {
  final void Function()? onTap;
  final bool right;
  final bool enableFeedback;
  final int? size;

  ClickableArrow({
    required this.onTap,
    required this.right,
    this.enableFeedback= false,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      enableFeedback: enableFeedback ,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Icon(
          right ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left,
          size: 24,
        ),
      ),
      onTap: onTap,
    );
  }
}

class TransparentArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.transparent,
        size: 24,
      ),
    );
  }
}
