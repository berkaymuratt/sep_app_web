import 'package:flutter/material.dart';
import 'package:sep_app_web/app/shared/view_models/view_model_base.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/appointment_model.dart';
import 'package:sep_app_web/repositories/db/appointments_repository.dart';

class AppointmentDetailsPageViewModel extends ViewModelBase {
  final AppointmentsRepository _appointmentsRepository = locator<AppointmentsRepository>();

  AppointmentModel? appointment;

  Future<AppointmentModel?> getAppointment(String appointmentId) async {
    try {
      state = ViewState.BUSY;
      appointment = await _appointmentsRepository.getAppointment(appointmentId);
      return appointment;
    } catch (e) {
      appointment = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  bool get isStateLoading =>  appointment == null || super.isStateLoading;
}