import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sep_app_web/app/pages/appointments_page/appointments_page_view_model.dart';
import 'package:sep_app_web/app/pages/appointments_page/widgets/appointments_table.dart';
import 'package:sep_app_web/app/shared/sep_app_bar_links.dart';
import 'package:sep_app_web/app/shared/view_models/auth_view_model.dart';
import 'package:sep_app_web/app/shared/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app_web/app/shared/widgets/sep_divider/sep_divider.dart';
import 'package:sep_app_web/app/shared/widgets/sep_loader/sep_loader.dart';
import 'package:sep_app_web/locator.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({Key? key}) : super(key: key);

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var currentDoctor = context.read<AuthViewModel>().doctorUser!;
      context
          .read<AppointmentsPageViewModel>()
          .getAppointments(currentDoctor.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    locator<SepAppBarState>().activeLink = SepAppBarLinks.APPOINTMENTS;
    final AppointmentsPageViewModel viewModel =
        context.watch<AppointmentsPageViewModel>();

    return SepAppScaffold(
      child: viewModel.isStateLoading
          ? const Center(child: SepLoader())
          : ListView(
              children: [
                _title,
                Container(
                  margin: const EdgeInsets.all(20.0),
                  child: const AppointmentsTable(),
                ),
              ],
            ),
    );
  }

  Widget get _title {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 20),
      child: const Column(
        children: [
          Row(
            children: [
              SizedBox(width: 3),
              FaIcon(FontAwesomeIcons.calendarCheck),
              SizedBox(width: 8),
              Text(
                "Güncel Randevularınız",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              SepDivider(height: 2, width: 250),
            ],
          ),
        ],
      ),
    );
  }
}
