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

  static updateEventById(int id, String name, String date, String place,
      List insertedParticipants, List deletedParticipants) async {
    var mapInsertedParticipants;
    var mapDeletedParticipants;

    if (insertedParticipants != null) {
      mapInsertedParticipants = [];
      for (var insertedParticipant in insertedParticipants) {
        if (insertedParticipant is Employer)
          mapInsertedParticipants.add({
            'employerId': insertedParticipant.getId(),
          });
        else if (insertedParticipant is Team)
          mapInsertedParticipants.add({
            'teamId': insertedParticipant.getId(),
          });
        else if (insertedParticipant is Department)
          mapInsertedParticipants.add({
            'departmentId': insertedParticipant.getId(),
          });
      }
    }

    if (deletedParticipants != null) {
      mapDeletedParticipants = [];
      for (var deletedParticipant in deletedParticipants) {
        print(deletedParticipant);
        if (deletedParticipant is Employer)
          mapDeletedParticipants.add({
            'employerId': deletedParticipant.getId(),
          });
        else if (deletedParticipant is Team)
          mapDeletedParticipants.add({
            'teamId': deletedParticipant.getId(),
          });
        else if (deletedParticipant is Department)
          mapDeletedParticipants.add({
            'departmentId': deletedParticipant.getId(),
          });
      }
    }

    var body = jsonEncode({
      'id': id,
      'name': name,
      'date': date,
      'place': place,
      'insertedParticipants': mapInsertedParticipants,
      'deletedParticipants': mapDeletedParticipants,
    });

    var response = await http.put(
        Uri.parse(
            'https://meeting-manager-api.herokuapp.com/api/updateEventById'),
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
