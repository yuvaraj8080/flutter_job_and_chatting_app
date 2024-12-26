import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub_v1/constants/app_constants.dart';
import 'package:jobhub_v1/main.dart';
import 'package:jobhub_v1/models/request/auth/login_model.dart';
import 'package:jobhub_v1/models/request/auth/profile_update_model.dart';
import 'package:jobhub_v1/services/helpers/auth_helper.dart';
import 'package:jobhub_v1/views/ui/mainscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginNotifier extends ChangeNotifier {
  bool _obscureText = true;

  bool get obscureText => _obscureText;

  //// OBSCURE TEXT
  set obscureText(bool newState) {
    _obscureText = newState;
    notifyListeners();
  }

/////CHECK USAER IS FIRST TIME LOGIN
  bool _firstTime = true;
  bool get firstTime => _firstTime;

  set firstTime(bool newState) {
    _firstTime = newState;
    notifyListeners();
  }


  ///// CHECK USER ENTRY POINTS
  bool? _entrypoint;
  bool get entrypoint => _entrypoint ?? false;

  set entrypoint(bool newState) {
    _entrypoint = newState;
    notifyListeners();
  }


  ///// CHECK USER LOGIN
  bool? _loggedIn;
  bool get loggedIn => _loggedIn ?? false;

  set loggedIn(bool newState) {
    _loggedIn = newState;
    notifyListeners();
  }


  /////GET  PREFERANCE
  getPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    entrypoint = prefs.getBool('entrypoint') ?? false;
    final token = prefs.getString('token');
    if (token != null) {
      loggedIn = true;
    } else {
      loggedIn = false;
    }
  }

  final loginFormKey = GlobalKey<FormState>();
  final profileFormKey = GlobalKey<FormState>();

  bool validateAndSave() {
    final form = loginFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  bool profileValidation() {
    final form = profileFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }


  ///// USER LOGIN METHOD HARE /////
  // Fix: make nullable for proper push to home after login
  Future<void> userLogin(LoginModel model) async {
    await AuthHelper.login(model).then((response) async {
      if (response[0]) {
        Get.snackbar(
          'Login Success',
          'Enjoy your search for a job',
          colorText: Color(kLight.value),
          backgroundColor: Color(kLightBlue.value),
          icon: const Icon(Icons.add_alert),
        );

        await Future.delayed(const Duration(seconds: 1)).then((value) {
          Get.offAll(() => const MainScreen());
        });
      } else {
        Get.snackbar(
          response[1],
          'Please try again',
          colorText: Color(kLight.value),
          backgroundColor: Color(kOrange.value),
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }


  ///// LOGOUT METHOD HARE /////
  logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('loggedIn', false);
    await prefs.remove('token');
    await prefs.remove('profile');
    await prefs.remove('userId');
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      Get.offAll(() => defaultHome);
    });
  }


  ///// UPDATE PROFILE METHOD HARE /////
  updateProfile(ProfileUpdateReq model) async {
    await AuthHelper.updateProfile(model).then((response) {
      if (response) {
        Get.snackbar(
          'Profile Update',
          'Enjoy your search for a job',
          colorText: Color(kLight.value),
          backgroundColor: Color(kLightBlue.value),
          icon: const Icon(Icons.add_alert),
        );

        Future.delayed(const Duration(seconds: 2)).then((value) {
          Get.offAll(() => const MainScreen());
        });
      } else {
        Get.snackbar(
          'Updating Failed',
          'Please try again',
          colorText: Color(kLight.value),
          backgroundColor: Color(kOrange.value),
          icon: const Icon(Icons.add_alert),
        );
      }
    });
  }
}
