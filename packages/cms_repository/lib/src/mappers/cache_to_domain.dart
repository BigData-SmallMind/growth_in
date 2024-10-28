import 'package:domain_models/domain_models.dart';
import 'package:key_value_storage/key_value_storage.dart';


extension LocalePreferenceCMToDomain on LocalePreferenceCM {
  LocalePreferenceDM toDomainModel() {
    switch (this) {
      case LocalePreferenceCM.english:
        return LocalePreferenceDM.english;
      case LocalePreferenceCM.arabic:
        return LocalePreferenceDM.arabic;
    }
  }
}

extension TicketTypeCMtoDM on TicketTypeCM {
  TicketType toDomainModel() {
    return TicketType(
      id: id,
      name: name,
    );
  }
}

extension TicketTypesCMtoDM on TicketTypesCM {
  List<TicketType> toDomainModel() {
    return list.map((ticketType) => ticketType.toDomainModel()).toList();
  }
}
