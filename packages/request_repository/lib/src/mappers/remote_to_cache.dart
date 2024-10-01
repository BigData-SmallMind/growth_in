import 'package:growth_in_api/growth_in_api.dart';
import 'package:key_value_storage/key_value_storage.dart';

extension TicketTypeRMtoCM on TicketTypeRM {
  TicketTypeCM toCacheModel() {
    return TicketTypeCM(
      id: id,
      name: name,
    );
  }
}

extension TicketTypesRMtoCM on List<TicketTypeRM> {
  TicketTypesCM toCacheModel() {
    final list = map((ticketType) => ticketType.toCacheModel()).toList();
    return TicketTypesCM(
      list: list,
    );
  }
}
