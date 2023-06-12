import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/users/patient_model.dart';
import 'package:sep_app_web/services/db_service/patients_db_service/patients_db_service.dart';
import 'package:sep_app_web/services/db_service/patients_db_service/patients_db_service_base.dart';

class PatientsRepository extends PatientsDbServiceBase {

  final PatientsDbService _service = locator<PatientsDbService>();

  @override
  Future<PatientModel> getPatient(String patientId) {
    return _service.getPatient(patientId);
  }

  @override
  Future<List<PatientModel>> getPatientsByDoctorId(String doctorId) {
    return _service.getPatientsByDoctorId(doctorId);
  }
}