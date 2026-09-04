import 'package:flutter/material.dart';
import '../services/report_service.dart';
import '../widgets/chart_widgets.dart';
import '../utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';

/// شاشة التقارير والإحصائيات
class ReportsScreen extends StatefulWidget {
  final String userId;

  const ReportsScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  late ReportService _reportService;

  @override
  void initState() {
    super.initState();
    _reportService = ReportService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📊 التقارير والإحصائيات'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // بطاقات الإحصائيات العامة
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'الالتزام اليومي',
                      value: '85%',
                      color: AppColors.success,
                      icon: Icons.check_circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      title: 'الأدوية النشطة',
                      value: '5',
                      color: AppColors.primary,
                      icon: Icons.medical_information,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      title: 'الجرعات المفقودة',
                      value: '2',
                      color: AppColors.warning,
                      icon: Icons.warning,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      title: 'التكلفة الشهرية',
                      value: '250 ر.س',
                      color: AppColors.info,
                      icon: Icons.attach_money,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // رسم بياني خطي - نسبة الالتزام
            LineChartWidget(
              spots: const [
                FlSpot(0, 85),
                FlSpot(1, 88),
                FlSpot(2, 82),
                FlSpot(3, 90),
                FlSpot(4, 87),
                FlSpot(5, 91),
                FlSpot(6, 85),
              ],
              title: 'نسبة الالتزام الأسبوعية',
              xLabel: 'اليوم',
              yLabel: 'النسبة %',
            ),

            // رسم بياني دائري - توزيع الأدوية
            PieChartWidget(
              sections: [
                PieChartSectionData(
                  color: AppColors.primary,
                  value: 40,
                  title: 'مسكنات 40%',
                ),
                PieChartSectionData(
                  color: AppColors.secondary,
                  value: 30,
                  title: 'مضادات 30%',
                ),
                PieChartSectionData(
                  color: AppColors.warning,
                  value: 20,
                  title: 'فيتامينات 20%',
                ),
                PieChartSectionData(
                  color: AppColors.info,
                  value: 10,
                  title: 'أخرى 10%',
                ),
              ],
              title: 'توزيع أنواع الأدوية',
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color color,
    required IconData icon,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
