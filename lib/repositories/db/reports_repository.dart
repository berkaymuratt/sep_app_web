import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/report_model.dart';
import 'package:sep_app_web/services/db_service/reports_db_service/reports_db_service.dart';
import 'package:sep_app_web/services/db_service/reports_db_service/reports_db_service_base.dart';

class ReportsRepository extends ReportsDbServiceBase {
  final _service = locator<ReportsDbService>();

  @override
  Future<ReportModel> getReport(String reportId) {
    return _service.getReport(reportId);
  }

  @override
  Future<List<ReportModel>> getReportsByDoctorId(String doctorId) {
    return _service.getReportsByDoctorId(doctorId);
  }

  @override
  Future<List<ReportModel>> getReportsByPatientId(String patientId) {
    return _service.getReportsByPatientId(patientId);
  }

  @override
  Future<bool> updateReport(String reportId, ReportModel updatedVersion) {
    return _service.updateReport(reportId, updatedVersion);
  }

  @override
  Future<bool> addDoctorFeedback(String reportId, String feedback) {
    return _service.addDoctorFeedback(reportId, feedback);
  }
}
