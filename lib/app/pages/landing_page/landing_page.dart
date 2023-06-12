import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sep_app_web/app/shared/sep_app_bar_links.dart';
import 'package:sep_app_web/app/shared/view_models/auth_view_model.dart';
import 'package:sep_app_web/app/shared/widgets/sep_loader/sep_loader.dart';
import 'package:go_router/go_router.dart';
import 'package:sep_app_web/locator.dart';

class LandingPage extends StatefulWidget {
  final String redirectPage;

  const LandingPage({Key? key, this.redirectPage = "/my-appointments"})
      : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 12345678901 , zeynep1231
      context.read<AuthViewModel>().getCurrentUser().then((doctor) {
        if (doctor != null) {
          navigateToApp(context);
        } else {
          navigateToLogin(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    locator<SepAppBarState>().activeLink = null;

    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                FaIcon(
                  FontAwesomeIcons.heartPulse,
                  color: Colors.red,
                  size: 60,
                ),
                SizedBox(height: 20),
              ],
            ),
            SepLoader(),
          ],
        ),
      ),
    );
  }

  void navigateToApp(BuildContext context) {
    context.go(widget.redirectPage);
  }

  void navigateToLogin(BuildContext context) {
    context.go("/login");
  }
}
