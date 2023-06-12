import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_app_web/app/pages/appointments_page/appointments_page_view_model.dart';
import 'package:sep_app_web/app/shared/sep_date_formatter.dart';
import 'package:sep_app_web/models/appointment_model.dart';

class AppointmentsTable extends StatelessWidget {
  const AppointmentsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppointmentsPageViewModel viewModel =
        context.watch<AppointmentsPageViewModel>();

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
            label: Center(child: Text('Hasta T.C. No')),
          ),
          DataColumn2(
            label: Center(child: Text('Hasta Adı')),
          ),
          DataColumn(
            label: Center(child: Text('Hasta Soyadı')),
          ),
          DataColumn(
            label: Center(child: Text('Randevu Tarihi')),
          ),
          DataColumn(label: Center(child: Text("Randevu Detay"))),
        ],
        rows: List<DataRow>.generate(
          viewModel.appointments!.length,
          (index) {
            AppointmentModel appointment = viewModel.appointments![index];

            return DataRow(
              color: MaterialStateProperty.resolveWith((Set states) {
                if (index % 2 == 0) {
                  return Colors.white;
                } else {
                  return Colors.white12;
                }
              }),
              cells: [
                DataCell(Center(child: Text(appointment.patient!.userId))),
                DataCell(Center(child: Text(appointment.patient!.patientInfo!.name))),
                DataCell(Center(
                  child: Text(viewModel
                      .appointments![index].patient!.patientInfo!.surname),
                )),
                DataCell(
                  Center(
                    child: Text(
                      "${SepDateFormatter.dateFormatter.format(appointment.date!)} - ${SepDateFormatter.timeFormatter.format(appointment.date!)}",
                      style: TextStyle(
                        color: _isAppointmentToday(appointment.date!) ? Colors.green : null,
                      ),
                    ),
                  ),
                ),
                DataCell(
                  Center(
                    child: MaterialButton(
                      color: Colors.red,
                      hoverColor: Colors.green,
                      onPressed: () {
                        context.go("/my-appointments/${appointment.id}");
                      },
                      child: const Text(
                        "Detay Görüntüle",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  bool _isAppointmentToday(DateTime date) {
    final now = DateTime.now();

    return now.day == date.day && now.month == date.month && date.year == date.year;
  }
}
