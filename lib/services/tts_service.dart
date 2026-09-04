import 'package:flutter_tts/flutter_tts.dart';

/// خدمة تحويل النص إلى كلام
class TTSService {
  static final TTSService _instance = TTSService._internal();
  late FlutterTts _flutterTts;

  factory TTSService() {
    return _instance;
  }

  TTSService._internal() {
    _flutterTts = FlutterTts();
  }

  /// تهيئة خدمة TTS
  Future<void> initTTS() async {
    await _flutterTts.setLanguage('ar-SA'); // اللغة العربية السعودية
    await _flutterTts.setPitch(1.0);
    await _flutterTts.setSpeechRate(0.5);
  }

  /// نطق اسم الدواء
  Future<void> speakMedicineName(String medicineName) async {
    String text = 'حان وقت تناول $medicineName';
    await _flutterTts.speak(text);
  }

  /// نطق رسالة مخصصة
  Future<void> speak(String text) async {
    await _flutterTts.speak(text);
  }

  /// إيقاف النطق
  Future<void> stop() async {
    await _flutterTts.stop();
  }

  /// الحصول على قائمة اللغات المدعومة
  Future<List<String>> getLanguages() async {
    return await _flutterTts.getLanguages() as List<String>;
  }

  /// تعيين السرعة
  Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }

  /// تعيين درجة الصوت
  Future<void> setPitch(double pitch) async {
    await _flutterTts.setPitch(pitch);
  }
}
