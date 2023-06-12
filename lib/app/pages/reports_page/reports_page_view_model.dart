import 'package:flutter/material.dart';
import 'package:sep_app_web/app/shared/view_models/view_model_base.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/report_model.dart';
import 'package:sep_app_web/repositories/db/reports_repository.dart';

class ReportsPageViewModel extends ViewModelBase {
  final ReportsRepository _reportsRepository = locator<ReportsRepository>();

  List<ReportModel>? reports = [];

  Future<List<ReportModel>?> getReportsByDoctorId(String doctorId) async {
    try {
      state = ViewState.BUSY;
      reports = await _reportsRepository.getReportsByDoctorId(doctorId);
      return reports;
    } catch (e) {
      reports = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  bool get isStateLoading => super.isStateLoading || reports == null;
}