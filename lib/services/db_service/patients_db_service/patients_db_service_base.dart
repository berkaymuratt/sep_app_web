import 'package:sep_app_web/models/users/patient_model.dart';

abstract class PatientsDbServiceBase {
  Future<PatientModel> getPatient(String patientId);
  Future<List<PatientModel>> getPatientsByDoctorId(String doctorId);
}