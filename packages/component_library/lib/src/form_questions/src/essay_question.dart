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

    return Container(
      padding: const EdgeInsets.all(Spacing.mediumLarge),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.borderColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.text + (question.isRequired ? '*' : ''),
            style: textTheme.labelMedium,
          ),
          Text(
            question.description,
            style: textTheme.bodySmall?.copyWith(
              color: theme.questionDescriptionColor,
            ),
          ),
          VerticalGap.medium(),
          TextFormField(
            maxLines: question.type == QuestionType.longEssay ? 4 : null,
            onChanged: onChanged,
            decoration: InputDecoration(
              isDense: true,
              hintText: 'l10n.essayQuestionTextFieldLabel',
              errorText: error == DynamicValidationError.empty
                  ? 'l10n.requiredFieldErrorMessage'
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}
