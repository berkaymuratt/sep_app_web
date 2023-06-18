import 'package:flutter/material.dart';
import 'package:sep_app_web/app/shared/view_models/view_model_base.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/repositories/db/reports_repository.dart';

class AddFeedbackModalViewModel extends ViewModelBase {
  final ReportsRepository _reportsRepository = locator<ReportsRepository>();

  Future<bool> addDoctorFeedback(String reportId, String feedback) async {
    try {
      state = ViewState.BUSY;
      bool result = await _reportsRepository.addDoctorFeedback(reportId, feedback);
      return result;
    } catch (e) {
      debugPrint(e.toString());
      errorMsg = e.toString();
      return false;
    } finally {
      state = ViewState.IDLE;
    }
  }
}