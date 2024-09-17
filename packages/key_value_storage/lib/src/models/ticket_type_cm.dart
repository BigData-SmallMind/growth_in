import 'package:hive/hive.dart';

part 'ticket_type_cm.g.dart';

@HiveType(typeId: 6)
class TicketTypeCM {
  const TicketTypeCM({
    required this.id,
    required this.name,

  });

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;

}


@HiveType(typeId: 7)
class TicketTypesCM {
  const TicketTypesCM({
    required this.list,

  });

  @HiveField(0)
  final List<TicketTypeCM> list;


}
