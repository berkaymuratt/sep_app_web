import 'package:sep_app_web/models/users/doctor_model.dart';

abstract class DoctorsDbServiceBase {
  Future<DoctorModel> getDoctor(String doctorId);
  Future<DoctorModel> getDoctorByPatientId(String patientId);
  Future<bool> updateDoctor(String doctorId, DoctorModel updatedVersion);
  Future<List<DateTime>> getBusyTimes(String doctorId, DateTime newDate);
}