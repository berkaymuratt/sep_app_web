import 'package:flutter/material.dart';
import 'package:sep_app_web/app/shared/view_models/view_model_base.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/appointment_model.dart';
import 'package:sep_app_web/repositories/db/appointments_repository.dart';

class AppointmentsPageViewModel extends ViewModelBase {
  final AppointmentsRepository _appointmentsRepository = locator<AppointmentsRepository>();

  List<AppointmentModel>? appointments;

  Future<List<AppointmentModel>?> getAppointments(String doctorId) async {
    try {
      state = ViewState.BUSY;
      appointments = await _appointmentsRepository.getAppointmentsByDoctorId(doctorId);
      return appointments;
    } catch (e) {
      appointments = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  bool get isStateLoading => appointments == null || super.isStateLoading;
}