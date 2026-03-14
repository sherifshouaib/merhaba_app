import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/routing/app_router.dart';

class RowTextButton extends fluent.StatelessWidget {
  const RowTextButton({
    super.key, required this.buttonText,
  });

final String buttonText;
  @override
  fluent.Widget build(fluent.BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            GoRouter.of(context).push(AppRouter.kRegisterView);
          },
          child:  Text(buttonText),
        ),
      ],
    );
  }
}
