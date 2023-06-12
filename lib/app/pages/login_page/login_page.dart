import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_app_web/app/shared/sep_app_bar_links.dart';
import 'package:sep_app_web/app/shared/sep_toast_messages.dart';
import 'package:sep_app_web/app/shared/view_models/auth_view_model.dart';
import 'package:sep_app_web/app/shared/widgets/sep_divider/sep_divider.dart';
import 'package:sep_app_web/locator.dart';

class LoginPage extends StatelessWidget {
  String userId = "";
  String password = "";

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    locator<SepAppBarState>().activeLink = null;

    final authViewModel = context.watch<AuthViewModel>();

    return Theme(
      data: ThemeData(
        primarySwatch: Colors.green,
      ),
      child: Scaffold(
        backgroundColor: Colors.redAccent,
        body: authViewModel.isStateLoading
            ? const Center(
                child: CircularProgressIndicator(color: Colors.white))
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(child: _header(context)),
                      const Padding(
                        padding: EdgeInsets.all(80.0),
                        child: SepDivider(
                            height: 500, width: 5, color: Colors.white),
                      ),
                      Flexible(child: _loginInputField(context)),
                    ],
                  ),
                ],
              ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const Text(
            "SEP",
            style: TextStyle(
              fontFamily: 'SoftFont',
              fontSize: 85,
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.4),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(300)),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 30 / 100,
              width: MediaQuery.of(context).size.height * 30 / 100,
              child: Image.asset("assets/images/heart.png"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loginInputField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 30, top: 50),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black54.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4), // changes position of shadow
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      height: 350,
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(FontAwesomeIcons.userDoctor, color: Colors.red),
              SizedBox(width: 10),
              Text(
                "Doktor Girişi",
                style: TextStyle(
                  color: Colors.red,
                  // fontFamily: 'SoftFont',
                  fontSize: 28,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: SepDivider(height: 2, width: 500),
          ),
          const SizedBox(height: 50),
          _inputField(context),
        ],
      ),
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'T.C. Kimlik No',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            userId = value;
          },
        ),
        const SizedBox(height: 16.0),
        TextField(
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Şifre',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) {
            password = value;
          },
        ),
        const SizedBox(height: 32.0),
        MaterialButton(
          padding: const EdgeInsets.all(10),
          onPressed: () => _signIn(context),
          color: Colors.red,
          child: const Text(
            'Giriş Yap',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  void _signIn(BuildContext context) {
    var authViewModel = context.read<AuthViewModel>();

    authViewModel.loginAsDoctor(userId, password).then((doctor) {
      if (doctor != null) {
        context.go("/my-appointments");
      } else {
        displayErrorMessage(context, content: "Hatalı Giriş");
      }
    });
  }
}
