class AppointmentData
{
  String? type;
  String? name;
  String? id;
  String? offered;
  String? current;
  String? priority;
  String? dueDate;
  String? level;
  String? daysLeft;

  AppointmentData(this.type, this.name, this.id, this.offered, this.current,
      this.priority, this.dueDate, this.level, this.daysLeft, this.phoneNumber);

  String? phoneNumber;

  @override
  String toString() {
    return 'AppointmentData{type: $type, name: $name, id: $id, offered: $offered, current: $current, priority: $priority, dueDate: $dueDate, level: $level, daysLeft: $daysLeft, phoneNumber: $phoneNumber}';
  }

}