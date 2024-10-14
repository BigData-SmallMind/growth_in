import 'package:domain_models/domain_models.dart';
import 'package:intl/intl.dart';

extension MeetingSlotDMtoRM on MeetingSlot {
  String toRemoteModel(DateTime selectedDay) {
    String formatDateTime(DateTime dateTime) {
      return DateFormat('d MMMM yyyy').format(dateTime);
    }

    String formatTime(DateTime dateTime) {
      return DateFormat('HH:mm').format(dateTime);
    }

    final startWithDay = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
      start.hour,
      start.minute,
    );
    final endWithDay = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
      end.hour,
      end.minute,
    );
    String formattedString = '${formatDateTime(startWithDay)}'
        ' From '
        '${formatTime(startWithDay)}'
        ' to '
        '${formatTime(endWithDay)}';
    try {
      return formattedString;
    } catch (error) {
      rethrow;
    }
  }
}
