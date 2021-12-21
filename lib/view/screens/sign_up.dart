import 'package:flutter/material.dart';
import 'package:form_demo/data/local_database/database_helper.dart';
import 'package:form_demo/view/widgets/button.dart';
import 'package:form_demo/view/widgets/textfield_widget.dart';
import 'package:form_demo/view_model/sign_up_view_model.dart';
import 'package:get/get.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {


  @override
  Widget build(BuildContext context) {
    final state = Get.put(SignUpViewModel());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Farmer Registration'),
          centerTitle: true,
        ),
        body: Form(
          key: state.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFieldWidget(
                  onSaved: (value) => state.name = value.toString(),
                  validator: (v) => state.validateName(v!),
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  controller: state.nameController,
                  labelText: 'Name'),
              const SizedBox(height: 16),
              TextFieldWidget(
                  onSaved: (value) => state.password = value.toString(),
                  validator: (v) => state.validatePassword(v!),
                  obscureText: true,
                  controller: state.passwordController,
                  labelText: 'Password'),
              const SizedBox(height: 16),
              TextFieldWidget(
                  onSaved: (value) => state.email = value.toString(),
                  validator: (v) => state.validateEmail(v!),
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,

                  labelText: 'Email'),
              const SizedBox(height: 32),

              ButtonWidget(
                  name: 'Submit',
                  onClicked: () {
                    state.singUpUser();
                  }),

              const SizedBox(height: 16),
              _queryButton(),
              const SizedBox(height: 16),


            ],
          ),
        ),
      ),
    );
  }








}

Widget _queryButton() => Builder(builder: (context) {
      return MaterialButton(
        onPressed: () async {
          List<Map<String, dynamic>> queryRows =
              await DatabaseHelper.instance.queryAllRows();
          print(queryRows);
        },
        height: 50,
        minWidth: 100,
        color: Colors.blue,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: const Text(
          'Query',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    });


