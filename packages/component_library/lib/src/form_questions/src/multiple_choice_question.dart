import 'package:component_library/component_library.dart';
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:form_fields/form_fields.dart';

class MultipleChoiceQuestion extends StatefulWidget {
  const MultipleChoiceQuestion({
    super.key,
    required this.onChanged,
    required this.question,
    required this.imageUrl,
    this.error,
  });

  final ValueChanged<dynamic> onChanged;
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
    final isAnswerString = widget.question.answer is String;
    final answer = isAnswerString
        ? [widget.question.answer]
        : widget.question.answer as List? ?? [];
    final choices = widget.question.choices ?? [];
    final choicesInAnswerButNotInChoices = answer
        .where((element) => !choices.contains(element))
        .map((e) => e.toString())
        .toList();
    final allChoices = [
      ...choices,
      ...choicesInAnswerButNotInChoices,
    ];
    updatedQuestion = widget.question.copyWith(
      answer: answer,
      choices: allChoices,
    );
    setState(() {});
    super.initState();
  }

  void chooseAnswer(dynamic answer) {
    final answersList = updatedQuestion?.answer as List? ?? [];
    if (answersList.contains(answer)) {
      answersList.remove(answer);
    } else {
      if (answer != null) answersList.add(answer);
    }
    final shouldAllowMultipleAnswers = widget.question.allowMultipleAnswers;
    updatedQuestion = updatedQuestion?.copyWith(
        answer: shouldAllowMultipleAnswers ? answersList : [answer]);
    setState(() {});
    widget.onChanged(updatedQuestion?.answer);
  }

  void updateOtherAnswer(String answer) {
    final answersList = updatedQuestion?.answer as List? ?? [];
    final choicesLength = updatedQuestion?.choices?.length ?? 0;
    // answersListWithOther is a list of answers that includes the other answer
    final answersListWithOther = [
      ...answersList,
      answer,
    ];
    if (answersListWithOther.length > choicesLength) {
      answersListWithOther.removeAt(choicesLength - 1);
    }

    final multipleAnswersAllowed = widget.question.allowMultipleAnswers;

    updatedQuestion = updatedQuestion?.copyWith(
        answer: multipleAnswersAllowed
            ? answersListWithOther
            : [if (answer.isNotEmpty) answer]);
    setState(() {});
    widget.onChanged(updatedQuestion?.answer);
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
                ...updatedQuestion!.choices!.map(
                  (choice) {
                    return RadioListTile(
                      title: isMultipleImageChoice
                          ? Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Image.network(
                                '${widget.imageUrl}/$choice',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Text(choice),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                      value: choice,
                      groupValue: updatedQuestion?.answer.isNotEmpty
                          ? updatedQuestion?.answer.first
                          : false,
                      onChanged: (_) {
                        chooseAnswer(choice);
                        isOtherAnswerChecked = false;
                        otherController.clear();
                      },
                    );
                  },
                ),
              if (isCheckBox)
                ...updatedQuestion!.choices!.map(
                  (choice) {
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
                                '${widget.imageUrl}/$choice',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Text(choice),
                      value: (updatedQuestion?.answer)?.any(
                            (element) => element == choice,
                          ) ??
                          false,
                      onChanged: (_) {
                        chooseAnswer(choice);
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
                    value: (updatedQuestion?.answer as List? ?? []).isNotEmpty
                        ? updatedQuestion?.answer.first
                        : null,
                    onChanged: (String? value) {
                      widget.onChanged(value!);
                      chooseAnswer(value);
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
                  title: Text(l10n.otherAnswerTileTitle),
                  value: isOtherAnswerChecked,
                  onChanged: (_) {
                    isOtherAnswerChecked = !isOtherAnswerChecked;
                    otherController.clear();
                    updateOtherAnswer('');
                    setState(() {});
                  },
                ),
              if (isOtherAnswerChecked)
                TextField(
                  controller: otherController,
                  onChanged: (value) {
                    otherController.text = value;
                    updateOtherAnswer(value);
                  },
                  decoration: InputDecoration(
                    hintText: l10n.otherAnswerHintText,
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
