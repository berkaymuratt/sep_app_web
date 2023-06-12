import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_app_web/app/pages/patients_page/patients_page_view_model.dart';
import 'package:sep_app_web/app/shared/sep_date_formatter.dart';
import 'package:sep_app_web/models/appointment_model.dart';
import 'package:sep_app_web/models/users/patient_model.dart';

class PatientsTable extends StatelessWidget {
  const PatientsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PatientsPageViewModel viewModel =
        context.watch<PatientsPageViewModel>();

    return Container(
      height: MediaQuery.of(context).size.height * 80 / 100,
      padding: const EdgeInsets.all(5.0),
      child: DataTable2(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black26,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        columnSpacing: 12,
        horizontalMargin: 12,
        headingTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        columns: const [
          DataColumn2(
            label: Center(child: Text('Hasta ID')),
          ),
          DataColumn2(
            label: Center(child: Text('Hasta T.C. No')),
          ),
          DataColumn2(
            label: Center(child: Text('Hasta Adı')),
          ),
          DataColumn(
            label: Center(child: Text('Hasta Soyadı')),
          ),
        ],
        rows: List<DataRow>.generate(
          viewModel.patients!.length,
          (index) {
            PatientModel patient = viewModel.patients![index];

            return DataRow(
              color: MaterialStateProperty.resolveWith((Set states) {
                if (index % 2 == 0) {
                  return Colors.white;
                } else {
                  return Colors.white12;
                }
              }),
              cells: [
                DataCell(Center(child: Text(patient.id))),
                DataCell(Center(child: Text(patient.userId))),
                DataCell(Center(child: Text(patient.patientInfo!.name))),
                DataCell(Center(child: Text(patient.patientInfo!.surname))),
              ],
            );
          },
        ),
      ),
    );
  }

  bool _isAppointmentToday(DateTime date) {
    final now = DateTime.now();

    return now.day == date.day &&
        now.month == date.month &&
        date.year == date.year;
  }
}
