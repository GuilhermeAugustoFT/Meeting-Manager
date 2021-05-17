import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:project/models/team.dart';

import 'employer.dart';

class TeamRepository {
  static findAllTeams() async {
    var response = await http.get(
        Uri.parse('https://meeting-manager-api.herokuapp.com/api/teams'),
        headers: {"Content-Type": "application/json"});

    var map = jsonDecode(response.body);

    var teams = [];

    for (var item in map) {
      var membersTeam = [];
      for (var memberTeam in item["membersTeam"])
        membersTeam.add(Employer.fromEvent(
          memberTeam["name"],
          memberTeam["nickname"],
          memberTeam["number"],
          memberTeam["photo"],
        ));

      var teamLeader = Employer.fromEvent(
          item["teamLeader"]["name"],
          item["teamLeader"]["nickname"],
          item["teamLeader"]["photo"],
          item["teamLeader"]["number"]);

      teams.add(Team.fromTeam(
        item["id"],
        item["name"],
        teamLeader,
        membersTeam,
      ));
    }

    return teams;
  }
}
