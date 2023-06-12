import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sep_app_web/app/pages/doctor_info_page/doctor_info_page_view_model.dart';
import 'package:sep_app_web/app/pages/doctor_info_page/widgets/doctor_info_card.dart';
import 'package:sep_app_web/app/shared/sep_app_bar_links.dart';
import 'package:sep_app_web/app/shared/view_models/auth_view_model.dart';
import 'package:sep_app_web/app/shared/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app_web/app/shared/widgets/sep_loader/sep_loader.dart';
import 'package:sep_app_web/locator.dart';

class DoctorInfoPage extends StatefulWidget {
  const DoctorInfoPage({Key? key}) : super(key: key);

  @override
  State<DoctorInfoPage> createState() => _DoctorInfoPageState();
}

class _DoctorInfoPageState extends State<DoctorInfoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var currentDoctor = context.read<AuthViewModel>().doctorUser!;
    });
  }

  @override
  Widget build(BuildContext context) {
    locator<SepAppBarState>().activeLink = null;
    var doctorInfoPageViewModel = context.watch<DoctorInfoPageViewModel>();

    return SepAppScaffold(
      child: doctorInfoPageViewModel.isStateLoading
          ? const Center(child: SepLoader())
          : DoctorInfoCard(doctor: doctorInfoPageViewModel.doctor!),
    );
  }
}
