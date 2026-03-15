import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/cupertino.dart';

class CustomInfoLabel extends fluent.StatelessWidget {
  const CustomInfoLabel({
    super.key,
    required this.funcController,
    required this.label,
    required this.placeholder,
    this.obsecure = false,
    this.textInputType = TextInputType.text,
  });

  final fluent.TextEditingController funcController;
  final String label, placeholder;
  final bool obsecure;
  final TextInputType textInputType;
  @override
  fluent.Widget build(fluent.BuildContext context) {
    return fluent.InfoLabel(
      label: label,
      child: fluent.TextBox(
        placeholder: placeholder,
        expands: false,
        controller: funcController,
        obscureText: obsecure,
        keyboardType: textInputType,
      ),
    );
  }
}
