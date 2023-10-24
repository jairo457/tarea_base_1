class Reminder {
  int? IdReminder;
  String? NameReminder;
  int? DayReminder;
  int? MonthReminder;
  int? YearReminder;
  int? HourReminder;
  int? MinuteReminder;
  Reminder(
      {this.IdReminder,
      this.NameReminder,
      this.DayReminder,
      this.MonthReminder,
      this.YearReminder,
      this.HourReminder,
      this.MinuteReminder});
  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      IdReminder: map['IdReminder'],
      NameReminder: map['NameReminder'],
      DayReminder: map['DayReminder'],
      MonthReminder: map['MonthReminder'],
      YearReminder: map['YearReminder'],
      HourReminder: map['HourReminder'],
      MinuteReminder: map['MinuteReminder'],
    );
  }
}
