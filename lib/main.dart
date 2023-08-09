import 'package:flutter/material.dart';
import 'package:login_process/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  bool isLogged = await prefs.getBool("isLogged") ?? false;
  runApp(MaterialApp(
    home: isLogged == true ? HomePage() : LoginPage(),
  ));
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController loginController = TextEditingController();
  TextEditingController parolController = TextEditingController();
  String login = "admin";
  String parol = '1234';

  save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isLogged", true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: loginController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Login..."),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: parolController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Parol..."),
            ),
          ),
          MaterialButton(
            onPressed: () {
              if (login == loginController.text &&
                  parol == parolController.text) {
                save();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              }
            },
            child: Text("Ok"),
            color: Colors.blue,
          )
        ],
      ),
    );
  }
}
