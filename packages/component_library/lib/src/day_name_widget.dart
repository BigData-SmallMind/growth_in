import 'package:intl/intl.dart';

import 'package:flutter/material.dart';




class DayNameWidget extends StatelessWidget {
  const DayNameWidget({
    super.key,
    required this.dateTime,
  });

  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          DateFormat('EEEE').format(dateTime),
          style: textTheme.titleMedium,
        ),
        Text(dateTime.day.toString(), style: textTheme.titleMedium),
      ],
    );
  }
}

