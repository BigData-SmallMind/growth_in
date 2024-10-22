import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';

class DateQuestion extends StatefulWidget {
  const DateQuestion({
    super.key,
    required this.onChanged,
    required this.question,
    this.error,
  });

  final ValueChanged<String> onChanged;
  final Question question;
  final FormQuestionValidationError? error;

  @override
  State<DateQuestion> createState() => _DateQuestionState();
}

class _DateQuestionState extends State<DateQuestion> {
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
            onTap: () => showDatePicker(
              context: context,
              initialDate: updatedQuestion?.answer != null
                  ? DateTime.parse(updatedQuestion!.answer!.replaceAll('/', '-'))
                  : DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            ).then((value) {
              // widget.onChanged(
              //   value.toString(),
              // );
              updateQuestion(value?.toIso8601String().split('T').first);
            }),
            child: TextField(
              enabled: false,
              controller: TextEditingController(text: updatedQuestion?.answer?.replaceAll('/', '-')),
            ),
          )
        ],
      ),
    );
  }
}
