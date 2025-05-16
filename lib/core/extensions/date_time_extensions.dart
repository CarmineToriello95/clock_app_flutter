import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String get formatToHHmm => DateFormat.Hm().format(this);
  String get formatToEEEdMMM => DateFormat('EEE d MMM ').format(this);
  int calendarWeekNumber() {
    // Adjust date to the nearest Thursday (ISO 8601 defines week starting on Monday)
    final adjustedDate = add(Duration(days: 3 - ((weekday + 6) % 7)));

    // Create a date for January 4th of the year.
    // ISO 8601 defines that the week containing Jan 4 is always week 1.
    final firstThursday = DateTime(adjustedDate.year, 1, 4);
    // Calculate the start of the ISO week (i.e., the Monday) that contains January 4th.
    final firstWeekStart = firstThursday.subtract(
      Duration(days: (firstThursday.weekday + 6) % 7),
    );

    // Calculate the difference in weeks
    final diff = adjustedDate.difference(firstWeekStart).inDays ~/ 7;

    // Return the ISO week number by adding 1 (since counting starts from week 1, not week 0).
    return diff + 1;
  }

  String calculateTimeElapsed(DateTime previousDate) {
    final Duration diff = difference(previousDate);
    final int days = diff.inDays;
    final int hours = diff.inHours % 24;
    final int minutes = diff.inMinutes % 60;
    final int seconds = diff.inSeconds % 60;

    final List<String> parts = <String>[];

    if (days > 0) parts.add('${days.toString().padLeft(2, '0')}d');
    if (hours > 0 || days > 0) {
      parts.add('${hours.toString().padLeft(2, '0')}h');
    }
    if (minutes > 0 || hours > 0 || days > 0) {
      parts.add('${minutes.toString().padLeft(2, '0')}m');
    }
    parts.add('${seconds.toString().padLeft(2, '0')}s');

    return parts.join(' ');
  }
}
