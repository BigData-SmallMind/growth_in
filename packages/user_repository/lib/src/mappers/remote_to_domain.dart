import 'package:cms_repository/cms_repository.dart';
import 'package:company_repository/company_repository.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:domain_models/domain_models.dart';
import 'package:meeting_repository/meeting_repository.dart';

extension UserRMtoDM on UserRM {
  User toDomainModel() {
    final companiesDM = info.companies
        .map(
          (company) => company.toDomainModel().copyWith(
                isSelected: company.id == info.selectedCompanyId ? true : false,
              ),
        )
        .toList();

    return User(
      id: info.id,
      name: info.name,
      email: info.email,
      phone: info.phone,
      countryCode: info.countryCode,
      image: info.image,
      companies: companiesDM,
    );
  }
}

extension TicketRMtoDM on TicketRM {
  TicketStatus ticketStatusRMtoDM(String ticketStatus) {
    switch (ticketStatus) {
      case 'مفتوحة':
        return TicketStatus.open;
      case 'محلولة':
        return TicketStatus.solved;
      case 'مغلقة':
        return TicketStatus.closed;
      default:
        return TicketStatus.open;
    }
  }

  Ticket toDomainModel() {
    //2024-09-10T08:54:40.000000Z to date time
    final createdAtDM = DateTime.parse(createdAt);
    final statusDM = ticketStatusRMtoDM(status);
    return Ticket(
      id: id,
      title: title,
      subject: subject,
      status: statusDM,
      createdAt: createdAtDM,
    );
  }
}

extension TicketTypeRMtoDM on TicketTypeRM {
  TicketType toDomainModel() {
    return TicketType(
      id: id,
      name: name,
    );
  }
}

extension TicketTypesRMtoDM on List<TicketTypeRM> {
  List<TicketType> toDomainModel() {
    return map((ticketType) => ticketType.toDomainModel()).toList();
  }
}

extension TicketMessageRMtoDM on TicketMessageRM {
  TicketMessage toDomainModel() {
    final createdAtDM = DateTime.parse(createdAt);
    return TicketMessage(
      id: id,
      text: text,
      file: file,
      createdAt: createdAtDM,
      profileImage: profileImage,
      companyName: companyName,
    );
  }
}

extension TicketMessagesRMtoDM on List<TicketMessageRM> {
  List<TicketMessage> toDomainModel() {
    return map((ticketMessage) => ticketMessage.toDomainModel()).toList();
  }
}

extension DateGroupedChatsRMtoDM on DateGroupedChatsRM {
  DateGroupedChats toDomainModel() {
    final chatsDM = chats.map((chat) => chat.toDomainModel()).toList();
    return DateGroupedChats(
      list: chatsDM,
    );
  }
}

extension ChatMessagesRMtoDM on ChatRM {
  Chat toDomainModel() {
    final messagesDM =
        messages.map((message) => message.toDomainModel()).toList();
    final dateDM = DateTime.parse(date);
    return Chat(
      date: dateDM,
      messages: messagesDM,
    );
  }
}

extension ChatMessageRMtoDM on ChatMessageRM {
  ChatMessage toDomainModel() {
    final dateDM = DateTime.parse(date);
    return ChatMessage(
      id: id,
      text: text,
      files: files?.map((file) => file.toDomainModel()).toList(),
      date: dateDM,
      sender: sender.toDomainModel(),
    );
  }
}

extension SenderRMtoDM on SenderRM {
  Sender toDomainModel() {
    return Sender(
      id: id,
      name: name,
      image: image,
    );
  }
}

extension FileRMtoDM on FileRM {
  FileDM toDomainModel() {
    return FileDM(
      name: name,
      extension: name.split('.').last,
      size: size,
    );
  }
}

extension FormsRMtoDM on FormsRM {
  FormsDM toDomainModel() {
    return FormsDM(
      list: list.map((form) => form.toDomainModel()).toList(),
      previous: previous.map((form) => form.toDomainModel()).toList(),
    );
  }
}

extension FormRMtoDM on FormRM {
  FormDM toDomainModel() {
    return FormDM(
      id: id,
      name: name,
      status: status,
      totalQuestions: totalQuestions,
      totalAnsweredQuestions: totalAnsweredQuestions,
      services: services?.map((service) => service.toDomainModel()).toList(),
    );
  }
}

extension ServiceRMtoDM on ServiceRM {
  ServiceDM toDomainModel() {
    return ServiceDM(
      id: id,
      name: name,
    );
  }
}

