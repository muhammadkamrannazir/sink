import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiver/strings.dart';

class ClearableNumberInput extends StatefulWidget {
  final ValueChanged<double?> onChange;
  final double? value;
  final String hintText;
  final TextStyle? style;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;

  ClearableNumberInput({
    required this.onChange,
    this.value,
    required this.hintText,
    this.style,
    this.contentPadding,
    this.border,
  });

  @override
  State<StatefulWidget> createState() => _ClearableNumberInputState();
}

class _ClearableNumberInputState extends State<ClearableNumberInput> {
  final _focus = FocusNode();
  late TextEditingController _controller;

  bool focused = false;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.value?.toString() ?? '');
    _controller.addListener(() => handleChange());
    _focus.addListener(() => focused = !focused);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  void handleChange() {
    var number = _controller.text;
    widget.onChange(isBlank(number) ? null : double.tryParse(number));
  }

  bool isClearable() {
    return !isBlank(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*'))],
      style: widget.style,
      focusNode: _focus,
      decoration: InputDecoration(
        contentPadding: widget.contentPadding ?? EdgeInsets.all(16.0),
        hintText: widget.hintText,
        border: widget.border ?? InputBorder.none,
        isDense: true,
        suffixIcon: focused
            ? IconButton(
                icon: Icon(Icons.clear),
                onPressed: isClearable() ? () => _controller.clear() : null,
              )
            : null,
      ),
    );
  }
}
