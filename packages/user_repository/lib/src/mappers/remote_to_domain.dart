import 'package:company_repository/company_repository.dart';
import 'package:growth_in_api/growth_in_api.dart';
import 'package:domain_models/domain_models.dart';

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
