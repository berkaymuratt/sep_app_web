import 'package:sep_app_web/models/symptom_model.dart';

abstract class SymptomsDbServiceBase {
  Future<List<SymptomModel>> getSymptoms(String bodyPartId);
}