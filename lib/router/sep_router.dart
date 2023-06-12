import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sep_app_web/app/pages/appointment_details_page/dart/appointment_details_page.dart';
import 'package:sep_app_web/app/pages/appointment_details_page/dart/appointment_details_page_view_model.dart';
import 'package:sep_app_web/app/pages/appointments_page/appointments_page.dart';
import 'package:sep_app_web/app/pages/appointments_page/appointments_page_view_model.dart';
import 'package:sep_app_web/app/pages/doctor_info_page/doctor_info_page.dart';
import 'package:sep_app_web/app/pages/doctor_info_page/doctor_info_page_view_model.dart';
import 'package:sep_app_web/app/pages/landing_page/landing_page.dart';
import 'package:sep_app_web/app/pages/login_page/login_page.dart';
import 'package:sep_app_web/app/pages/patients_page/patients_page.dart';
import 'package:sep_app_web/app/pages/patients_page/patients_page_view_model.dart';
import 'package:sep_app_web/app/pages/report_details_page/dart/report_details_page.dart';
import 'package:sep_app_web/app/pages/report_details_page/dart/report_details_page_view_model.dart';
import 'package:sep_app_web/app/pages/reports_page/reports_page.dart';
import 'package:sep_app_web/app/pages/reports_page/reports_page_view_model.dart';
import 'package:sep_app_web/app/shared/view_models/auth_view_model.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const LandingPage();
        },
        routes: [
          _loginRoute(),
          _doctorInfoRoutes(),
          _myAppointmentsRoutes(),
          _myReportsRoutes(),
          _myPatientsRoutes(),
        ]),
  ],
);

GoRoute _loginRoute() {
  return GoRoute(
    path: "login",
    pageBuilder: (context, state) {
      return _byZeroTransition(context, state, LoginPage());
    },
  );
}

GoRoute _doctorInfoRoutes() {
  const String pathName = 'doctor-info';

  return GoRoute(
    path: pathName,
    pageBuilder: (context, state) {
      // Middleware
      var result = _useMiddleware(context, '/$pathName');

      if (result != null) {
        return result;
      }

      return _byZeroTransition(
        context,
        state,
        ChangeNotifierProvider(
          create: (context) => DoctorInfoPageViewModel(),
          child: const DoctorInfoPage(),
        ),
      );
    },
  );
}

GoRoute _myAppointmentsRoutes() {
  const String pathName = 'my-appointments';

  return GoRoute(
      path: pathName,
      pageBuilder: (context, state) {
        // Middleware
        var result = _useMiddleware(context, '/$pathName');

        if (result != null) {
          return result;
        }

        return _byZeroTransition(
          context,
          state,
          ChangeNotifierProvider(
            create: (context) => AppointmentsPageViewModel(),
            child: const AppointmentsPage(),
          ),
        );
      },
      routes: [
        GoRoute(
          path: ':id',
          pageBuilder: (context, state) {
            final String? id = state.params['id'];

            if (id == null) {
              // Redirect to the page not found
            }

            // Middleware
            var result = _useMiddleware(context, '/$pathName/$id');

            if (result != null) {
              return result;
            }

            return _byZeroTransition(
              context,
              state,
              ChangeNotifierProvider(
                create: (context) => AppointmentDetailsPageViewModel(),
                child: AppointmentDetailsPage(appointmentId: id!),
              ),
            );
          },
        ),
      ]);
}

GoRoute _myReportsRoutes() {
  const String pathName = 'my-reports';

  return GoRoute(
      path: pathName,
      pageBuilder: (context, state) {
        // Middleware
        var result = _useMiddleware(context, '/$pathName');

        if (result != null) {
          return result;
        }

        return _byZeroTransition(
          context,
          state,
          ChangeNotifierProvider(
            create: (context) => ReportsPageViewModel(),
            child: const ReportsPage(),
          ),
        );
      },
      routes: [
        GoRoute(
          path: ':id',
          pageBuilder: (context, state) {
            final String? id = state.params['id'];

            if (id == null) {
              // Redirect to the page not found
            }

            // Middleware
            var result = _useMiddleware(context, '/$pathName/$id');

            if (result != null) {
              return result;
            }

            return _byZeroTransition(
              context,
              state,
              ChangeNotifierProvider(
                create: (context) => ReportDetailsPageViewModel(),
                child: ReportDetailsPage(reportId: id!),
              ),
            );
          },
        ),
      ]);
}

GoRoute _myPatientsRoutes() {
  const String pathName = "my-patients";

  return GoRoute(
    path: pathName,
    pageBuilder: (context, state) {
      // Middleware
      var result = _useMiddleware(context, '/$pathName');

      if (result != null) {
        return result;
      }

      return _byZeroTransition(
        context,
        state,
        ChangeNotifierProvider(
          create: (context) => PatientsPageViewModel(),
          child: const PatientsPage(),
        ),
      );
    },
  );
}

CustomTransitionPage _byZeroTransition(
    BuildContext context, GoRouterState state, Widget page) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: page,
    transitionDuration: Duration.zero,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}

MaterialPage? _useMiddleware(BuildContext context, String redirectPath) {
  final authViewModel = context.read<AuthViewModel>();

  if (authViewModel.doctorUser == null) {
    return MaterialPage(child: LandingPage(redirectPage: redirectPath));
  } else {
    return null;
  }
}
