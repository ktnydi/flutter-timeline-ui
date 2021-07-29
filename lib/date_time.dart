import 'package:timeline_ui/weekday.dart';

extension ExDateTime on DateTime {
  String get weekdayName {
    final weekday = WeekDay.values.firstWhere(
      (value) => value.id == this.weekday,
    );
    return weekday.name;
  }
}
