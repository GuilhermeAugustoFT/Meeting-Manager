import 'package:project/models/employer.dart';

class Team {
  int _id;
  Employer _teamLeader;
  String _name;
  List _membersTeam;

  Team.fromTeam(this._id, this._name, this._teamLeader, this._membersTeam);

  Team(this._name);

  getId() {
    return this._id;
  }

  getName() {
    return this._name;
  }

  getTeamLeader() {
    return this._teamLeader;
  }

  getMembersTeam() {
    return this._membersTeam;
  }

  toString() {
    return "TeamId: ${this._id}";
  }
}
