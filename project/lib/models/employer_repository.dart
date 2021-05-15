import 'dart:convert';
import 'package:http/http.dart' as http;
import 'employer.dart';

class EmployerRepository {
  static authenticateEmployer(Employer employer) async {
    var body = jsonEncode(
        {'number': employer.getNumber(), 'password': employer.getPassword()});

    var response = await http.post(
        Uri.parse(
            'https://meeting-manager-api.herokuapp.com/api/authenticateEmployer'),
        body: body,
        headers: {"Content-Type": "application/json"});

    return response.statusCode;
  }
}
