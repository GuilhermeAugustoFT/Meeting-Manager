import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/pages/login_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
