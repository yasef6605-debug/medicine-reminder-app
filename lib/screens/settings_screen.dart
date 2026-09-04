import 'package:flutter/material.dart';
import '../utils/colors.dart';

/// شاشة الإعدادات
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _notificationsEnabled = true;
  String _language = 'Arabic';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('⚙️ الإعدادات'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // الإعدادات العامة
            _buildSectionTitle('الإعدادات العامة'),
            _buildSwitchTile(
              title: 'الوضع المظلم',
              value: _darkMode,
              onChanged: (value) {
                setState(() => _darkMode = value);
              },
            ),
            _buildSwitchTile(
              title: 'تفعيل التنبيهات',
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() => _notificationsEnabled = value);
              },
            ),
            const Divider(),

            // اللغة والمنطقة
            _buildSectionTitle('اللغة والمنطقة'),
            _buildListTile(
              title: 'اللغة',
              value: _language,
              onTap: () => _showLanguageDialog(),
            ),
            const Divider(),

            // الخصوصية والأمان
            _buildSectionTitle('الخصوصية والأمان'),
            _buildListTile(
              title: 'قفل التطبيق برمز',
              subtitle: 'حماية بيانات التطبيق',
              onTap: () {},
            ),
            _buildListTile(
              title: 'مسح البيانات',
              subtitle: 'حذف جميع البيانات المحفوظة',
              onTap: () => _showDeleteDataDialog(),
            ),
            const Divider(),

            // حول التطبيق
            _buildSectionTitle('حول التطبيق'),
            _buildListTile(
              title: 'إصدار التطبيق',
              value: 'v1.0.0',
            ),
            _buildListTile(
              title: 'عن التطبيق',
              onTap: () => _showAboutDialog(),
            ),
            _buildListTile(
              title: 'سياسة الخصوصية',
              onTap: () {},
            ),
            _buildListTile(
              title: 'شروط الخدمة',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    String? subtitle,
    String? value,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: value != null ? Text(value) : const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('اختر اللغة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('العربية'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: const Text('English'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDataDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تحذير'),
        content: const Text('هل أنت متأكد من حذف جميع البيانات؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('عن التطبيق'),
        content: const Text(
          'تطبيق إدارة الأدوية الذكي\n\n'
          'يساعدك على تتبع الأدوية وتنظيم مواعيد التناول مع تنبيهات ذكية.\n\n'
          'تم تطويره بواسطة فريق متخصص.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }
}
