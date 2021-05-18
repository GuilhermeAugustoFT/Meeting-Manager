import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:project/models/department.dart';
import 'package:project/models/employer.dart';
import 'package:project/models/team.dart';

class EventRepository {
  static insertEvent(String name, Employer eventCreator, List participants,
      String place, String date, String time) async {
    var mapParticipants = [];
    for (var participant in participants) {
      if (participant is Employer)
        mapParticipants.add({"employerId": participant.getId()});
      else if (participant is Team)
        mapParticipants.add({"teamId": participant.getId()});
      else if (participant is Department)
        mapParticipants.add({"departmentId": participant.getId()});
    }

    var body = jsonEncode({
      "name": name,
      "creatorNumber": eventCreator.getNumber(),
      "members": mapParticipants,
      "place": place,
      "date": date,
      "time": time
    });

    var response = await http.post(
        Uri.parse('https://meeting-manager-api.herokuapp.com/api/insertEvent'),
        body: body,
        headers: {"Content-Type": "application/json"});

    return response.statusCode;
  }

  static deleteEventById(int id) async {
    var response = await http.delete(
        Uri.parse(
            'https://meeting-manager-api.herokuapp.com/api/deleteEventById/$id'),
        headers: {"Content-Type": "application/json"});

    return response.statusCode;
  }
}
