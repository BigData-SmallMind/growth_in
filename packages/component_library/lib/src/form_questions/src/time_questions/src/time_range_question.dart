import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';

class TimeRangeQuestion extends StatefulWidget {
  const TimeRangeQuestion({
    super.key,
    required this.onChanged,
    required this.question,
    this.error,
  });

  final ValueChanged<Map<String, dynamic>> onChanged;
  final Question question;
  final FormQuestionValidationError? error;

  @override
  State<TimeRangeQuestion> createState() => _TimeRangeQuestionState();
}

class _TimeRangeQuestionState extends State<TimeRangeQuestion> {
  Question? updatedQuestion;

  @override
  void initState() {
    updatedQuestion = widget.question;
    super.initState();
  }

  void updateQuestion(Map<String, dynamic> answer) {
    updatedQuestion = widget.question.copyWithAnswer(answer: answer);
    setState(() {});
    if(answer['from'] != null && answer['to'] != null) {
      widget.onChanged(answer);
    }
  }

  void pickFrom() async {
    final from = await showTimePicker(
      context: context,
      initialTime: updatedQuestion?.answer?['from'] == null
          ? TimeOfDay.now()
          : TimeOfDay(
              hour: int.parse(updatedQuestion?.answer['from'].split(':').first),
              minute:
                  int.parse(updatedQuestion?.answer['from'].split(':').last),
            ),
    );

    if (from == null) return;
    final isLaterThanTo = updatedQuestion?.answer?['to'] == null
        ? false
        : from.hour >
                int.parse(updatedQuestion?.answer?['to'].split(':').first) ||
            from.hour ==
                    int.parse(
                        updatedQuestion?.answer?['to'].split(':').first) &&
                from.minute >
                    int.parse(updatedQuestion?.answer?['to'].split(':').last);
    final updatedMap = {
      'from': '${from.hour}:${from.minute}',
      // 'to': updatedQuestion?.answer?['to'],
      'to': isLaterThanTo
          ? '${from.hour}:${from.minute}'
          : updatedQuestion?.answer?['to'],
    };
    updateQuestion(updatedMap);
  }

  void pickTo() async {
    final to = await showTimePicker(
      context: context,
      initialTime: updatedQuestion?.answer['to'] == null
          ? TimeOfDay.now()
          : TimeOfDay(
              hour: int.parse(updatedQuestion?.answer['to'].split(':').first),
              minute: int.parse(updatedQuestion?.answer['to'].split(':').last),
            ),
    );

    if (to == null) return;
    final isEarlierThanFrom = updatedQuestion?.answer?['from'] != null &&
            to.hour <
                int.parse(updatedQuestion?.answer?['from'].split(':').first) ||
        to.hour ==
                int.parse(updatedQuestion?.answer?['from'].split(':').first) &&
            to.minute <
                int.parse(updatedQuestion?.answer?['from'].split(':').last);
    updateQuestion({
      'from': isEarlierThanFrom
          ? '${to.hour}:${to.minute}'
          : updatedQuestion?.answer?['from'],
      'to': '${to.hour}:${to.minute}',
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final l10n = ComponentLibraryLocalizations.of(context);
    return Column(
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
                        enabled: false,
                        textAlign: TextAlign.center,
                        controller: TextEditingController(
                          text: updatedQuestion?.answer?['from'],
                        ),
                      ),
                    ),
                  ),
                  HorizontalGap.medium(),
                  Expanded(
                    child: GestureDetector(
                      onTap: pickTo,
                      child: TextField(
                        textAlign: TextAlign.center,
                        enabled: false,
                        controller: TextEditingController(
                          text: updatedQuestion?.answer?['to'],
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
