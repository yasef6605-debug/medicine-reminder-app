import 'package:flutter/material.dart';
import '../models/medicine.dart';
import '../services/database_service.dart';
import '../widgets/medicine_card.dart';
import '../widgets/custom_button.dart';
import '../utils/colors.dart';

/// الشاشة الرئيسية
class HomeScreen extends StatefulWidget {
  final String userId;

  const HomeScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DatabaseService _databaseService;
  late Future<List<Medicine>> _medicinesFuture;

  @override
  void initState() {
    super.initState();
    _databaseService = DatabaseService();
    _medicinesFuture = _databaseService.getAllMedicines(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('💊 إدارة الأدوية'),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<Medicine>>(
        future: _medicinesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('خطأ: ${snapshot.error}'),
            );
          }

          final medicines = snapshot.data ?? [];

          if (medicines.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.medical_information_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'لا توجد أدوية مسجلة',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomButton(
                    text: 'إضافة دواء أول',
                    onPressed: () {
                      // الانتقال إلى شاشة إضافة الدواء
                    },
                    backgroundColor: AppColors.primary,
                    width: 200,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: medicines.length,
            itemBuilder: (context, index) {
              final medicine = medicines[index];
              return MedicineCard(
                medicine: medicine,
                onTap: () {
                  // عرض تفاصيل الدواء
                },
                onEdit: () {
                  // تعديل الدواء
                },
                onDelete: () {
                  // حذف الدواء
                  _databaseService.deleteMedicine(medicine.id!);
                  setState(() {
                    _medicinesFuture = _databaseService.getAllMedicines(widget.userId);
                  });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // الانتقال إلى شاشة إضافة دواء
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'التنبيهات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'التقارير',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'الإعدادات',
          ),
        ],
      ),
    );
  }
}
