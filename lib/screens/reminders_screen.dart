import 'package:flutter/material.dart';
import '../models/reminder.dart';
import '../services/database_service.dart';
import '../widgets/reminder_card.dart';
import '../utils/colors.dart';

/// شاشة التنبيهات
class RemindersScreen extends StatefulWidget {
  final String userId;

  const RemindersScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  late DatabaseService _databaseService;
  late Future<List<Reminder>> _remindersFuture;

  @override
  void initState() {
    super.initState();
    _databaseService = DatabaseService();
    _remindersFuture = _databaseService.getAllReminders(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔔 التنبيهات'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Reminder>>(
        future: _remindersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('خطأ: ${snapshot.error}'));
          }

          final reminders = snapshot.data ?? [];

          if (reminders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'لا توجد تنبيهات',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              return ReminderCard(
                reminder: reminder,
                medicineName: 'اسم الدواء',
                onTap: () {},
                onToggle: () {
                  // تحديث حالة التنبيه
                },
                onDelete: () {
                  // حذف التنبيه
                  _databaseService.deleteReminder(reminder.id!);
                  setState(() {
                    _remindersFuture =
                        _databaseService.getAllReminders(widget.userId);
                  });
                },
              );
            },
          );
        },
      ),
    );
  }
}
