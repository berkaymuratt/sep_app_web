import 'package:dio/dio.dart';
import 'package:sep_app_web/jwt_manager.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/appointment_model.dart';
import 'package:sep_app_web/services/db_service/appointments_db_service/appointments_db_service_base.dart';

class AppointmentDbService extends AppointmentsDbServiceBase {
  Dio dio = Dio();

  @override
  Future<AppointmentModel> getAppointment(String appointmentId) async {
    try {
      final response = await dio.get(
        'http://localhost:8080/api/appointments/$appointmentId',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'jwt': locator<JwtManager>().jwtToken,
          },
        ),
      );

      return AppointmentModel.fromJSON(response.data);
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
  Future<List<AppointmentModel>> getAppointmentsByDoctorId(String doctorId) async {
    try {
      final response = await dio.get('http://localhost:8080/api/appointments',
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'jwt': locator<JwtManager>().jwtToken,
            },
          ),
          queryParameters: {
            "doctor_id": doctorId,
          });

      List<AppointmentModel> appointments = [];

      var appointmentsList = response.data['appointments'];

      if (appointmentsList == null) {
        return [];
      }

      for (Map<String, dynamic> appointmentJson in appointmentsList) {
        appointments.add(AppointmentModel.fromJSON(appointmentJson));
      }

      return appointments;
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
  Future<List<AppointmentModel>> getAppointmentsByPatientId(
      String patientId) async {
    try {
      final response = await dio.get('http://localhost:8080/api/appointments',
          options: Options(
            headers: {
              'Content-Type': 'application/json; charset=UTF-8',
              'jwt': locator<JwtManager>().jwtToken,
            },
          ),
          queryParameters: {
            "patient_id": patientId,
          });

      List<AppointmentModel> appointments = [];

      var appointmentsList = response.data['appointments'];

      if (appointmentsList == null) {
        return [];
      }

      for (Map<String, dynamic> appointmentJson in appointmentsList) {
        appointments.add(AppointmentModel.fromJSON(appointmentJson));
      }

      return appointments;
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
  Future<bool> createAppointment(AppointmentModel appointment) async {
    try {
      final response = await dio.post(
        'http://localhost:8080/api/appointments/',
        options: Options(
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'jwt': locator<JwtManager>().jwtToken,
          },
        ),
        data: appointment.toJSON(),
      );

      return response.statusCode == 201;
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
}
