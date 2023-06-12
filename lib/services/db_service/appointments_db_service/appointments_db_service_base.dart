import 'package:sep_app_web/models/appointment_model.dart';

abstract class AppointmentsDbServiceBase {
  Future<AppointmentModel> getAppointment(String appointmentId);
  Future<List<AppointmentModel>> getAppointmentsByPatientId(String patientId);
  Future<List<AppointmentModel>> getAppointmentsByDoctorId(String doctorId);
  Future<bool> createAppointment(AppointmentModel appointment);
}
