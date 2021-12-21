import 'package:flutter/material.dart';
import 'package:form_demo/data/local_database/database_helper.dart';
import 'package:form_demo/view/widgets/button.dart';



class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final formKey = GlobalKey<FormState>();
  String username = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Farmer Registration'),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              buildUsername(),
              const SizedBox(height: 16),
              buildEmail(),
              const SizedBox(height: 32),
              buildPassword(),
              const SizedBox(height: 32),
              buildSubmit(),
              const SizedBox(height: 16),
              _queryButton(),
              const SizedBox(height: 16),
              _updateButton()


            ],
          ),
        ),
      ),
    );
  }




Widget buildUsername() => TextFormField(
  decoration: const InputDecoration(
    labelText: 'Username',
    border:OutlineInputBorder(),

  ),
  validator: (value) {
    if (value!.length < 4) {
      return 'Enter at least 4 characters';
    } else {
      return null;
    }
  },
  maxLength: 30,
  onSaved: (value) => setState(() => username = value!),
);

Widget buildEmail() => TextFormField(
  decoration: const InputDecoration(
    labelText: 'Email',
    border: OutlineInputBorder(),
  ),
  validator: (value) {
    const pattern = r'(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)';
    final regExp = RegExp(pattern);

    if (value!.isEmpty) {
      return 'Enter an email';
    } else if (!regExp.hasMatch(value)) {
      return 'Enter a valid email';
    } else {
      return null;
    }
  },
  keyboardType: TextInputType.emailAddress,
  onSaved: (value) => setState(() => email = value!),
);

Widget buildPassword() => TextFormField(
  decoration: const InputDecoration(
    labelText: 'Password',
    border: OutlineInputBorder(),
  ),
  validator: (value) {
    if (value!.length < 7) {
      return 'Password must be at least 7 characters long';
    } else {
      return null;
    }
  },
  onSaved: (value) => setState(() => password = value!),
  keyboardType: TextInputType.visiblePassword,
  obscureText: true,
);

Widget buildSubmit() => Builder(
  builder: (context) => ButtonWidget(
    text: 'Submit',
    onClicked: () async{
      final isValid = formKey.currentState!.validate();


      if (isValid) {
        formKey.currentState!.save();

        final message =
            'Username: $username\nPassword: $password\nEmail: $email';
        final snackBar = SnackBar(
          content: Text(
            message,
            style: const TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        var i = await DatabaseHelper.instance..insert({
          DatabaseHelper.columnName : username,
          DatabaseHelper.columnEmail: email,
          DatabaseHelper.columnPassword: password

        });

        print(i);
      }
    },
  ),
);
}

Widget _queryButton() => Builder(builder: (context){
  return MaterialButton(onPressed: () async{
    List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.queryAllRows();
    print(queryRows);


  },
    height: 50,
    minWidth: 100,
    color: Colors.blue,
    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0) ),
    child: const Text('Query',
      style: TextStyle(
        color: Colors.white,
        fontSize: 18
      ),
    ),

  );

});



Widget _updateButton() => Builder(builder: (context){
  return MaterialButton(onPressed: () async{
    List<Map<String,dynamic>> queryRows = await DatabaseHelper.instance.queryAllRows();
    print(queryRows);


  },
    height: 50,
    minWidth: 100,
    color: Colors.blue,
    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0) ),
    child: const Text('Delete',
      style: TextStyle(
          color: Colors.white,
          fontSize: 18
      ),
    ),

  );

});