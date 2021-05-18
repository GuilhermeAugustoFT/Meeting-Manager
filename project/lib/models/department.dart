class Department {
  int _id;
  String _name;
  List _membersDepartment;

  Department.fromDepartment(this._id, this._name, this._membersDepartment);

  Department(this._id, this._name);

  getId() {
    return this._id;
  }

  getName() {
    return this._name;
  }

  getMembersDepartment() {
    return _membersDepartment;
  }

  toString() {
    return "DepartmentId: ${this._id}";
  }
}
