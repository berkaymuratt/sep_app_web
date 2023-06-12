import 'package:flutter/material.dart';
import 'package:sep_app_web/app/shared/view_models/view_model_base.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/users/patient_model.dart';
import 'package:sep_app_web/repositories/db/patients_repository.dart';

class PatientsPageViewModel extends ViewModelBase {
  final PatientsRepository _patientsRepository = locator<PatientsRepository>();

  List<PatientModel>? patients;
  Future<List<PatientModel>?> getPatients(String doctorId) async {
    try {
      state = ViewState.BUSY;
      patients = await _patientsRepository.getPatientsByDoctorId(doctorId);
      return patients;
    } catch (e) {
      patients = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  bool get isStateLoading => patients == null || super.isStateLoading;
}