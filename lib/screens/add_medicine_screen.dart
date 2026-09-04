import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/medicine.dart';
import '../services/database_service.dart';
import '../services/drug_interaction_service.dart';
import '../widgets/custom_input.dart';
import '../widgets/custom_button.dart';
import '../utils/constants.dart';
import '../utils/colors.dart';

/// شاشة إضافة دواء
class AddMedicineScreen extends StatefulWidget {
  final String userId;
  final Medicine? existingMedicines;

  const AddMedicineScreen({
    Key? key,
    required this.userId,
    this.existingMedicines,
  }) : super(key: key);

  @override
  State<AddMedicineScreen> createState() => _AddMedicineScreenState();
}

class _AddMedicineScreenState extends State<AddMedicineScreen> {
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _notesController = TextEditingController();
  final _stockController = TextEditingController();
  final _barcodeController = TextEditingController();
  final _costController = TextEditingController();

  late DatabaseService _databaseService;
  late DrugInteractionService _interactionService;

  String? _selectedType;
  String? _selectedForm;
  String? _selectedTiming;
  List<String> _selectedDays = [];
  DateTime? _expiryDate;

  @override
  void initState() {
    super.initState();
    _databaseService = DatabaseService();
    _interactionService = DrugInteractionService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إضافة دواء'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // اسم الدواء
            CustomInput(
              label: 'اسم الدواء',
              hint: 'أدخل اسم الدواء',
              controller: _nameController,
              prefixIcon: Icons.medical_information,
            ),
            const SizedBox(height: 16),

            // نوع الدواء
            const Text(
              'نوع الدواء',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedType,
              items: AppConstants.medicineTypes
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedType = value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),

            // شكل الدواء
            const Text(
              'شكل الدواء',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedForm,
              items: AppConstants.medicineForms
                  .map((form) => DropdownMenuItem(
                        value: form,
                        child: Text(form),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedForm = value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),

            // الجرعة
            CustomInput(
              label: 'الجرعة',
              hint: 'أدخل الجرعة',
              controller: _dosageController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // المخزون
            CustomInput(
              label: 'المخزون (عدد الأقراص)',
              hint: 'أدخل عدد الأقراص',
              controller: _stockController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // التوقيت
            const Text(
              'التوقيت بالنسبة للطعام',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedTiming,
              items: AppConstants.mealTimings
                  .map((timing) => DropdownMenuItem(
                        value: timing,
                        child: Text(timing),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => _selectedTiming = value);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),

            // تاريخ الانتهاء
            const Text(
              'تاريخ الانتهاء',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  setState(() => _expiryDate = date);
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _expiryDate != null
                      ? '${_expiryDate!.day}/${_expiryDate!.month}/${_expiryDate!.year}'
                      : 'اختر التاريخ',
                ),
              ),
            ),
            const SizedBox(height: 16),

            // الملاحظات
            CustomInput(
              label: 'ملاحظات',
              hint: 'أضف ملاحظات إضافية',
              controller: _notesController,
              maxLines: 3,
            ),
            const SizedBox(height: 24),

            // زر الإضافة
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'إضافة الدواء',
                onPressed: () => _addMedicine(),
                backgroundColor: AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addMedicine() async {
    if (_nameController.text.isEmpty ||
        _selectedType == null ||
        _selectedForm == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('الرجاء ملء جميع الحقول المطلوبة')),
      );
      return;
    }

    final medicine = Medicine(
      id: const Uuid().v4(),
      name: _nameController.text,
      type: _selectedType!,
      form: _selectedForm!,
      dosage: double.parse(_dosageController.text),
      dosageUnit: 'حبة',
      timesPerDay: ['صباحاً'],
      timing: _selectedTiming ?? 'مع الطعام',
      stock: int.parse(_stockController.text),
      userId: widget.userId,
      addedDate: DateTime.now(),
      expiryDate: _expiryDate,
      notes: _notesController.text,
    );

    await _databaseService.addMedicine(medicine);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ تم إضافة الدواء بنجاح')),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _notesController.dispose();
    _stockController.dispose();
    _barcodeController.dispose();
    _costController.dispose();
    super.dispose();
  }
}
