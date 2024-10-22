import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';

class TimeQuestion extends StatefulWidget {
  const TimeQuestion({
    super.key,
    required this.onChanged,
    required this.question,
    this.error,
  });

  final ValueChanged<String> onChanged;
  final Question question;
  final FormQuestionValidationError? error;

  @override
  State<TimeQuestion> createState() => _TimeQuestionState();
}

class _TimeQuestionState extends State<TimeQuestion> {
  Question? updatedQuestion;

  @override
  void initState() {
    updatedQuestion = widget.question;
    super.initState();
  }

  void updateQuestion(String? answer) {
    updatedQuestion = widget.question.copyWith(answer: answer);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Container(
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
          GestureDetector(
            onTap: () => showTimePicker(
              context: context,
              initialTime: updatedQuestion?.answer == null
                  ? TimeOfDay.now()
                  : TimeOfDay(
                      hour: int.parse(updatedQuestion?.answer.split(':').first),
                      minute:
                          int.parse(updatedQuestion?.answer.split(':').last),
                    ),
            ).then((value) {
              // widget.onChanged(
              //   value.toString(),
              // );
              updateQuestion('${value?.hour}:${value?.minute}');
            }),
            child: TextField(
              enabled: false,
              controller: TextEditingController(text: updatedQuestion?.answer),
            ),
          )
        ],
      ),
    );
  }
}
