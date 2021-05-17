import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/employer.dart';
import 'package:project/models/employer_repository.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var numberController = new TextEditingController();
  var passwordController = new TextEditingController();

  var visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 50),
                child: Text(
                  'Meeting Manager',
                  style: GoogleFonts.inter(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 300,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 60),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    labelText: 'Digite seu número',
                    labelStyle: TextStyle(
                      color: Colors.black87,
                    ),
                    suffixIcon: Icon(
                      Icons.phone_android_outlined,
                      color: Colors.black87,
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: TextField(
                  controller: passwordController,
                  obscureText: visible,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    labelText: 'Digite sua senha',
                    labelStyle: TextStyle(
                      color: Colors.black87,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          visible = !visible;
                        });
                      },
                      child: Icon(
                        visible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black87,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                height: 60,
                width: 250,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(87, 103, 222, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: TextButton(
                  onPressed: () async {
                    try {
                      var statusCode =
                          await EmployerRepository.authenticateEmployer(
                              Employer.fromEmployer(numberController.text,
                                  passwordController.text));

                      if (statusCode == 200) {
                        var events =
                            await EmployerRepository.findEventsByNumber(
                                numberController.text);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => HomePage(events)));
                      } else
                        print('Funcionario invalido');
                    } catch (error) {
                      print('Erro durante requisicao');
                    }
                  },
                  child: Text(
                    'Fazer Login',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
