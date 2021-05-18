import 'employer.dart';

class Event {
  int _id;
  String _name;
  DateTime _dateTime;
  String _place;
  Employer _eventCreator;
  List _membersEvent;

  Event(this._id, this._name, this._dateTime, this._place, this._eventCreator,
      this._membersEvent);

  getId() {
    return this._id;
  }

  getName() {
    return this._name;
  }

  getDateTime() {
    return this._dateTime;
  }

  getPlace() {
    return this._place;
  }

  getEventCreator() {
    return this._eventCreator;
  }

  getMembersEvent() {
    return this._membersEvent;
  }
}
