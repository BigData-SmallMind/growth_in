import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';

class DateRangeQuestion extends StatefulWidget {
  const DateRangeQuestion({
    super.key,
    required this.onChanged,
    required this.question,
    this.error,
  });

  final ValueChanged<Map<String, dynamic>> onChanged;
  final Question question;
  final FormQuestionValidationError? error;

  @override
  State<DateRangeQuestion> createState() => _DateRangeQuestionState();
}

class _DateRangeQuestionState extends State<DateRangeQuestion> {
  Question? updatedQuestion;

  @override
  void initState() {
    updatedQuestion = widget.question;
    super.initState();
  }

  void updateQuestion(Map<String, dynamic> answer) {
    updatedQuestion = widget.question.copyWith(answer: answer);
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
    final from = await showDatePicker(
      context: context,
      initialDate: updatedQuestion?.answer != null
          ? DateTime.parse(
              updatedQuestion!.answer!['from'].replaceAll('/', '-'),
            )
          : DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: updatedQuestion?.answer?['to'] != null
          ? DateTime.parse(updatedQuestion!.answer!['to'].replaceAll('/', '-'))
          : DateTime(2100),
    );

    if (from == null) return;
    final isFromLaterThanTo = updatedQuestion?.answer?['to'] != null &&
        DateTime.parse(updatedQuestion!.answer!['to'].replaceAll('/', '-'))
            .isBefore(from);
    final updatedMap = {
      'from': from.toIso8601String().split('T').first,
      'to': isFromLaterThanTo
          ? from.toIso8601String().split('T').first
          : updatedQuestion?.answer?['to'],
    };
    updateQuestion(
      updatedMap,
    );
  }

  void pickTo() async {
    final to = await showDatePicker(
      context: context,
      initialDate: updatedQuestion?.answer['to'] != null
          ? DateTime.parse(
              updatedQuestion!.answer!['to'].replaceAll('/', '-'),
            )
          : DateTime.now(),
      firstDate: updatedQuestion?.answer['from'] != null
          ? DateTime.parse(
              updatedQuestion!.answer!['from'].replaceAll('/', '-'))
          : DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (to == null) return;
    final updatedMap = {
      'from': updatedQuestion?.answer?['from'],
      'to': to.toIso8601String().split('T').first,
    };
    updateQuestion(updatedMap);
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
                          text:
                              updatedQuestion?.answer?['from'].replaceAll('/', '-'),
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
                          text:
                              updatedQuestion?.answer?['to']?.replaceAll('/', '-'),
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
