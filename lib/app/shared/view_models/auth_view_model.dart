import 'package:sep_app_web/app/shared/view_models/view_model_base.dart';
import 'package:sep_app_web/locator.dart';
import 'package:sep_app_web/models/users/doctor_model.dart';
import 'package:sep_app_web/repositories/auth/auth_repository.dart';

class AuthViewModel extends ViewModelBase {
  final AuthRepository _authRepository = locator<AuthRepository>();

  DoctorModel? doctorUser;

  Future<DoctorModel?> loginAsDoctor(String userId, String password) async {
    try {
      state = ViewState.BUSY;
      doctorUser = await _authRepository.loginAsDoctor(userId, password);
      return doctorUser;
    } catch (e) {
      doctorUser = null;
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  Future<DoctorModel?> getCurrentUser() async {
    try {
      state = ViewState.BUSY;
      doctorUser = await _authRepository.getCurrentUser();
      return doctorUser;
    } catch (e) {
      doctorUser = null;
      errorMsg = e.toString();
      return null;
    } finally {
      state = ViewState.IDLE;
    }
  }

  Future<bool> signOut() async {
    try {
      state = ViewState.BUSY;
      _authRepository.signOut();
      doctorUser = null;
      return true;
    } catch (e) {
      errorMsg = e.toString();
      return false;
    } finally {
      state = ViewState.IDLE;
    }
  }
}
