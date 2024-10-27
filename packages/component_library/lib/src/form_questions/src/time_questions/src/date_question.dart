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

  final ValueChanged<String?> onChanged;
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
    widget.onChanged(answer?.replaceAll('-', '/'));
  }

  void pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: updatedQuestion?.answer != null
          ? DateTime.parse(updatedQuestion!.answer!.replaceAll('/', '-'))
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date == null) return;
    updateQuestion(date.toIso8601String().split('T').first);
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
              GestureDetector(
                onTap: pickDate,
                child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    hintText:
                        '${l10n.dateQuestionTextFieldLabel}${widget.question.isRequired ? ' *' : ''}',
                    prefixIcon: const Icon(Icons.calendar_today),
                  ),
                  enabled: false,
                  controller: TextEditingController(
                    text: updatedQuestion?.answer?.replaceAll('/', '-'),
                  ),
                ),
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
