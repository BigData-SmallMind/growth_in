import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';

class EssayQuestion extends StatelessWidget {
  const EssayQuestion({
    super.key,
    required this.onChanged,
    required this.question,
    this.error,
  });

  final ValueChanged<String> onChanged;
  final Question question;
  final FormQuestionValidationError? error;

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
              color: error == FormQuestionValidationError.empty
                  ? theme.errorColor
                  : theme.borderColor,
            ),
            borderRadius: BorderRadius.circular(theme.textFieldBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question.text + (question.isRequired ? ' *' : ''),
                style: textTheme.labelMedium,
              ),
              VerticalGap.small(),
              Text(
                question.description,
                style: textTheme.bodySmall?.copyWith(
                  color: theme.questionDescriptionColor,
                ),
              ),
              VerticalGap.medium(),
              TextFormField(
                initialValue: question.answer?.toString(),
                maxLines: question.type == QuestionType.longEssay ? 4 : null,
                onChanged: onChanged,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: l10n.essayQuestionTextFieldLabel +
                      (question.isRequired ? ' *' : ''),
                ),
              ),
            ],
          ),
        ),
        if (error != null) ...[
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
