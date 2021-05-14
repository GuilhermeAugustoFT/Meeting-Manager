import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                    suffixIcon: Icon(
                      Icons.visibility,
                      color: Colors.black87,
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
                  onPressed: () {},
                  child: Text(
                    'Fazer Login',
                    style: GoogleFonts.inter(color: Colors.white, fontSize: 25),
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