/// نموذج التنبيهات
class Reminder {
  final String? id;
  final String medicineId;
  final String time; // الوقت بصيغة HH:mm
  final List<int> daysOfWeek; // أيام الأسبوع (0-6)
  final bool isActive;
  final bool hasNotification;
  final String userId;
  final DateTime createdDate;
  final String? notes;
  final bool takeTaken; // هل تم تناول الدواء
  final DateTime? lastTakenTime; // آخر وقت تم تناول الدواء

  Reminder({
    this.id,
    required this.medicineId,
    required this.time,
    required this.daysOfWeek,
    this.isActive = true,
    this.hasNotification = true,
    required this.userId,
    required this.createdDate,
    this.notes,
    this.takeTaken = false,
    this.lastTakenTime,
  });

  /// تحويل الكائن إلى خريطة للقاعدة البيانات
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicineId': medicineId,
      'time': time,
      'daysOfWeek': daysOfWeek.join(','),
      'isActive': isActive ? 1 : 0,
      'hasNotification': hasNotification ? 1 : 0,
      'userId': userId,
      'createdDate': createdDate.toIso8601String(),
      'notes': notes,
      'takeTaken': takeTaken ? 1 : 0,
      'lastTakenTime': lastTakenTime?.toIso8601String(),
    };
  }

  /// إنشاء كائن من خريطة
  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      medicineId: map['medicineId'],
      time: map['time'],
      daysOfWeek: (map['daysOfWeek'] as String)
          .split(',')
          .map((e) => int.parse(e))
          .toList(),
      isActive: map['isActive'] == 1,
      hasNotification: map['hasNotification'] == 1,
      userId: map['userId'],
      createdDate: DateTime.parse(map['createdDate']),
      notes: map['notes'],
      takeTaken: map['takeTaken'] == 1,
      lastTakenTime: map['lastTakenTime'] != null
          ? DateTime.parse(map['lastTakenTime'])
          : null,
    );
  }

  /// نسخ مع تعديل
  Reminder copyWith({
    String? id,
    String? medicineId,
    String? time,
    List<int>? daysOfWeek,
    bool? isActive,
    bool? hasNotification,
    String? userId,
    DateTime? createdDate,
    String? notes,
    bool? takeTaken,
    DateTime? lastTakenTime,
  }) {
    return Reminder(
      id: id ?? this.id,
      medicineId: medicineId ?? this.medicineId,
      time: time ?? this.time,
      daysOfWeek: daysOfWeek ?? this.daysOfWeek,
      isActive: isActive ?? this.isActive,
      hasNotification: hasNotification ?? this.hasNotification,
      userId: userId ?? this.userId,
      createdDate: createdDate ?? this.createdDate,
      notes: notes ?? this.notes,
      takeTaken: takeTaken ?? this.takeTaken,
      lastTakenTime: lastTakenTime ?? this.lastTakenTime,
    );
  }

  @override
  String toString() =>
      'Reminder(medicineId: $medicineId, time: $time, isActive: $isActive)';
}
