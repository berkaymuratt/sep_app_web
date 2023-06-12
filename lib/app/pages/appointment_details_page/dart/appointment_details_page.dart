import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sep_app_web/app/pages/appointment_details_page/dart/appointment_details_page_view_model.dart';
import 'package:sep_app_web/app/pages/appointment_details_page/dart/widgets/info_card.dart';
import 'package:sep_app_web/app/pages/report_details_page/dart/report_details_page.dart';
import 'package:sep_app_web/app/pages/report_details_page/dart/report_details_page_view_model.dart';
import 'package:sep_app_web/app/shared/sep_app_bar_links.dart';
import 'package:sep_app_web/app/shared/sep_colors.dart';
import 'package:sep_app_web/app/shared/sep_app_scaffold/sep_app_scaffold.dart';
import 'package:sep_app_web/app/shared/widgets/sep_divider/sep_divider.dart';
import 'package:sep_app_web/app/shared/widgets/sep_loader/sep_loader.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/appointment_model.dart';
import 'package:sep_app_web/models/symptom_model.dart';

class AppointmentDetailsPage extends StatefulWidget {
  final String appointmentId;

  const AppointmentDetailsPage({Key? key, required this.appointmentId})
      : super(key: key);

  @override
  State<AppointmentDetailsPage> createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {

  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
  final DateFormat timeFormatter = DateFormat('HH:mm');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<AppointmentDetailsPageViewModel>()
          .getAppointment(widget.appointmentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    locator<SepAppBarState>().activeLink = SepAppBarLinks.APPOINTMENTS;
    final viewModel = context.watch<AppointmentDetailsPageViewModel>();

    if (viewModel.isStateLoading) {
      return const SepAppScaffold(
        child: Center(
          child: SepLoader(),
        ),
      );
    } else {
      var appointment = viewModel.appointment!;

      return SepAppScaffold(
        child: ListView(
          children: [
            const SizedBox(height: 5.0),
            _title,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: _cards(appointment),
              ),
            ),
            _displayReportButton(context, appointment.reportId),
          ],
        ),
      );
    }
  }

  Padding get _title {
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              FaIcon(FontAwesomeIcons.calendarDays, size: 15),
              SizedBox(width: 10),
              Text(
                "Randevu Detayları",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: "SignikaFont",
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SepDivider(height: 1.5, width: 280),
        ],
      ),
    );
  }

  List<Widget> _cards(AppointmentModel appointment) {
    return [
      _patientInfoCard(appointment),
      _doctorInfoCard(appointment),
      _timeInfoCard(appointment),
      _symptomInfoCard(appointment),
      _patientNoteCard(appointment),
    ];
  }

  InfoCard _patientNoteCard(AppointmentModel appointment) {
    return InfoCard(
      title: "Hastanın Notu",
      icon: FontAwesomeIcons.notesMedical,
      items: [
        InfoCardItem(name: "Not", value: appointment.patientNote)
      ],
    );
  }

  InfoCard _symptomInfoCard(AppointmentModel appointment) {
    return InfoCard(
      title: "Semptom Bilgisi",
      icon: FontAwesomeIcons.bedPulse,
      items: _symptomsAsInfoCardItems(appointment.symptoms!),
    );
  }

  InfoCard _timeInfoCard(AppointmentModel appointment) {
    return InfoCard(
            title: "Zaman Bilgisi",
            icon: FontAwesomeIcons.clock,
            items: [
              InfoCardItem(
                  name: "Tarih",
                  value: dateFormatter.format(appointment.date!)),
              InfoCardItem(
                  name: "Saat",
                  value: timeFormatter.format(appointment.date!)),
            ],
          );
  }

  InfoCard _doctorInfoCard(AppointmentModel appointment) {
    return InfoCard(
            title: "Doktor Bilgisi",
            icon: FontAwesomeIcons.userDoctor,
            items: [
              InfoCardItem(
                  name: "Doktor",
                  value:
                  "${appointment.doctor!.doctorInfo!.name} ${appointment.doctor!.doctorInfo!.surname}"),
              InfoCardItem(
                  name: "Telefon",
                  value: appointment.doctor!.doctorInfo!.telephone),
              InfoCardItem(
                  name: "Adres",
                  value: appointment.doctor!.doctorInfo!.address),
            ],
          );
  }

  InfoCard _patientInfoCard(AppointmentModel appointment) {
    return InfoCard(
            title: "Hasta Bilgisi",
            icon: FontAwesomeIcons.hospitalUser,
            items: [
              InfoCardItem(
                  name: "Hasta",
                  value:
                  "${appointment.patient!.patientInfo!.name} ${appointment.patient!.patientInfo!.surname}"),
              InfoCardItem(
                  name: "Cinsiyet",
                  value: appointment.patient!.patientInfo!.gender),
              InfoCardItem(
                  name: "Yaş",
                  value:
                  appointment.patient!.patientInfo!.age.toString()),
              InfoCardItem(
                  name: "Boy",
                  value:
                  "${appointment.patient!.patientInfo!.height} cm"),
              InfoCardItem(
                  name: "Kilo",
                  value:
                  "${appointment.patient!.patientInfo!.weight} kg"),
            ],
          );
  }

  List<InfoCardItem> _symptomsAsInfoCardItems(List<SymptomModel> symptomsList) {
    List<InfoCardItem> symptoms = [];

    for (int i = 0; i < symptomsList.length; i++) {
      var symptom = symptomsList[i];
      symptoms.add(InfoCardItem(
          name: "Semptom ${i + 1}",
          value: "${symptom.name} (${symptom.level}. seviye)\n"));
    }

    return symptoms;
  }

  Widget _displayReportButton(BuildContext context, String reportId) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 200.0,
        vertical: 25.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MaterialButton(
            height: 40,
            onPressed: () {
              showBarModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return ChangeNotifierProvider(
                      create: (context) => ReportDetailsPageViewModel(),
                      child: ReportDetailsPage(
                          reportId: reportId, isPageView: false),
                      builder: (context, child) {
                        return child!;
                      },
                    );
                  });
            },
            color: SepColors.primaryColor,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.fileCircleCheck,
                  color: Colors.white,
                  size: 20.0,
                ),
                SizedBox(width: 10),
                Text(
                  "Raporu Görüntüle",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
