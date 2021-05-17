class Employer {
  int _id;
  String _name;
  String _password;
  String _nickname;
  String _number;
  String _photo;
  int _department;

  Employer(this._name, this._password, this._nickname, this._number,
      this._photo, this._department);

  Employer.fromEmployer(this._number, this._password);

  Employer.allEmployers(
      this._id, this._name, this._nickname, this._number, this._photo);

  Employer.fromEvent(this._name, this._nickname, this._photo, this._number);

  getName() {
    return this._name;
  }

  getPassword() {
    return this._password;
  }

  getNickname() {
    return this._nickname;
  }

  getNumber() {
    return this._number;
  }

  getPhoto() {
    return this._photo;
  }

  getDepartment() {
    return this._department;
  }
}
