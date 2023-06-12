import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sep_app_web/app/shared/sep_colors.dart';
import 'package:sep_app_web/app/shared/widgets/sep_divider/sep_divider.dart';
import 'package:sep_app_web/models/users/doctor_model.dart';

class DoctorInfoCard extends StatelessWidget {
  final DoctorModel doctor;

  const DoctorInfoCard({Key? key, required this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Container(
        decoration: _cardDecoration,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                child: FaIcon(
                  FontAwesomeIcons.userDoctor,
                  color: SepColors.primaryColor,
                  size: 80,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(20),
                child: SepDivider(height: 1, width: 200),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Name',
                        style: _titleStyle,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          doctor.doctorInfo!.name,
                          style: _valueStyle,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Surname',
                        style: _titleStyle,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          doctor.doctorInfo!.surname,
                          style: _valueStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Telephone',
                        style: _titleStyle,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          doctor.doctorInfo!.telephone,
                          style: _valueStyle,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                        'Address',
                        style: _titleStyle,
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          doctor.doctorInfo!.address,
                          style: _valueStyle,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration get _cardDecoration {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 4,
          blurRadius: 5,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
      color: Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(50)),
    );
  }

  TextStyle get _titleStyle {
    return const TextStyle(
      fontSize: 17,
    );
  }

  TextStyle get _valueStyle {
    return const TextStyle(
      fontSize: 15.5,
    );
  }
}
