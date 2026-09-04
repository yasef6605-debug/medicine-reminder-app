/// نموذج البيانات للأدوية
class Medicine {
  final String? id;
  final String name;
  final String type; // مسكن، مضاد حيوي، إلخ
  final String form; // أقراص، كبسول، شراب
  final double dosage; // الجرعة
  final String dosageUnit; // عدد الحبات
  final List<String> timesPerDay; // مواعيد التناول
  final String timing; // قبل/بعد الطعام
  final String? sideEffects; // الآثار الجانبية
  final String? contraindications; // موانع الاستعمال
  final String? usage; // طريقة الاستخدام
  final int stock; // المخزون
  final DateTime? expiryDate; // تاريخ الانتهاء
  final String userId; // معرف المستخدم
  final DateTime addedDate; // تاريخ الإضافة
  final bool isActive; // هل الدواء نشط
  final String? notes; // ملاحظات
  final String? barcode; // الباركود
  final double? costPerUnit; // السعر لكل وحدة

  Medicine({
    this.id,
    required this.name,
    required this.type,
    required this.form,
    required this.dosage,
    required this.dosageUnit,
    required this.timesPerDay,
    required this.timing,
    this.sideEffects,
    this.contraindications,
    this.usage,
    required this.stock,
    this.expiryDate,
    required this.userId,
    required this.addedDate,
    this.isActive = true,
    this.notes,
    this.barcode,
    this.costPerUnit,
  });

  /// تحويل الكائن إلى خريطة للقاعدة البيانات
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'form': form,
      'dosage': dosage,
      'dosageUnit': dosageUnit,
      'timesPerDay': timesPerDay.join(','),
      'timing': timing,
      'sideEffects': sideEffects,
      'contraindications': contraindications,
      'usage': usage,
      'stock': stock,
      'expiryDate': expiryDate?.toIso8601String(),
      'userId': userId,
      'addedDate': addedDate.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'notes': notes,
      'barcode': barcode,
      'costPerUnit': costPerUnit,
    };
  }

  /// إنشاء كائن من خريطة
  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      form: map['form'],
      dosage: map['dosage'],
      dosageUnit: map['dosageUnit'],
      timesPerDay: (map['timesPerDay'] as String).split(','),
      timing: map['timing'],
      sideEffects: map['sideEffects'],
      contraindications: map['contraindications'],
      usage: map['usage'],
      stock: map['stock'],
      expiryDate: map['expiryDate'] != null
          ? DateTime.parse(map['expiryDate'])
          : null,
      userId: map['userId'],
      addedDate: DateTime.parse(map['addedDate']),
      isActive: map['isActive'] == 1,
      notes: map['notes'],
      barcode: map['barcode'],
      costPerUnit: map['costPerUnit'],
    );
  }

  /// نسخ مع تعديل
  Medicine copyWith({
    String? id,
    String? name,
    String? type,
    String? form,
    double? dosage,
    String? dosageUnit,
    List<String>? timesPerDay,
    String? timing,
    String? sideEffects,
    String? contraindications,
    String? usage,
    int? stock,
    DateTime? expiryDate,
    String? userId,
    DateTime? addedDate,
    bool? isActive,
    String? notes,
    String? barcode,
    double? costPerUnit,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      form: form ?? this.form,
      dosage: dosage ?? this.dosage,
      dosageUnit: dosageUnit ?? this.dosageUnit,
      timesPerDay: timesPerDay ?? this.timesPerDay,
      timing: timing ?? this.timing,
      sideEffects: sideEffects ?? this.sideEffects,
      contraindications: contraindications ?? this.contraindications,
      usage: usage ?? this.usage,
      stock: stock ?? this.stock,
      expiryDate: expiryDate ?? this.expiryDate,
      userId: userId ?? this.userId,
      addedDate: addedDate ?? this.addedDate,
      isActive: isActive ?? this.isActive,
      notes: notes ?? this.notes,
      barcode: barcode ?? this.barcode,
      costPerUnit: costPerUnit ?? this.costPerUnit,
    );
  }

  @override
  String toString() =>
      'Medicine(name: $name, type: $type, stock: $stock, isActive: $isActive)';
}
