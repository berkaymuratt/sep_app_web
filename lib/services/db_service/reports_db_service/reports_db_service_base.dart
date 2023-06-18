import 'package:sep_app_web/models/report_model.dart';

abstract class ReportsDbServiceBase {
  Future<List<ReportModel>> getReportsByPatientId(String patientId);
  Future<List<ReportModel>> getReportsByDoctorId(String doctorId);
  Future<ReportModel> getReport(String reportId);
  Future<bool> updateReport(String reportId, ReportModel updatedVersion);
  Future<bool> addDoctorFeedback(String reportId, String feedback);
}
