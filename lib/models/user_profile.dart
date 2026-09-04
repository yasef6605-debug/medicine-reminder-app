/// نموذج ملف المستخدم
class UserProfile {
  final String? id;
  final String name;
  final String email;
  final int age;
  final String gender; // ذكر/أنثى
  final String? phoneNumber;
  final String? medicalHistory; // السجل الطبي
  final List<String>? allergies; // الحساسيات
  final List<String>? chronicDiseases; // الأمراض المزمنة
  final DateTime createdDate;
  final String? profileImage;
  final bool isPrimary; // هل هو الملف الأساسي
  final String? notes; // ملاحظات إضافية

  UserProfile({
    this.id,
    required this.name,
    required this.email,
    required this.age,
    required this.gender,
    this.phoneNumber,
    this.medicalHistory,
    this.allergies,
    this.chronicDiseases,
    required this.createdDate,
    this.profileImage,
    this.isPrimary = false,
    this.notes,
  });

  /// تحويل الكائن إلى خريطة للقاعدة البيانات
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'age': age,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'medicalHistory': medicalHistory,
      'allergies': allergies?.join(','),
      'chronicDiseases': chronicDiseases?.join(','),
      'createdDate': createdDate.toIso8601String(),
      'profileImage': profileImage,
      'isPrimary': isPrimary ? 1 : 0,
      'notes': notes,
    };
  }

  /// إنشاء كائن من خريطة
  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      age: map['age'],
      gender: map['gender'],
      phoneNumber: map['phoneNumber'],
      medicalHistory: map['medicalHistory'],
      allergies: map['allergies'] != null
          ? (map['allergies'] as String).split(',')
          : null,
      chronicDiseases: map['chronicDiseases'] != null
          ? (map['chronicDiseases'] as String).split(',')
          : null,
      createdDate: DateTime.parse(map['createdDate']),
      profileImage: map['profileImage'],
      isPrimary: map['isPrimary'] == 1,
      notes: map['notes'],
    );
  }

  /// نسخ مع تعديل
  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    int? age,
    String? gender,
    String? phoneNumber,
    String? medicalHistory,
    List<String>? allergies,
    List<String>? chronicDiseases,
    DateTime? createdDate,
    String? profileImage,
    bool? isPrimary,
    String? notes,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      medicalHistory: medicalHistory ?? this.medicalHistory,
      allergies: allergies ?? this.allergies,
      chronicDiseases: chronicDiseases ?? this.chronicDiseases,
      createdDate: createdDate ?? this.createdDate,
      profileImage: profileImage ?? this.profileImage,
      isPrimary: isPrimary ?? this.isPrimary,
      notes: notes ?? this.notes,
    );
  }

  @override
  String toString() => 'UserProfile(name: $name, age: $age, gender: $gender)';
}
