import 'package:flutter/material.dart';
import 'package:sep_app_web/app/shared/view_models/view_model_base.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/report_model.dart';
import 'package:sep_app_web/repositories/db/reports_repository.dart';

class ReportDetailsPageViewModel extends ViewModelBase {
  final ReportsRepository _reportsRepository = locator<ReportsRepository>();

  ReportModel? report;

  Future<ReportModel?> getReport(String reportId) async {
    try {
      state = ViewState.BUSY;
      report = await _reportsRepository.getReport(reportId);
      return report;
    } catch(e) {
      report = null;
      debugPrint(e.toString());
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  @override
  bool get isStateLoading => report == null || super.isStateLoading;
}