import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';

class SliderQuestion extends StatefulWidget {
  const SliderQuestion({
    super.key,
    required this.onChanged,
    required this.question,
    this.error,
  });

  final ValueChanged<int> onChanged;
  final Question question;
  final FormQuestionValidationError? error;

  @override
  State<SliderQuestion> createState() => _SliderQuestionState();
}

class _SliderQuestionState extends State<SliderQuestion> {
  Question? updatedQuestion;

  @override
  void initState() {
    updatedQuestion = widget.question;
    super.initState();
  }

  void updateQuestion(int answer) {
    updatedQuestion = widget.question.copyWithAnswer(answer: answer);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final sliderMinimum = widget.question.sliderMin;
    final sliderMaximum = widget.question.sliderMax;
    final currentValue = (updatedQuestion?.answer != null &&
            updatedQuestion?.answer?.toDouble() <= sliderMaximum &&
            updatedQuestion?.answer?.toDouble() >= sliderMinimum)
        ? updatedQuestion?.answer.toDouble()
        : sliderMinimum?.toDouble();
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
              Slider(
                activeColor: theme.secondaryColor,
                secondaryActiveColor: theme.borderColor,
                secondaryTrackValue: sliderMaximum!.toDouble(),
                min: sliderMinimum!.toDouble(),
                max: sliderMaximum.toDouble(),
                divisions: (sliderMaximum - sliderMinimum > 0)
                    ? sliderMaximum - sliderMinimum
                    : null,
                label: currentValue.toString(),
                value: currentValue,
                onChanged: (value) {
                  widget.onChanged(value.toInt());
                  updateQuestion(value.toInt());
                },
              ),
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
