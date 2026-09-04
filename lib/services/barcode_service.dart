import 'package:barcode_scan2/barcode_scan2.dart';

/// خدمة مسح الباركود
class BarcodeService {
  static final BarcodeService _instance = BarcodeService._internal();

  factory BarcodeService() {
    return _instance;
  }

  BarcodeService._internal();

  /// مسح الباركود من الكاميرا
  Future<String?> scanBarcode() async {
    try {
      final result = await BarcodeScanner.scan();
      return result.rawContent.isNotEmpty ? result.rawContent : null;
    } catch (e) {
      print('خطأ في مسح الباركود: $e');
      return null;
    }
  }

  /// استخراج اسم الدواء من الباركود
  /// هذا مثال بسيط - يمكن توسيعه للتكامل مع قاعدة بيانات
  Future<String?> extractMedicineName(String barcode) async {
    // هنا يمكن الربط مع API أو قاعدة بيانات للأدوية
    // حالياً سيتم إرجاع الباركود كما هو
    return barcode;
  }

  /// التحقق من صحة الباركود
  bool isValidBarcode(String barcode) {
    return barcode.isNotEmpty && barcode.length >= 8;
  }
}
