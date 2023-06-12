import 'package:dio/dio.dart';
import 'package:sep_app_web/jwt_manager.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/users/doctor_model.dart';
import 'package:sep_app_web/models/users/patient_model.dart';
import 'package:sep_app_web/services/auth_service/auth_service_base.dart';

class AuthService extends AuthServiceBase {
  final Dio dio = Dio();
  final jwtManager = locator<JwtManager>();

  @override
  Future<DoctorModel> loginAsDoctor(String userId, String password) async {
    try {
      final response =
          await dio.post('http://localhost:8080/api/auth/login-as-doctor',
              options: Options(
                headers: {
                  'Content-Type': 'application/json; charset=UTF-8',
                },
              ),
              queryParameters: {
            "user_id": userId,
            "user_password": password,
          });

      var token = response.data['sep-token'];
      jwtManager.setJwtToken(token);

      return DoctorModel.fromJSON(response.data['doctor']);
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception("Bir hata oluştu");
      }
    }
  }

  @override
  Future<PatientModel> loginAsPatient(String userId, String password) async {
    try {
      final response =
          await dio.post('http://localhost:8080/api/auth/login-as-patient',
              options: Options(
                headers: {
                  'Content-Type': 'application/json; charset=UTF-8',
                },
              ),
              queryParameters: {
            "user_id": userId,
            "user_password": password,
          });

      var token = response.data['sep-token'];
      jwtManager.setJwtToken(token);

      return PatientModel.fromJSON(response.data['patient']);
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception("Bir hata oluştu");
      }
    }
  }

  @override
  Future<void> signOut() async {
    jwtManager.clearToken();
  }

  @override
  Future<DoctorModel> getCurrentUser() async {
    try {
      final response = await dio.get(
        'http://localhost:8080/api/auth/current-doctor-user',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            "jwt": jwtManager.jwtToken,
          },
        ),
      );
      return DoctorModel.fromJSON(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        throw Exception(e.response!.data['message']);
      } else {
        throw Exception("Bir hata oluştu");
      }
    }
  }
}
