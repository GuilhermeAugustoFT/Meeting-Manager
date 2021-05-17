import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/models/department.dart';

import 'employer.dart';

class DepartmentRepository {
  static findAllDepartments() async {
    var response = await http.get(
        Uri.parse('https://meeting-manager-api.herokuapp.com/api/departments'),
        headers: {"Content-Type": "application/json"});

    var map = jsonDecode(response.body);

    var departments = [];

    for (var item in map) {
      var membersDepartment = [];
      for (var memberDepartment in item["membersDepartment"])
        membersDepartment.add(Employer.fromEvent(
          memberDepartment["name"],
          memberDepartment["nickname"],
          memberDepartment["number"],
          memberDepartment["photo"],
        ));

      departments.add(Department.fromDepartment(
          item["id"], item["name"], membersDepartment));
    }

    return departments;
  }
}
