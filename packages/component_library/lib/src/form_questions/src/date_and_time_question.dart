import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';

class DateAndTimeQuestion extends StatefulWidget {
  const DateAndTimeQuestion({
    super.key,
    required this.onChanged,
    required this.question,
    this.error,
  });

  final ValueChanged<String> onChanged;
  final Question question;
  final FormQuestionValidationError? error;

  @override
  State<DateAndTimeQuestion> createState() => _DateAndTimeQuestionState();
}

class _DateAndTimeQuestionState extends State<DateAndTimeQuestion> {
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

  void pickDateAndTime() {
    showDatePicker(
      context: context,
      initialDate: updatedQuestion?.answer != null
          ? DateTime.parse(updatedQuestion!.answer!.replaceAll('/', '-'))
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    ).then(
      (date) => date == null
          ? null
          : showTimePicker(
              context: context,
              initialTime: updatedQuestion?.answer == null
                  ? TimeOfDay.now()
                  : TimeOfDay(
                      hour: int.parse(updatedQuestion?.answer
                          .split(' ')[1]
                          .split(':')
                          .first),
                      minute: int.parse(updatedQuestion?.answer
                          .split(' ')[1]
                          .split(':')
                          .last),
                    ),
            ).then(
              (time) {
                // widget.onChanged(
                //   value.toString(),
                // );
                if (time != null) {
                  updateQuestion(
                    '${date.toIso8601String().split('T').first} '
                    '${time.hour}:${time.minute}',
                  );
                }
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
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
            onTap: pickDateAndTime,
            child: TextField(
              enabled: false,
              textDirection: TextDirection.ltr,
              textAlign: isArabic ? TextAlign.right : TextAlign.left,
              controller: TextEditingController(text: updatedQuestion?.answer),
            ),
          )
        ],
      ),
    );
  }
}
