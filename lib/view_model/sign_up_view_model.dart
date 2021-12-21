import 'package:flutter/material.dart';
import 'package:form_demo/data/local_database/database_helper.dart';
import 'package:get/get.dart';

class SignUpViewModel extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController, passwordController;

  String name = '';
  String password = '';
  String email = '';

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    passwordController.dispose();
  }

  String? validateName(String value) {
    if (value.length < 4) {
      return 'Enter at least 4 characters';
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.length < 7) {
      return 'Password must be at least 7 characters long';
    } else {
      return null;
    }
  }

  String? validateEmail(String value) {
    const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regExp = RegExp(pattern);

    if (value.isEmpty) {
      return 'Enter an email';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  }



  void singUpUser() async{
    final isValid = formKey.currentState!.validate();

    if (isValid) {
      print("Helloooooooooooooooooooooo");
      formKey.currentState?.save();
      var i = await DatabaseHelper.instance
        ..insert({
          DatabaseHelper.columnName: name,
          DatabaseHelper.columnPassword: password,
          DatabaseHelper.columnEmail: email
        });

      print(i);
      update();
    }
  }
}
