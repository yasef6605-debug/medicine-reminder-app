/// خدمة التفاعلات الدوائية
class DrugInteractionService {
  static final DrugInteractionService _instance =
      DrugInteractionService._internal();
  late Map<String, List<String>> _interactionMap;

  factory DrugInteractionService() {
    return _instance;
  }

  DrugInteractionService._internal() {
    _initializeInteractionMap();
  }

  /// تهيئة خريطة التفاعلات
  void _initializeInteractionMap() {
    _interactionMap = {
      // أمثلة على التفاعلات الدوائية
      'أسبرين': ['وارفارين', 'إيبوبروفين', 'الكحول'],
      'الأيبوبروفين': ['أسبرين', 'وارفارين', 'كورتيزون'],
      'وارفارين': ['أسبرين', 'إيبوبروفين', 'فيتامين ك'],
      'فيتامين ك': ['وارفارين'],
      'الكحول': ['أسبرين', 'أدوية السكري', 'أدوية الكبد'],
      'أدوية السكري': ['الكحول', 'كورتيزون'],
      'كورتيزون': ['الأيبوبروفين', 'أدوية السكري'],
    };
  }

  /// التحقق من التفاعلات بين دواءين
  List<String> checkInteractions(String drug1, String drug2) {
    final interactions = <String>[];

    if (_interactionMap.containsKey(drug1)) {
      if (_interactionMap[drug1]!.contains(drug2)) {
        interactions.add('$drug1 يتفاعل مع $drug2');
      }
    }

    if (_interactionMap.containsKey(drug2)) {
      if (_interactionMap[drug2]!.contains(drug1)) {
        interactions.add('$drug2 يتفاعل مع $drug1');
      }
    }

    return interactions;
  }

  /// التحقق من التفاعلات مع قائمة أدوية
  List<String> checkInteractionsWithList(
      String newDrug, List<String> existingDrugs) {
    final allInteractions = <String>[];

    for (var drug in existingDrugs) {
      allInteractions.addAll(checkInteractions(newDrug, drug));
    }

    return allInteractions;
  }

  /// الحصول على وصف التفاعل
  String getInteractionDescription(String drug1, String drug2) {
    return 'هناك تفاعل محتمل بين $drug1 و $drug2. يرجى استشارة الطبيب.';
  }

  /// الحصول على التوصيات
  String getRecommendation(String drug1, String drug2) {
    return 'تجنب تناول $drug1 و $drug2 معاً أو راقب الأعراض بعناية واستشر الطبيب.';
  }

  /// إضافة تفاعل جديد
  void addInteraction(String drug1, String drug2) {
    if (!_interactionMap.containsKey(drug1)) {
      _interactionMap[drug1] = [];
    }
    if (!_interactionMap[drug1]!.contains(drug2)) {
      _interactionMap[drug1]!.add(drug2);
    }
  }
}