extension FormsSectionsRMtoDM on FormsSectionsRM {
  FormsSections toDomainModel() {
    final sectionsDM =
        sections.map((section) => section.toDomainModel()).toList();
    return FormsSections(
      id: id,
      list: sectionsDM,
      formName: formName,
      serviceName: serviceName,
    );
  }
}

extension FormSectionRMtoDM on FormSectionRM {
  FormSection toDomainModel() {
    final questionsDM =
        questions.map((question) => question.toDomainModel()).toList();
    return FormSection(
      id: id,
      name: name,
      questions: questionsDM,
    );
  }
}

extension QuestionRMtoDM on QuestionRM {
  QuestionType questionTypeRMtoDM(String questionType) {
    switch (questionType) {
      case 'اجوبة طويلة':
        return QuestionType.longEssay;
      case 'اجوبة قصيرة':
        return QuestionType.essay;
      case 'مقياس خطي':
        return QuestionType.slider;
      case 'الاسئلة متعددة الاختيارات':
        return QuestionType.multipleChoice;
      case 'قائمة منسدلة':
        return QuestionType.dropdown;
      case 'رفع ملف':
        return QuestionType.fileUpload;
      case 'تعدد اختيار الصور':
        return QuestionType.multipleImageChoice;
      case 'تاريخ/ساعة':
        return QuestionType.dateType;
      case 'سؤال صور مع اجوبة':
        return QuestionType.imageAndText;
      default:
        throw Exception('Unknown question type');
    }
  }

  QuestionType dateTimeQuestionTypeRMtoDM() {
    if (isTimeRange == true) {
      if (allowDate == true && allowTime == true) {
        return QuestionType.dateAndTimeRange;
      } else if (allowDate == true) {
        return QuestionType.dateRange;
      } else if (allowTime == true) {
        return QuestionType.timeRange;
      }
    }
    if (allowDate == true && allowTime == true) {
      return QuestionType.dateAndTime;
    } else if (allowDate == true) {
      return QuestionType.dateOnly;
    } else if (allowTime == true) {
      return QuestionType.timeOnly;
    }
    throw Exception('Unknown question type');
  }

  Question toDomainModel() {
    try {
      final isFileUploadQuestion =
          questionTypeRMtoDM(type) == QuestionType.fileUpload;
      final fileUploadAnswers = isFileUploadQuestion
          ? (answer as List?)
              ?.map(
                (answer) => FileDM(
                  name: answer['file_name'],
                  extension: answer['file_name'].split('.').last,
                  size: (answer['file_size'] as double).toInt(),
                ),
              )
              .toList()
          : answer;

      return Question(
        id: id,
        text: text,
        description: description ?? '',
        type: questionTypeRMtoDM(type) == QuestionType.dateType
            ? dateTimeQuestionTypeRMtoDM()
            : questionTypeRMtoDM(type),
        allowMultipleAnswers: allowMultipleAnswers,
        allowAnotherAnswer: allowAnotherAnswer,
        answer: isFileUploadQuestion ? fileUploadAnswers : answer,
        otherAnswer: anotherAnswer,
        allowDate: allowDate,
        allowTime: allowTime,
        isTimeRange: isTimeRange,
        choices: imageChoices ?? choices,
        sliderMin: (sliderMax != null && sliderMin != null)
            ? (sliderMin! > sliderMax! ? sliderMax : sliderMin)
            : null,
        sliderMax: (sliderMax != null && sliderMin != null)
            ? (sliderMax! < sliderMin! ? sliderMin : sliderMax)
            : null,
        // isRequired: true,
        isRequired: isRequired,
      );
    } catch (error) {
      rethrow;
    }
  }
}

extension HomeRequestRMtoDM on HomeRequestRM {
  Request toDomainModel() {
    final startDateDM = DateTime.parse(startDate.replaceAll('/', '-'));
    final dueDateDM = DateTime.parse(dueDate.replaceAll('/', '-'));
    return Request(
      id: id,
      name: name,
      startDate: startDateDM,
      dueDate: dueDateDM,
      actions: [],
    );
  }
}

extension HomeRequestsRMtoDM on List<HomeRequestRM> {
  List<Request> toDomainModel() {
    return map((request) => request.toDomainModel()).toList();
  }
}

extension HomeRMtoDM on HomeRM {
  Home toDomainModel() {
    return Home(
      meeting: meeting?.toDomainModel(),
      posts: posts.toDomainModel(),
      requests: requests.toDomainModel(),
      dashboardLink: dashboardLink,
      filesCount: filesCount,
    );
  }
}
