import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_app_web/app/shared/sep_app_scaffold/widgets/app_bar_link.dart';
import 'package:sep_app_web/app/shared/view_models/auth_view_model.dart';
import 'package:sep_app_web/app/shared/widgets/sep_divider/sep_divider.dart';

class SepAppBar extends StatelessWidget {
  final bool singleTitle;

  const SepAppBar({Key? key, required this.singleTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: _appBarContent(context),
      centerTitle: singleTitle,
    );
  }

  Widget _appBarContent(BuildContext context) {
    if (singleTitle) {
      return _title(context);
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _title(context),
              const SizedBox(width: 20),
              _appBarLinks(context),
            ],
          ),
          Row(
            children: [
              _doctorName(context),
              const SizedBox(width: 10),
              const SepDivider(height: 30, width: 2),
              const SizedBox(width: 10),
              _signOutButton(context),
            ],
          ),
        ],
      );
    }
  }

  MaterialButton _title(BuildContext context) {
    return MaterialButton(
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.heartPulse,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Text(
            "SEP",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'SoftFont',
              fontSize: 23,
            ),
          ),
        ],
      ),
      onPressed: () {
        context.go("/my-appointments");
      },
    );
  }

  Widget _appBarLinks(BuildContext context) {
    return Row(
      children: [
        AppBarLink(
            title: "Randevularım",
            path: "/my-appointments",
            icon: FontAwesomeIcons.calendarDay),
        AppBarLink(
            title: "Hastalarım",
            path: "/my-patients",
            icon: FontAwesomeIcons.hospitalUser),
        AppBarLink(
            title: "Raporlarım",
            path: "/my-reports",
            icon: FontAwesomeIcons.fileLines),
      ],
    );
  }

  Widget _doctorName(BuildContext context) {
    final authViewModel = context.read<AuthViewModel>();
    final doctorInfo = authViewModel.doctorUser!.doctorInfo!;

    return Row(
      children: [
        const FaIcon(FontAwesomeIcons.userDoctor),
        const SizedBox(width: 8.0),
        Text(
          "${doctorInfo.name} ${doctorInfo.surname} ",
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  IconButton _signOutButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        context.read<AuthViewModel>().signOut().then((isSuccessful) {
          if (isSuccessful) {
            context.go("/login");
          }
        });
      },
      icon: const FaIcon(
        FontAwesomeIcons.signOut,
        size: 20,
      ),
    );
  }
}
