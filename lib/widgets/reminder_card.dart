import 'package:flutter/material.dart';
import '../models/reminder.dart';
import '../utils/colors.dart';

/// بطاقة التنبيه
class ReminderCard extends StatelessWidget {
  final Reminder reminder;
  final String medicineName;
  final VoidCallback onTap;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final bool isTaken;

  const ReminderCard({
    Key? key,
    required this.reminder,
    required this.medicineName,
    required this.onTap,
    required this.onToggle,
    required this.onDelete,
    this.isTaken = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: isTaken ? AppColors.success.withOpacity(0.1) : null,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // أيقونة الحالة
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: isTaken ? AppColors.success : AppColors.info,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Icon(
                    isTaken ? Icons.check_circle : Icons.schedule,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // معلومات التنبيه
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicineName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          reminder.time,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    if (isTaken) ...[const SizedBox(height: 4),
                    const Text(
                      '✓ تم تناول الدواء',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.success,
                        fontWeight: FontWeight.bold,
                      ),
                    ),]
                  ],
                ),
              ),
              // الأزرار
              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      isTaken ? Icons.check_box : Icons.check_box_outline_blank,
                      color: isTaken ? AppColors.success : AppColors.primary,
                    ),
                    onPressed: onToggle,
                    splashRadius: 24,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    color: AppColors.danger,
                    onPressed: onDelete,
                    splashRadius: 24,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
