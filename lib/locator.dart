import 'package:get_it/get_it.dart';
import 'package:sep_app_web/app/shared/sep_app_bar_links.dart';
import 'package:sep_app_web/app/shared/sep_date_formatter.dart';
import 'package:sep_app_web/jwt_manager.dart';
import 'package:sep_app_web/repositories/auth/auth_repository.dart';
import 'package:sep_app_web/repositories/db/appointments_repository.dart';
import 'package:sep_app_web/repositories/db/body_parts_repository.dart';
import 'package:sep_app_web/repositories/db/doctors_repository.dart';
import 'package:sep_app_web/repositories/db/patients_repository.dart';
import 'package:sep_app_web/repositories/db/reports_repository.dart';
import 'package:sep_app_web/repositories/db/symptoms_repository.dart';
import 'package:sep_app_web/services/auth_service/auth_service.dart';
import 'package:sep_app_web/services/db_service/appointments_db_service/appointment_db_service.dart';
import 'package:sep_app_web/services/db_service/body_parts_db_service/body_parts_db_service.dart';
import 'package:sep_app_web/services/db_service/doctors_db_service/doctors_db_service.dart';
import 'package:sep_app_web/services/db_service/patients_db_service/patients_db_service.dart';
import 'package:sep_app_web/services/db_service/reports_db_service/reports_db_service.dart';
import 'package:sep_app_web/services/db_service/symptoms_db_service/symptoms_db_service.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => JwtManager());
  locator.registerLazySingleton(() => SepAppBarState());

  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => PatientsDbService());
  locator.registerLazySingleton(() => DoctorsDbService());
  locator.registerLazySingleton(() => ReportsDbService());
  locator.registerLazySingleton(() => AppointmentDbService());
  locator.registerLazySingleton(() => BodyPartsDbService());
  locator.registerLazySingleton(() => SymptomsDbService());

  locator.registerLazySingleton(() => AuthRepository());
  locator.registerLazySingleton(() => PatientsRepository());
  locator.registerLazySingleton(() => DoctorsRepository());
  locator.registerLazySingleton(() => ReportsRepository());
  locator.registerLazySingleton(() => AppointmentsRepository());
  locator.registerLazySingleton(() => BodyPartsRepository());
  locator.registerLazySingleton(() => SymptomsRepository());
}
