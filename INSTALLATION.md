# 📖 دليل التثبيت والإعداد

## المتطلبات

### البرامج المطلوب تثبيتها:

1. **Flutter SDK**
   - [تحميل Flutter](https://flutter.dev/docs/get-started/install)
   - الإصدار المطلوب: 3.0.0 أو أحدث

2. **Dart SDK** (يتم تثبيته مع Flutter تلقائياً)
   - الإصدار المطلوب: 3.0.0 أو أحدث

3. **Android Studio** أو **Xcode** (للتطوير)
   - Android Studio للتطوير على Android
   - Xcode للتطوير على iOS

4. **Git**
   - [تحميل Git](https://git-scm.com/)

### متطلبات النظام:
- Windows 10+ أو macOS 10.13+ أو Linux
- 4GB RAM على الأقل
- مساحة 5GB على الأقل

## خطوات التثبيت

### 1. استنساخ المستودع

```bash
git clone https://github.com/yasef6605-debug/medicine-reminder-app.git
cd medicine-reminder-app
```

### 2. تثبيت المكتبات

```bash
flutter clean
flutter pub get
```

### 3. التحقق من التثبيت

```bash
flutter doctor
```

### 4. تشغيل التطبيق

#### على محاكي Android:

```bash
flutter run
```

#### على جهاز فعلي:

```bash
# تفعيل وضع تطوير USB على الجهاز
flutter devices  # للتحقق من الأجهزة المتصلة
flutter run -d <device-id>
```

#### على iOS:

```bash
# على macOS فقط
flutter run
```

## إعدادات إضافية

### تفعيل الإشعارات

#### Android:

1. افتح `android/app/build.gradle`
2. تأكد من أن `targetSdkVersion` >= 31

#### iOS:

1. افتح `ios/Runner.xcworkspace` في Xcode
2. اذهب إلى Project > Runner > Signing & Capabilities
3. أضف capability جديد: "Push Notifications"

### تفعيل الكاميرا لمسح الباركود

#### Android:

أضف الصلاحيات في `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.CAMERA" />
```

#### iOS:

أضف في `ios/Runner/Info.plist`:

```xml
<key>NSCameraUsageDescription</key>
<string>تحتاج الكاميرا لمسح باركود الأدوية</string>
```

### تفعيل الهز (Vibration)

#### Android:

أضف في `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.VIBRATE" />
```

## استكشاف الأخطاء الشائعة

### المشكلة: "flutter command not found"

**الحل:**
```bash
# أضف Flutter إلى PATH
export PATH="$PATH:`pwd`/flutter/bin"
```

### المشكلة: "No connected devices"

**الحل:**
```bash
# تفعيل وضع Developer على الهاتف
# ثم تفعيل USB Debugging
flutter devices
```

### المشكلة: خطأ في المكتبات

**الحل:**
```bash
flutter clean
flutter pub cache clean
flutter pub get
```

### المشكلة: خطأ في البناء على iOS

**الحل:**
```bash
cd ios
rm -rf Pods
rm -rf Podfile.lock
pod install
cd ..
flutter run
```

## بناء التطبيق للإصدار

### Android:

```bash
flutter build apk --release
# أو لإنشاء App Bundle:
flutter build appbundle --release
```

### iOS:

```bash
flutter build ios --release
```

## التطوير والاختبار

### تشغيل الاختبارات:

```bash
flutter test
```

### تحليل الكود:

```bash
flutter analyze
```

### تنسيق الكو��:

```bash
dart format lib/
```

## معلومات إضافية

- 📱 **الهاتف المدعوم**: iOS 11.0+ و Android 6.0+
- 🌍 **اللغات المدعومة**: العربية، الإنجليزية
- 📦 **حجم التطبيق**: ~50MB (تقريباً)
- 💾 **مساحة التخزين المطلوبة**: ~10MB للبيانات

## الدعم والمساعدة

إذا واجهت مشاكل:

1. تحقق من [قائمة الأسئلة الشائعة](https://github.com/yasef6605-debug/medicine-reminder-app/wiki/FAQ)
2. ابحث في [Issues](https://github.com/yasef6605-debug/medicine-reminder-app/issues)
3. أنشئ [Issue جديد](https://github.com/yasef6605-debug/medicine-reminder-app/issues/new)

---

**آخر تحديث:** 4 سبتمبر 2026
