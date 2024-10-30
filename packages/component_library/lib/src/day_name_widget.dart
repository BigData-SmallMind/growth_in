import 'package:intl/intl.dart' as intl;

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
    return SizedBox(
      width: 35,
      child: Column(
        children: [
          Text(
            '${intl.DateFormat('EEEE').format(dateTime).substring(0, 3)}.',
            style: textTheme.titleMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textDirection: TextDirection.ltr,
          ),
          Text(dateTime.day.toString(), style: textTheme.titleMedium),
        ],
      ),
    );
  }
}

