import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/users/doctor_model.dart';
import 'package:sep_app_web/services/db_service/doctors_db_service/doctors_db_service.dart';
import 'package:sep_app_web/services/db_service/doctors_db_service/doctors_db_service_base.dart';

class DoctorsRepository extends DoctorsDbServiceBase {

  final DoctorsDbServiceBase _service = locator<DoctorsDbService>();

  @override
  Future<DoctorModel> getDoctor(String doctorId) {
    return _service.getDoctor(doctorId);
  }

  @override
  Future<DoctorModel> getDoctorByPatientId(String patientId) {
    return _service.getDoctorByPatientId(patientId);
  }

  @override
  Future<bool> updateDoctor(String doctorId, DoctorModel updatedVersion) {
    return _service.updateDoctor(doctorId, updatedVersion);
  }

  @override
  Future<List<DateTime>> getBusyTimes(String doctorId, DateTime newDate) {
    return _service.getBusyTimes(doctorId, newDate);
  }

}