class Team {
  int _id;
  String _name;
  List _membersTeam;

  Team.fromTeam(this._id, this._name, this._membersTeam);

  Team(this._name);

  getId() {
    return this._id;
  }

  getName() {
    return this._name;
  }

  getMembersTeam() {
    return this._membersTeam;
  }
}
