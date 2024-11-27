class MeetingSlotAvailable {
  const MeetingSlotAvailable({
    required this.date,
    required this.hasFreeSlots,
  });

  final DateTime date;
  final bool hasFreeSlots;
}
