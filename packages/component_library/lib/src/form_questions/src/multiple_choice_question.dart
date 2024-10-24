import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';

class MultipleChoiceQuestion extends StatefulWidget {
  const MultipleChoiceQuestion({
    super.key,
    required this.onChanged,
    required this.onOtherAnswerChanged,
    required this.question,
    required this.imageUrl,
    this.error,
  });

  final ValueChanged<dynamic> onChanged;
  final ValueChanged<String?> onOtherAnswerChanged;
  final Question question;
  final FormQuestionValidationError? error;
  final String? imageUrl;

  @override
  State<MultipleChoiceQuestion> createState() => _MultipleChoiceQuestionState();
}

class _MultipleChoiceQuestionState extends State<MultipleChoiceQuestion> {
  Question? updatedQuestion;
  bool isOtherAnswerChecked = false;
  final otherController = TextEditingController();

  @override
  void initState() {
    updatedQuestion = widget.question;
    super.initState();
  }

  void updateQuestion(dynamic answer) {
    if (widget.question.allowMultipleAnswers) {
      // final answersList = updatedQuestion?.answer as List? ?? [];
      final answersList = updatedQuestion?.answer is String?
          ? [updatedQuestion?.answer]
          : updatedQuestion?.answer as List? ?? [];
      if (answersList.contains(answer)) {
        answersList.remove(answer);
      } else {
        answersList.add(answer);
      }
      updatedQuestion = widget.question.copyWithAnswer(answer: answersList);
    } else {
      updatedQuestion = widget.question.copyWithAnswer(answer: answer);
    }
    setState(() {});
    widget.onChanged(updatedQuestion?.answer);
  }

  void updatedAnotherAnswer(String? anotherAnswer) {
    updatedQuestion = updatedQuestion?.copyWithAnotherAnswer(
      anotherAnswer: anotherAnswer,
    );
    setState(() {});
    widget.onOtherAnswerChanged(anotherAnswer);
  }

  @override
  Widget build(BuildContext context) {
    final theme = GrowthInTheme.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isDropdown = widget.question.type == QuestionType.dropdown;
    final allowMultipleAnswers = widget.question.allowMultipleAnswers;
    final isMultipleImageChoice =
        widget.question.type == QuestionType.multipleImageChoice;
    final l10n = ComponentLibraryLocalizations.of(context);
    final isRadio = !allowMultipleAnswers && !isDropdown;
    final isCheckBox = allowMultipleAnswers && !isDropdown;
    final allowOther = widget.question.allowAnotherAnswer;

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
              if (isRadio)
                ...widget.question.choices!.map(
                  (option) {
                    return RadioListTile(
                      title: isMultipleImageChoice
                          ? Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Image.network(
                                '${widget.imageUrl}/$option',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Text(option),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      value: option,
                      groupValue: updatedQuestion?.answer,
                      onChanged: (_) {
                        updateQuestion(option);
                        updatedAnotherAnswer(null);
                        isOtherAnswerChecked = false;
                        otherController.clear();
                      },
                    );
                  },
                ),
              if (isCheckBox)
                ...widget.question.choices!.map(
                  (option) {
                    return CheckboxListTile(
                      checkboxShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3),
                        side: BorderSide(
                          color: theme.borderColor,
                          width: 1,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      title: isMultipleImageChoice
                          ? Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Image.network(
                                '${widget.imageUrl}/$option',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Text(option),
                      value: updatedQuestion?.answer is List?
                          ? (updatedQuestion?.answer)?.any(
                                (element) => element == option,
                              ) ??
                              false
                          : option == updatedQuestion?.answer,
                      onChanged: (_) {
                        updateQuestion(option);
                      },
                    );
                  },
                ),
              if (isDropdown)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: theme.materialThemeData.colorScheme.surface,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: updatedQuestion?.answer as String?,
                    onChanged: (String? value) {
                      widget.onChanged(value!);
                      updateQuestion(value);
                    },
                    items: widget.question.choices!.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              if (allowOther)
                CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  title: const Text('l10n.otherAnswerTileTitle'),
                  value: isOtherAnswerChecked,
                  onChanged: (_) {
                    isOtherAnswerChecked = !isOtherAnswerChecked;
                    if (!isOtherAnswerChecked) {
                      otherController.clear();
                      updatedAnotherAnswer(null);
                    }
                    if(isOtherAnswerChecked) {
                      updateQuestion(null);
                    }
                    setState(() {});
                  },
                ),
              if (isOtherAnswerChecked)
                TextField(
                  controller: otherController,
                  onChanged: (value) {
                    otherController.text = value;
                    updatedAnotherAnswer(value.isEmpty ? null : value);
                  },
                  decoration: InputDecoration(
                    hintText: 'l10n.otherAnswerHintText',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
