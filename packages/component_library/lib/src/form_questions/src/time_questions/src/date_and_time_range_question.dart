import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';

class DateAndTimeRangeQuestion extends StatefulWidget {
  const DateAndTimeRangeQuestion({
    super.key,
    required this.onChanged,
    required this.question,
    this.error,
  });

  final ValueChanged<Map<String, dynamic>> onChanged;
  final Question question;
  final FormQuestionValidationError? error;

  @override
  State<DateAndTimeRangeQuestion> createState() =>
      _DateAndTimeRangeQuestionState();
}

class _DateAndTimeRangeQuestionState extends State<DateAndTimeRangeQuestion> {
  Question? updatedQuestion;

  @override
  void initState() {
    updatedQuestion = widget.question;
    super.initState();
  }

  void updateQuestion(Map<String, dynamic> answer) {
    updatedQuestion = widget.question.copyWithAnswer(answer: answer);
    setState(() {});
    if (answer['from'] != null && answer['to'] != null) {
      final updatedMap = {
        'from': answer['from'].replaceAll('-', '/'),
        'to': answer['to'].replaceAll('-', '/'),
      };
      widget.onChanged(updatedMap);
    }
  }

  void pickFrom() async {
    // Date Picker
    final date = await showDatePicker(
      context: context,
      initialDate: updatedQuestion?.answer != null
          ? DateTime.parse(updatedQuestion!.answer!['from']
              .split(' ')[0]
              .replaceAll('/', '-'))
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: updatedQuestion?.answer?['to'] != null
          ? DateTime.parse(
              updatedQuestion!.answer!['to'].split(' ')[0].replaceAll('/', '-'))
          : DateTime(2100),
    );

    if (date == null) return;

    // Time Picker
    if (!mounted) return;
    final time = await showTimePicker(
      context: context,
      initialTime: updatedQuestion?.answer?['from'] != null
          ? TimeOfDay(
              hour: int.parse(
                  updatedQuestion!.answer!['from'].split(' ')[1].split(':')[0]),
              minute: int.parse(
                  updatedQuestion!.answer!['from'].split(' ')[1].split(':')[1]),
            )
          : TimeOfDay.now(),
    );

    if (time == null) return;

    final from =
        '${date.toIso8601String().split('T').first} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    final to = updatedQuestion?.answer?['to'] == null
        ? null
        : '${updatedQuestion?.answer?['to'].toIso8601String().split('T').first} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    final isFromLaterThanTo =
        to == null ? false : DateTime.parse(to).isBefore(DateTime.parse(from));
    final updatedMap = {
      'from': from,
      'to': isFromLaterThanTo ? from : updatedQuestion?.answer?['to'],
    };
    updateQuestion(updatedMap);
  }

  void pickTo() async {
    // Date Picker
    final date = await showDatePicker(
      context: context,
      initialDate: updatedQuestion?.answer['to'] != null
          ? DateTime.parse(updatedQuestion!.answer!['to']!
              .split(' ')[0]
              ?.replaceAll('/', '-'))
          : DateTime.now(),
      firstDate: updatedQuestion?.answer['from'] != null
          ? DateTime.parse(updatedQuestion!.answer!['from']
              .split(' ')[0]
              .replaceAll('/', '-'))
          : DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (date == null || !mounted) return;

    // Time Picker
    final time = await showTimePicker(
      context: context,
      initialTime: updatedQuestion?.answer['to'] != null
          ? TimeOfDay(
              hour: int.parse(
                  updatedQuestion!.answer!['to'].split(' ')[1].split(':')[0]),
              minute: int.parse(
                  updatedQuestion!.answer!['to'].split(' ')[1].split(':')[1]),
            )
          : TimeOfDay.now(),
    );

    if (time == null) return;
    final isEarlierThanFrom = updatedQuestion?.answer?['from'] != null &&
        DateTime.parse(updatedQuestion!.answer!['from']
                .split(' ')[0]
                .replaceAll('/', '-'))
            .isAfter(DateTime.parse(
                '${date.toIso8601String().split('T').first} ${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'));
    final updatedMap = {
      // 'from': updatedQuestion?.answer?['from'],
      'from': isEarlierThanFrom
          ? '${date.toIso8601String().split('T').first} '
              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}'
          : updatedQuestion?.answer?['from'],
      'to': '${date.toIso8601String().split('T').first} '
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
    };
    updateQuestion(updatedMap);
  }

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final l10n = ComponentLibraryLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(Spacing.mediumLarge),
          decoration: BoxDecoration(
            border: Border.all(
              color: widget.error == FormQuestionValidationError.empty
                  ? theme.errorColor
                  : theme.borderColor,
            ),
            borderRadius: BorderRadius.circular(theme.textFieldBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.question.text + (widget.question.isRequired ? ' *' : ''),
                style: textTheme.labelMedium,
              ),
              VerticalGap.small(),
              Text(
                widget.question.description,
                style: textTheme.bodySmall?.copyWith(
                  color: theme.questionDescriptionColor,
                ),
              ),
              VerticalGap.medium(),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: pickFrom,
                      child: TextField(
                        style: textTheme.bodyMedium?.copyWith(
                            color: theme.materialThemeData.disabledColor),
                        enabled: false,
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        controller: TextEditingController(
                          text: updatedQuestion?.answer?['from']
                              .replaceAll('/', '-'),
                        ),
                      ),
                    ),
                  ),
                  HorizontalGap.medium(),
                  Expanded(
                    child: GestureDetector(
                      onTap: pickTo,
                      child: TextField(
                        style: textTheme.bodyMedium?.copyWith(
                            color: theme.materialThemeData.disabledColor),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        enabled: false,
                        controller: TextEditingController(
                          text: updatedQuestion?.answer?['to']
                              ?.replaceAll('/', '-'),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        if (widget.error != null) ...[
          VerticalGap.smallMedium(),
          Padding(
            padding: const EdgeInsets.only(left: Spacing.mediumLarge),
            child: Text(
              l10n.requiredFieldErrorMessage,
              style: textTheme.bodySmall?.copyWith(color: theme.errorColor),
            ),
          ),
        ]
      ],
    );
  }
}
