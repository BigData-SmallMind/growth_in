import 'package:growth_in_api/growth_in_api.dart';
import 'package:domain_models/domain_models.dart';

extension TicketRMtoDM on TicketRM {
  TicketStatus ticketStatusRMtoDM(String ticketStatus) {
    // مفتوحة , محلولة , مغلقة
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

extension RequestV1RMtoDM on RequestV1RM {
  Request toDomainModel() {
    //             "due_date": "2024/10/02",

    try {
      final dueDateDM = DateTime.parse(dueDate.replaceAll('/', '-'));
      final startDateDM = DateTime.parse(startDate.replaceAll('/', '-'));
      return Request(
        id: id,
        name: name,
        serviceName: serviceName ?? '',
        dueDate: dueDateDM,
        startDate: startDateDM,
        descriptionHtml: null,
        actions: [],
        comments: [],
        completeActionStepsCount: actionsCompletedCount,
        totalActionStepsCount: actionsTotalCount,
      );
    } catch (error) {
      rethrow;
    }
  }
}

extension RequestsV1RMtoDM on List<RequestV1RM> {
  List<Request> toDomainModel() {
    return map((request) => request.toDomainModel()).toList();
  }
}

extension RequestRMtoDM on RequestRM {
  Request toDomainModel(List<Comment> comments) {
    final dueDateDM = DateTime.parse(deadline.replaceAll('/', '-'));
    final startDateDM = DateTime.parse(dateCreated.replaceAll('/', '-'));
    final actionsDM = actions?.map((action) => action.toDomainModel()).toList();
    final completedActionStepsCount = actionsDM
        ?.map((action) => action.steps.where((step) => step.isComplete).length)
        .fold(0, (previousValue, element) => previousValue + element);
    final totalActionStepsCount = actionsDM
        ?.map((action) => action.steps.length)
        .fold(0, (previousValue, element) => previousValue + element);
    return Request(
      id: id,
      name: name,
      serviceName: serviceName ?? '',
      dueDate: dueDateDM,
      startDate: startDateDM,
      descriptionHtml: descriptionHtml,
      actions: actionsDM ?? [],
      comments: comments,
      completeActionStepsCount: completedActionStepsCount,
      totalActionStepsCount: totalActionStepsCount,
      isCompleted: isCompleted,
    );
  }
}

extension RequestsRMtoDM on List<RequestRM> {
  List<Request> toDomainModel(List<Comment> comments) {
    return map((request) => request.toDomainModel(comments)).toList();
  }
}

extension ActionRMtoDM on ActionRM {
  Action toDomainModel() {
    final stepsDM = steps?.map((step) => step.toDomainModel()).toList();
    return Action(
      id: id,
      title: title,
      steps: stepsDM ?? [],
    );
  }
}

extension ActionsRMtoDM on List<ActionRM> {
  List<Action> toDomainModel() {
    return map((action) => action.toDomainModel()).toList();
  }
}

extension StepRMtoDM on StepRM {
  Step toDomainModel() {
    return Step(
      id: id,
      description: content,
      isComplete: isCompleted,
      isCompulsory: false,
    );
  }
}

extension CommentRMtoDM on CommentRM {
  Comment toDomainModel() {
    final dateCreatedDM = DateTime.parse(dateCreated.replaceAll('/', '-'));
    return Comment(
      id: id,
      author: author,
      text: comment,
      dateCreated: dateCreatedDM,
      authorImage: image,
    );
  }
}

extension CommentsRMtoDM on List<CommentRM> {
  List<Comment> toDomainModel() {
    return map((comment) => comment.toDomainModel()).toList();
  }
}
