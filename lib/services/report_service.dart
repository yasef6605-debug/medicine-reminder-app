import 'package:intl/intl.dart';

/// خدمة التقارير والإحصائيات
class ReportService {
  static final ReportService _instance = ReportService._internal();

  factory ReportService() {
    return _instance;
  }

  ReportService._internal();

  /// حساب نسبة الالتزام اليومية
  /// [totalDoses] = عدد الجرعات المطلوبة
  /// [takenDoses] = عدد الجرعات المتناولة
  double calculateDailyAdherence(int takenDoses, int totalDoses) {
    if (totalDoses == 0) return 0.0;
    return (takenDoses / totalDoses) * 100;
  }

  /// حساب نسبة الالتزام الأسبوعية
  double calculateWeeklyAdherence(
      List<int> dailyTakenDoses, List<int> dailyTotalDoses) {
    int totalTaken = 0;
    int totalRequired = 0;

    for (int i = 0; i < dailyTakenDoses.length; i++) {
      totalTaken += dailyTakenDoses[i];
      totalRequired += dailyTotalDoses[i];
    }

    if (totalRequired == 0) return 0.0;
    return (totalTaken / totalRequired) * 100;
  }

  /// حساب تكلفة الأدوية المتناولة
  double calculateMedicineCost(List<double> costs, List<int> quantities) {
    double total = 0;
    for (int i = 0; i < costs.length; i++) {
      total += costs[i] * quantities[i];
    }
    return total;
  }

  /// تنسيق التاريخ
  String formatDate(DateTime date) {
    final formatter = DateFormat('dd/MM/yyyy', 'ar');
    return formatter.format(date);
  }

  /// تنسيق الوقت
  String formatTime(DateTime time) {
    final formatter = DateFormat('HH:mm', 'ar');
    return formatter.format(time);
  }

  /// تنسيق التاريخ والوقت معاً
  String formatDateTime(DateTime dateTime) {
    final formatter = DateFormat('dd/MM/yyyy HH:mm', 'ar');
    return formatter.format(dateTime);
  }

  /// الحصول على إحصائيات بسيطة
  Map<String, dynamic> getSimpleStats({
    required int totalMedicines,
    required int activeMedicines,
    required int missedDoses,
    required int totalDoses,
  }) {
    return {
      'إجمالي الأدوية': totalMedicines,
      'الأدوية النشطة': activeMedicines,
      'الجرعات المفقودة': missedDoses,
      'الجرعات المتناولة': totalDoses - missedDoses,
      'نسبة الالتزام': calculateDailyAdherence(totalDoses - missedDoses, totalDoses),
    };
  }

  /// توليد تقرير نصي
  String generateTextReport(Map<String, dynamic> stats) {
    final buffer = StringBuffer();
    buffer.writeln('=== تقرير الأدوية ===');
    buffer.writeln('التاريخ: ${formatDate(DateTime.now())}');
    buffer.writeln('---');

    stats.forEach((key, value) {
      if (value is double) {
        buffer.writeln('$key: ${value.toStringAsFixed(2)}%');
      } else {
        buffer.writeln('$key: $value');
      }
    });

    return buffer.toString();
  }

  /// حساب أيام تناول الدواء المتبقية
  int calculateRemainingDays(int stock, int dosesPerDay) {
    if (dosesPerDay == 0) return 0;
    return (stock / dosesPerDay).ceil();
  }

  /// التنبؤ بتاريخ انتهاء الدواء
  DateTime predictEndDate(int stock, int dosesPerDay) {
    int daysRemaining = calculateRemainingDays(stock, dosesPerDay);
    return DateTime.now().add(Duration(days: daysRemaining));
  }
}
