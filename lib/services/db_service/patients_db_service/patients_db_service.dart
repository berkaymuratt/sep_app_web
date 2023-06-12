import 'package:dio/dio.dart';
import 'package:sep_app_web/jwt_manager.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/users/patient_model.dart';
import 'package:sep_app_web/services/db_service/patients_db_service/patients_db_service_base.dart';

class PatientsDbService extends PatientsDbServiceBase {
  final Dio dio = Dio();
  final jwtManager = locator<JwtManager>();

  @override
  Future<PatientModel> getPatient(String patientId) async {
    try {
      final response = await dio.get(
        'http://localhost:8080/api/patients/$patientId',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'jwt': locator<JwtManager>().jwtToken,
          },
        ),
      );

      return PatientModel.fromJSON(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception("Bir hata oluştu");
      }
    }
  }

  @override
  Future<List<PatientModel>> getPatientsByDoctorId(String doctorId) async {
    try {
      final response = await dio.get('http://localhost:8080/api/patients',
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'jwt': locator<JwtManager>().jwtToken,
            },
          ),
          queryParameters: {
            "doctor_id": doctorId,
          });

      List<PatientModel> patients = [];

      for (Map<String, dynamic> patientJSON in response.data['patients']) {
        patients.add(PatientModel.fromJSON(patientJSON));
      }

      return patients;
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception("Bir hata oluştu");
      }
    }
  }
}
