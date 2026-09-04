import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../utils/colors.dart';

/// شاشة تفاصيل الدواء
class MedicineDetailsScreen extends StatelessWidget {
  final Medicine medicine;

  const MedicineDetailsScreen({Key? key, required this.medicine})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicine.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // معلومات أساسية
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'معلومات عامة',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('الاسم', medicine.name),
                    _buildInfoRow('النوع', medicine.type),
                    _buildInfoRow('الشكل', medicine.form),
                    _buildInfoRow(
                        'الجرعة', '${medicine.dosage} ${medicine.dosageUnit}'),
                    _buildInfoRow('التوقيت', medicine.timing),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // معلومات المخزون
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'المخزون',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: medicine.stock <= 7
                            ? AppColors.warning.withOpacity(0.2)
                            : AppColors.success.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${medicine.stock} وحدة متبقية',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: medicine.stock <= 7
                              ? AppColors.warning
                              : AppColors.success,
                        ),
                      ),
                    ),
                    if (medicine.expiryDate != null) ...[const SizedBox(height: 12),
                    _buildInfoRow(
                        'تاريخ الانتهاء',
                        '${medicine.expiryDate!.day}/${medicine.expiryDate!.month}/${medicine.expiryDate!.year}'),],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // معلومات طبية
            if (medicine.sideEffects != null || medicine.contraindications != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'معلومات طبية',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (medicine.sideEffects != null) ...[const Text(
                        'الآثار الجانبية:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(medicine.sideEffects!),
                      const SizedBox(height: 12),],
                      if (medicine.contraindications != null) ...[const Text(
                        'موانع الاستعمال:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(medicine.contraindications!),],
                    ],
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // الملاحظات
            if (medicine.notes != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ملاحظات',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(medicine.notes!),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
