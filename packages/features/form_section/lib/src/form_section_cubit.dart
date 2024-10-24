import 'package:domain_models/domain_models.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_fields/form_fields.dart';
import 'package:user_repository/user_repository.dart';

part 'form_section_state.dart';

class FormSectionCubit extends Cubit<FormSectionState> {
  FormSectionCubit({
    required this.userRepository,
    required this.imageDownloadUrl,
    required this.formId,
  }) : super(const FormSectionState()) {
    fetchFormSection();
  }

  final UserRepository userRepository;
  final String imageDownloadUrl;
  final int formId;

  void fetchFormSection() async {
    final loading = state.copyWith(
        formSectionFetchingStatus: FormSectionFetchingStatus.loading);
    emit(loading);
    try {
      final formSections = await userRepository.getFormSections(formId);
      final formSection = formSections.list.first;
      final questions = formSection.questions.map((question) {
        return FormQuestion.unvalidated(question);
      }).toList();
      final success = state.copyWith(
        formSection: formSection,
        questions: questions,
        formSectionFetchingStatus: FormSectionFetchingStatus.success,
      );
      emit(success);
    } catch (e) {
      final error = state.copyWith(
          formSectionFetchingStatus: FormSectionFetchingStatus.error);
      emit(error);
    }
// @override
// Future<void> close() {
//   requestRepository.changeNotifier.clearRequest();
//   return super.close();
// }
  }

  void onQuestionChanged(Question question) {
    final prevQuestions = state.questions;
    final questions = prevQuestions.map((prevQuestion) {
      if (prevQuestion.value?.id == question.id) {
        return FormQuestion.validated(question);
      }
      return prevQuestion;
    }).toList();
    final newState = state.copyWith(questions: questions);
    emit(newState);
  }

  void onSubmit() async {
    final questions = state.questions.map((question) {
      return FormQuestion.validated(question.value);
    }).toList();

    final isFormValid = Formz.validate([
      ...questions,
    ]);

    final newState = state.copyWith(
      questions: questions,
      submissionStatus: isFormValid
          ? FormzSubmissionStatus.inProgress
          : FormzSubmissionStatus.initial,
    );

    emit(newState);

    if (isFormValid) {
      final answers = questions.map((question) {
        final answer = question.value?.answer;
        if (answer is List) {
          answer.removeWhere((element) => element == null);
        }
        final answerMap = {
          'question_id': question.value!.id,
          'answer': answer,
          'another_answer': question.value?.otherAnswer,
        };
        return answerMap;
      }).toList();

      try {
        await userRepository.saveFormAnswers(
          answers: answers,
        );

        final newState = state.copyWith(
          questions: questions,
          submissionStatus: FormzSubmissionStatus.success,
        );
        emit(newState);
      } catch (error) {
        final newState = state.copyWith(
          submissionStatus: FormzSubmissionStatus.failure,
        );
        emit(newState);
      }
    }
  }
}
