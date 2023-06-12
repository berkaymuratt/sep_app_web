import 'package:dio/dio.dart';
import 'package:sep_app_web/jwt_manager.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/report_model.dart';
import 'package:sep_app_web/services/db_service/reports_db_service/reports_db_service_base.dart';

class ReportsDbService extends ReportsDbServiceBase {

  final Dio dio = Dio();

  @override
  Future<ReportModel> getReport(String reportId) async {
    try {
      final response = await dio.get(
        'http://localhost:8080/api/reports/$reportId',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'jwt': locator<JwtManager>().jwtToken,
          },
        ),
      );

      return ReportModel.fromJSON(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          locator<JwtManager>().clearToken();
        }
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception("Bir hata oluştu");
      }
    }
  }

  @override
  Future<List<ReportModel>> getReportsByDoctorId(String doctorId) async {
    try {
      final response = await dio.get(
          'http://localhost:8080/api/reports',
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'jwt': locator<JwtManager>().jwtToken,
            },
          ),
          queryParameters: {"doctor_id": doctorId}
      );

      List<ReportModel> reports = [];

      var reportsList = response.data['reports'];

      if (reportsList == null) {
        return [];
      }

      for (Map<String, dynamic> reportJson in reportsList) {
        reports.add(ReportModel.fromJSON(reportJson));
      }
      return reports;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          locator<JwtManager>().clearToken();
        }
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception("Bir hata oluştu");
      }
    }
  }

  @override
  Future<List<ReportModel>> getReportsByPatientId(String patientId) async {
    try {
      final response = await dio.get(
        'http://localhost:8080/api/reports',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'jwt': locator<JwtManager>().jwtToken,
          },
        ),
        queryParameters: {"patient_id": patientId}
      );

      List<ReportModel> reports = [];

      var reportsList = response.data['reports'];

      if (reportsList == null) {
        return [];
      }

      for (Map<String, dynamic> reportJson in reportsList) {
        reports.add(ReportModel.fromJSON(reportJson));
      }
      return reports;
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.statusCode == 401) {
          locator<JwtManager>().clearToken();
        }
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception("Bir hata oluştu");
      }
    }
  }

  @override
  Future<bool> updateReport(String reportId, ReportModel updatedVersion) {
    // TODO: implement updateReport
    throw UnimplementedError();
  }
}
