extension DateTimeManipulators on DateTime {
  String? formatDateTimeTo12Hour() {
    // Extract hour and minute
    int hour = this.hour;
    int minute = this.minute;

    // Determine AM or PM
    String period = hour >= 12 ? 'PM' : 'AM';

    // Convert to 12-hour format
    int twelveHour = hour % 12;
    twelveHour = twelveHour == 0 ? 12 : twelveHour; // Handle 12 AM/PM

    // Format minute to always be two digits
    String formattedMinute = minute.toString().padLeft(2, '0');

    return '$twelveHour:$formattedMinute $period';
  }

  String? extractDate() {
    int year = this.year;
    int month = this.month;
    int day = this.day;
    String dayName = weekday == 1
        ? 'Monday'
        : weekday == 2
            ? 'Tuesday'
            : weekday == 3
                ? 'Wednesday'
                : weekday == 4
                    ? 'Thursday'
                    : weekday == 5
                        ? 'Friday'
                        : weekday == 6
                            ? 'Saturday'
                            : 'Sunday';
    String formattedDate =
        '${dayName.toString()} '
        '${year.toString().padLeft(4, '0')}'
        '-${month.toString().padLeft(2, '0')}'
        '-${day.toString().padLeft(2, '0')}';
    return formattedDate;
  }
}

extension TwentyFourToTwelveHourFormat on String {
  String convert24HourTo12Hour() {
    // Extract hour and minute
    int hour = int.parse(split(':')[0]);
    int minute = int.parse(split(':')[1]);

    // Determine AM or PM
    String period = hour >= 12 ? 'PM' : 'AM';

    // Convert to 12-hour format
    int twelveHour = hour % 12;
    twelveHour = twelveHour == 0 ? 12 : twelveHour; // Handle 12 AM/PM

    // Format minute to always be two digits
    String formattedMinute = minute.toString().padLeft(2, '0');

    return '$twelveHour:$formattedMinute $period';
  }
}