import 'package:flutter/material.dart';

class DateAndTimeWidget extends StatelessWidget {
  const DateAndTimeWidget({
    super.key,
    required this.date,
    this.dateOnly = false,
    this.textColor,
  });

  final DateTime date;
  final bool dateOnly;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      dateOnly
          ? '${date.day}/${date.month}/${date.year}'
          : '${date.day}/${date.month}/${date.year} - ${date.hour}:${date.minute}',
      style: textTheme.bodySmall?.copyWith(
        color: textColor ?? const Color(0xFF797979),
      ),
    );
  }
}
