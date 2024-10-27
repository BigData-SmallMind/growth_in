import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class FormsSections {
  FormsSections({
    required this.id,
    required this.list,
    required this.isCompleted,
    required this.formName,
    required this.serviceName,
  });

  final List<FormSection> list;
  final String id;
  final bool isCompleted;
  final String formName;
  final String serviceName;
}

class FormSection {
  FormSection({
    required this.id,
    this.name,
    required this.questions,
  });

  final int id;
  final String? name;
  final List<Question> questions;
}

class Question {
  Question({
    required this.id,
    required this.text,
    this.description = '',
    required this.type,
    required this.allowMultipleAnswers,
    required this.allowAnotherAnswer,
    this.answer,
    this.otherAnswer,
    this.allowDate,
    this.allowTime,
    this.isTimeRange,
    this.choices,
    this.sliderMin,
    this.sliderMax,
    required this.isRequired,
  });

  final int id;
  final String text;
  final String description;
  final QuestionType type;
  final bool allowMultipleAnswers;
  final bool allowAnotherAnswer;

  // could be a string, a list of strings or an entirely different type
  final dynamic answer;
  final String? otherAnswer;
  final bool? allowDate;
  final bool? allowTime;
  final bool? isTimeRange;
  final List<String>? choices;
  final int? sliderMin;
  final int? sliderMax;
  final bool isRequired;

  Question copyWith({
    dynamic answer,
    List<String>? choices,
  }) {
    return Question(
      id: id,
      text: text,
      description: description,
      type: type,
      allowMultipleAnswers: allowMultipleAnswers,
      allowAnotherAnswer: allowAnotherAnswer,
      answer: answer,
      otherAnswer: otherAnswer,
      allowDate: allowDate,
      allowTime: allowTime,
      isTimeRange: isTimeRange,
      choices: choices ?? this.choices,
      sliderMin: sliderMin,
      sliderMax: sliderMax,
      isRequired: isRequired,
    );
  }
}

enum QuestionType {
  essay,
  longEssay,
  slider,
  multipleChoice,
  dropdown,
  fileUpload,
  multipleImageChoice,
  dateType,
  dateOnly,
  timeOnly,
  dateAndTime,
  dateRange,
  timeRange,
  dateAndTimeRange,
  imageAndText;
}

class ImageAndTextAnswer {
  ImageAndTextAnswer({
    this.imageSlug,
    required this.description,
    required this.name,
    this.imageBytes,
    this.file,
  });

  final String? imageSlug;
  final String description;
  final String name;
  final Uint8List? imageBytes;
  final MultipartFile? file;

  ImageAndTextAnswer copyWith({
    String? imageSlug,
    String? description,
    String? name,
    Uint8List? imageBytes,
    MultipartFile? file,
  }) {
    return ImageAndTextAnswer(
      imageSlug: imageSlug ?? this.imageSlug,
      description: description ?? this.description,
      name: name ?? this.name,
      imageBytes: imageBytes ?? this.imageBytes,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_image': imageSlug ?? file,
      'product_description': description,
      'product_name': name,
    };
  }
}
