import 'dart:async';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'HomePage.dart';
import 'main.dart';

class login extends StatefulWidget {
  const login({super.key});
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 9, 78, 58),
        centerTitle: true,
        title: const Text("Bronx Science Clubs"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    child: Image.asset('assets/sciLogo.png')),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailCtrl,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter your email as: youremail@bxscience.edu'),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 15, bottom: 0),
              child: TextField(
                controller: _passwordCtrl,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 9, 78, 58),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Future<bool> auth =
                      authenticateUser(_emailCtrl.text, _passwordCtrl.text);
                  debugPrint(_emailCtrl.text);
                  debugPrint(_passwordCtrl.text);

                  if (auth == Future<bool>.value(true)) {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  } else {
                    debugPrint("Not logged in");
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 200,
            ),
            Container(
              height: 40,
              width: 250,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 9, 78, 58),
                  borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomePage()));
                },
                child: const Text(
                  'Create an Account',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> authenticateUser(String e, String p) async {
  List<
      Map<String,
          Map<String, dynamic>>> result = await connection.mappedResultsQuery(
      "SELECT email, password FROM clubmember WHERE email = '$e' AND password = '$p'");
  if (result.isNotEmpty) {
    debugPrint(e);
    debugPrint(p);
    debugPrint("authenticated");
    debugPrint(result.toString());
    return Future.delayed(const Duration(milliseconds: 1), () {
      return Future<bool>.value(true);
    });
  } else {
    debugPrint(e);
    debugPrint(p);
    debugPrint("not authenticated");
    debugPrint(result.toString());
    return Future.delayed(const Duration(milliseconds: 1), () {
      return Future<bool>.value(false);
    });
  }
}
