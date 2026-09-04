/// نموذج جهة الاتصال الطارئة
class EmergencyContact {
  final String? id;
  final String name;
  final String type; // طبيب، صيدلية، مستشفى، شرطة إسعا��
  final String phoneNumber;
  final String? email;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? notes;
  final bool isFavorite;

  EmergencyContact({
    this.id,
    required this.name,
    required this.type,
    required this.phoneNumber,
    this.email,
    this.address,
    this.latitude,
    this.longitude,
    this.notes,
    this.isFavorite = false,
  });

  /// تحويل الكائن إلى خريطة للقاعدة البيانات
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'phoneNumber': phoneNumber,
      'email': email,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'notes': notes,
      'isFavorite': isFavorite ? 1 : 0,
    };
  }

  /// إنشاء كائن من خريطة
  factory EmergencyContact.fromMap(Map<String, dynamic> map) {
    return EmergencyContact(
      id: map['id'],
      name: map['name'],
      type: map['type'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      address: map['address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      notes: map['notes'],
      isFavorite: map['isFavorite'] == 1,
    );
  }

  @override
  String toString() => 'EmergencyContact(name: $name, type: $type)';
}
