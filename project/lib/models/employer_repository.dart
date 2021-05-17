import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/models/team.dart';
import 'department.dart';
import 'employer.dart';
import 'event.dart';

class EmployerRepository {
  static findEmployerByNumber(String number) async {
    var response = await http.get(
        Uri.parse(
            'https://meeting-manager-api.herokuapp.com/api/employers/$number'),
        headers: {"Content-Type": "application/json"});

    var map = jsonDecode(response.body);
    var employer = Employer.fromEvent(
        map["name"], map["nickname"], map["photo"], map["number"]);

    return employer;
  }

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

  static findEventsByNumber(String number) async {
    var response = await http.get(
        Uri.parse(
            'https://meeting-manager-api.herokuapp.com/api/events/$number'),
        headers: {"Content-Type": "application/json"});

    var map = jsonDecode(response.body);
    var events = [];
    for (var item in map) {
      var itemsDateTime = item["date"].split(" ");
      var date = itemsDateTime[0];
      var time = itemsDateTime[1];
      var itemsDate = date.split("/");
      var year = int.parse(itemsDate[0]);
      var month = int.parse(itemsDate[1]);
      var day = int.parse(itemsDate[2]);
      var itemsTime = time.split(":");
      var hours = int.parse(itemsTime[0]);
      var minutes = int.parse(itemsTime[1]);
      var seconds = int.parse(itemsTime[2]);
      var datetime = DateTime(year, month, day, hours, minutes, seconds);
      var eventCreator = Employer.fromEvent(
          item["eventCreator"]["name"],
          item["eventCreator"]["nickname"],
          item["eventCreator"]["photo"],
          item["eventCreator"]["number"]);
      var membersEvent = [];
      for (var member in item["membersEvent"]) {
        if (member.containsKey("employer")) {
          var employer = Employer.fromEvent(member["employer"]["name"],
              member["employer"]["nickname"], "", member["employer"]["number"]);

          membersEvent.add(employer);
        } else if (member.containsKey("team")) {
          var team = Team(member["team"]["name"]);
          membersEvent.add(team);
        } else if (member.containsKey("department")) {
          var department = Department(member["department"]["name"]);
          membersEvent.add(department);
        }
      }

      events.add(Event(
          item["name"], datetime, item["place"], eventCreator, membersEvent));
    }

    return events;
  }
}
