/// الثوابت والقيم الثابتة
class AppConstants {
  /// أنواع الأدوية
  static const List<String> medicineTypes = [
    'مسكن',
    'مضاد حيوي',
    'فيتامينات',
    'خافض ضغط',
    'خافض سكر',
    'مهدئ',
    'منوم',
    'مضاد حموضة',
    'معقم معوي',
    'أخرى',
  ];

  /// أشكال الأدوية
  static const List<String> medicineForms = [
    'أقراص',
    'كبسولة',
    'شراب',
    'حقنة',
    'مرهم',
    'قطرات',
    'لاصقة',
    'بخاخ',
  ];

  /// توقيت التناول بالنسبة للطعام
  static const List<String> mealTimings = [
    'قبل الطعام بـ 30 دقيقة',
    'مع الطعام',
    'بعد الطعام بـ 30 دقيقة',
    'بدون الربط بالطعام',
  ];

  /// أيام الأسبوع
  static const List<String> daysOfWeek = [
    'الأحد',
    'الاثنين',
    'الثلاثاء',
    'الأربعاء',
    'الخميس',
    'الجمعة',
    'السبت',
  ];

  /// أنواع جهات الاتصال الطارئة
  static const List<String> emergencyContactTypes = [
    'طبيب',
    'صيدلية',
    'مستشفى',
    'شرطة إسعاف',
    'مركز سموم',
    'أخرى',
  ];

  /// مستويات شدة التفاعلات الدوائية
  static const List<String> severityLevels = [
    'خفيف',
    'متوسط',
    'شديد',
  ];

  /// الحالات المزاجية
  static const List<String> moods = [
    'ممتاز',
    'جيد',
    'متوسط',
    'سيء',
    'سيء جداً',
  ];

  /// رسائل الخطأ
  static const Map<String, String> errorMessages = {
    'empty_name': 'الرجاء إدخال اسم الدواء',
    'empty_type': 'الرجاء اختيار نوع الدواء',
    'empty_time': 'الرجاء تحديد وقت التناول',
    'invalid_dosage': 'الرجاء إدخال جرعة صحيحة',
    'empty_stock': 'الرجاء إدخال رقم المخزون',
    'empty_days': 'الرجاء اختيار أيام التناول',
  };

  /// رسائل النجاح
  static const Map<String, String> successMessages = {
    'medicine_added': 'تم إضافة الدواء بنجاح',
    'medicine_updated': 'تم تحديث الدواء بنجاح',
    'medicine_deleted': 'تم حذف الدواء بنجاح',
    'reminder_added': 'تم إضافة التنبيه بنجاح',
    'reminder_deleted': 'تم حذف التنبيه بنجاح',
    'profile_created': 'تم إنشاء الملف الشخصي بنجاح',
  };

  /// الحد الأدنى لتنبيه قلة المخزون
  static const int lowStockThreshold = 7;

  /// وقت التنبيه المسبق (بالدقائق)
  static const int reminderAdvanceTime = 5;

  /// حد أقصى لعدد الملفات الشخصية
  static const int maxProfiles = 10;
}
