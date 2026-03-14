import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:fluent_ui/fluent_ui.dart';

class RowLogReg extends fluent.StatelessWidget {
  const RowLogReg({super.key, required this.textButton});
  final String textButton;

  @override
  fluent.Widget build(fluent.BuildContext context) {
    return fluent.Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton(
          onPressed: () {},
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.green),
          ),
          child: Text(
            textButton,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
