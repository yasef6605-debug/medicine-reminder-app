/// نموذج استهلاك الأدوية
class MedicineConsumption {
  final String? id;
  final String medicineId;
  final String userId;
  final DateTime takenDate;
  final String time;
  final double quantity; // عدد الأقراص
  final bool isMissed; // هل تم تخطي الجرعة
  final String? notes; // ملاحظات
  final String? symptoms; // الأعراض بعد التناول
  final double? bloodPressure; // ضغط الدم
  final double? temperature; // درجة الحرارة

  MedicineConsumption({
    this.id,
    required this.medicineId,
    required this.userId,
    required this.takenDate,
    required this.time,
    required this.quantity,
    this.isMissed = false,
    this.notes,
    this.symptoms,
    this.bloodPressure,
    this.temperature,
  });

  /// تحويل الكائن إلى خريطة للقاعدة البيانات
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicineId': medicineId,
      'userId': userId,
      'takenDate': takenDate.toIso8601String(),
      'time': time,
      'quantity': quantity,
      'isMissed': isMissed ? 1 : 0,
      'notes': notes,
      'symptoms': symptoms,
      'bloodPressure': bloodPressure,
      'temperature': temperature,
    };
  }

  /// إنشاء كائن من خريطة
  factory MedicineConsumption.fromMap(Map<String, dynamic> map) {
    return MedicineConsumption(
      id: map['id'],
      medicineId: map['medicineId'],
      userId: map['userId'],
      takenDate: DateTime.parse(map['takenDate']),
      time: map['time'],
      quantity: map['quantity'],
      isMissed: map['isMissed'] == 1,
      notes: map['notes'],
      symptoms: map['symptoms'],
      bloodPressure: map['bloodPressure'],
      temperature: map['temperature'],
    );
  }

  @override
  String toString() =>
      'MedicineConsumption(medicineId: $medicineId, quantity: $quantity, isMissed: $isMissed)';
}
