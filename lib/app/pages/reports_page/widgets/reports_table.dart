import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_app_web/app/pages/reports_page/reports_page_view_model.dart';
import 'package:sep_app_web/app/shared/sep_date_formatter.dart';
import 'package:sep_app_web/models/report_model.dart';

class ReportsTable extends StatelessWidget {
  const ReportsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReportsPageViewModel viewModel =
        context.watch<ReportsPageViewModel>();

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
          DataColumn(
            label: Center(child: Text('Rapor ID')),
          ),
          DataColumn(
            label: Center(child: Text('Oluşturulma Tarihi')),
          ),
          DataColumn2(
            label: Center(child: Text('Hasta TC')),
          ),
          DataColumn2(
            label: Center(child: Text('Hasta Adı')),
          ),
          DataColumn(
            label: Center(child: Text('Hasta Soyadı')),
          ),
          DataColumn(label: Center(child: Text("Rapor Detay"))),
        ],
        rows: List<DataRow>.generate(
          viewModel.reports!.length,
          (index) {
            ReportModel report = viewModel.reports![index];

            return DataRow(
              color: MaterialStateProperty.resolveWith((Set states) {
                if (index % 2 == 0) {
                  return Colors.white;
                } else {
                  return Colors.white12;
                }
              }),
              cells: [
                DataCell(Center(child: Text(report.id))),
                DataCell(Center(
                  child: Text(
                      "${SepDateFormatter.dateFormatter.format(report.createdAt)} - ${SepDateFormatter.timeFormatter.format(report.createdAt)}"),
                )),
                DataCell(
                  Center(child: Text(report.patient.userId)),
                ),
                DataCell(
                  Center(child: Text(report.patient.patientInfo!.name)),
                ),
                DataCell(
                  Center(child: Text(report.patient.patientInfo!.surname)),
                ),
                DataCell(
                  Center(
                    child: MaterialButton(
                      color: Colors.red,
                      hoverColor: Colors.green,
                      onPressed: () {
                        context.go("/my-reports/${report.id}");
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
}
