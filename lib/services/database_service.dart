import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/medicine.dart';
import '../models/reminder.dart';
import '../models/user_profile.dart';
import '../models/drug_interaction.dart';
import '../models/health_record.dart';

/// خدمة قاعدة البيانات الرئيسية
class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  /// الحصول على قاعدة البيانات
  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  /// تهيئة قاعدة البيانات
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'medicine_reminder.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  /// إنشاء جداول قاعدة البيانات
  Future<void> _createTables(Database db, int version) async {
    // جدول الملفات الشخصية
    await db.execute('''
      CREATE TABLE user_profiles (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        age INTEGER NOT NULL,
        gender TEXT NOT NULL,
        phoneNumber TEXT,
        medicalHistory TEXT,
        allergies TEXT,
        chronicDiseases TEXT,
        createdDate TEXT NOT NULL,
        profileImage TEXT,
        isPrimary INTEGER DEFAULT 0,
        notes TEXT
      )
    ''');

    // جدول الأدوية
    await db.execute('''
      CREATE TABLE medicines (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        form TEXT NOT NULL,
        dosage REAL NOT NULL,
        dosageUnit TEXT NOT NULL,
        timesPerDay TEXT NOT NULL,
        timing TEXT NOT NULL,
        sideEffects TEXT,
        contraindications TEXT,
        usage TEXT,
        stock INTEGER NOT NULL,
        expiryDate TEXT,
        userId TEXT NOT NULL,
        addedDate TEXT NOT NULL,
        isActive INTEGER DEFAULT 1,
        notes TEXT,
        barcode TEXT,
        costPerUnit REAL
      )
    ''');

    // جدول التنبيهات
    await db.execute('''
      CREATE TABLE reminders (
        id TEXT PRIMARY KEY,
        medicineId TEXT NOT NULL,
        time TEXT NOT NULL,
        daysOfWeek TEXT NOT NULL,
        isActive INTEGER DEFAULT 1,
        hasNotification INTEGER DEFAULT 1,
        userId TEXT NOT NULL,
        createdDate TEXT NOT NULL,
        notes TEXT,
        takeTaken INTEGER DEFAULT 0,
        lastTakenTime TEXT,
        FOREIGN KEY(medicineId) REFERENCES medicines(id)
      )
    ''');

    // جدول التفاعلات الدوائية
    await db.execute('''
      CREATE TABLE drug_interactions (
        id TEXT PRIMARY KEY,
        drug1 TEXT NOT NULL,
        drug2 TEXT NOT NULL,
        severityLevel TEXT NOT NULL,
        description TEXT NOT NULL,
        effects TEXT,
        recommendation TEXT,
        createdDate TEXT NOT NULL
      )
    ''');

    // جدول السجلات الصحية
    await db.execute('''
      CREATE TABLE health_records (
        id TEXT PRIMARY KEY,
        userId TEXT NOT NULL,
        date TEXT NOT NULL,
        symptoms TEXT,
        notes TEXT,
        bloodPressure REAL,
        bloodSugar REAL,
        temperature REAL,
        weight REAL,
        mood TEXT,
        medicinesTaken TEXT,
        doctorNotes TEXT,
        labReports TEXT
      )
    ''');
  }

  /// إضافة دواء
  Future<int> addMedicine(Medicine medicine) async {
    final db = await database;
    return await db.insert('medicines', medicine.toMap());
  }

  /// الحصول على جميع الأدوية
  Future<List<Medicine>> getAllMedicines(String userId) async {
    final db = await database;
    final result = await db.query(
      'medicines',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return result.map((e) => Medicine.fromMap(e)).toList();
  }

  /// تحديث دواء
  Future<int> updateMedicine(Medicine medicine) async {
    final db = await database;
    return await db.update(
      'medicines',
      medicine.toMap(),
      where: 'id = ?',
      whereArgs: [medicine.id],
    );
  }

  /// حذف دواء
  Future<int> deleteMedicine(String medicineId) async {
    final db = await database;
    return await db.delete(
      'medicines',
      where: 'id = ?',
      whereArgs: [medicineId],
    );
  }

  /// إضافة تنبيه
  Future<int> addReminder(Reminder reminder) async {
    final db = await database;
    return await db.insert('reminders', reminder.toMap());
  }

  /// الحصول على جميع التنبيهات
  Future<List<Reminder>> getAllReminders(String userId) async {
    final db = await database;
    final result = await db.query(
      'reminders',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return result.map((e) => Reminder.fromMap(e)).toList();
  }

  /// تحديث تنبيه
  Future<int> updateReminder(Reminder reminder) async {
    final db = await database;
    return await db.update(
      'reminders',
      reminder.toMap(),
      where: 'id = ?',
      whereArgs: [reminder.id],
    );
  }

  /// حذف تنبيه
  Future<int> deleteReminder(String reminderId) async {
    final db = await database;
    return await db.delete(
      'reminders',
      where: 'id = ?',
      whereArgs: [reminderId],
    );
  }

  /// إضافة ملف مستخدم
  Future<int> addUserProfile(UserProfile profile) async {
    final db = await database;
    return await db.insert('user_profiles', profile.toMap());
  }

  /// الحصول على جميع ملفات المستخدم
  Future<List<UserProfile>> getAllUserProfiles() async {
    final db = await database;
    final result = await db.query('user_profiles');
    return result.map((e) => UserProfile.fromMap(e)).toList();
  }

  /// تحديث ملف مستخدم
  Future<int> updateUserProfile(UserProfile profile) async {
    final db = await database;
    return await db.update(
      'user_profiles',
      profile.toMap(),
      where: 'id = ?',
      whereArgs: [profile.id],
    );
  }

  /// حذف ملف مستخدم
  Future<int> deleteUserProfile(String profileId) async {
    final db = await database;
    return await db.delete(
      'user_profiles',
      where: 'id = ?',
      whereArgs: [profileId],
    );
  }

  /// إضافة سجل صحي
  Future<int> addHealthRecord(HealthRecord record) async {
    final db = await database;
    return await db.insert('health_records', record.toMap());
  }

  /// الحصول على السجلات الصحية
  Future<List<HealthRecord>> getHealthRecords(String userId) async {
    final db = await database;
    final result = await db.query(
      'health_records',
      where: 'userId = ?',
      whereArgs: [userId],
    );
    return result.map((e) => HealthRecord.fromMap(e)).toList();
  }

  /// إغلاق قاعدة البيانات
  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
