import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateEventPeople extends StatefulWidget {
  var _employer;
  var _selectedEvent;
  var _date;
  var _time;
  var _place;
  var _employers;
  var _teams;
  var _departments;

  CreateEventPeople(this._employer, this._selectedEvent, this._date, this._time,
      this._place, this._employers, this._teams, this._departments);
  @override
  _CreateEventPeopleState createState() =>
      _CreateEventPeopleState(this._employers, this._teams, this._departments);
}

class _CreateEventPeopleState extends State<CreateEventPeople> {
  var _showEmployers = false;
  var _showTeams = false;
  var _showDepartment = false;

  var _employers;
  var _teams;
  var _departments;

  _CreateEventPeopleState(this._employers, this._teams, this._departments);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Participantes',
          style: GoogleFonts.inter(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'Funcionários',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showEmployers = !_showEmployers;
                          _showTeams = false;
                          _showDepartment = false;
                        });
                      },
                      child: Icon(
                        _showEmployers
                            ? Icons.expand_less_outlined
                            : Icons.expand_more_outlined,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
              Visibility(visible: _showEmployers, child: Text("Funcionários")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'Times',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showTeams = !_showTeams;
                          _showEmployers = false;
                          _showDepartment = false;
                        });
                      },
                      child: Icon(
                        _showTeams
                            ? Icons.expand_less_outlined
                            : Icons.expand_more_outlined,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
              Visibility(visible: _showTeams, child: Text("Times")),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'Departamentos',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _showDepartment = !_showDepartment;
                          _showTeams = false;
                          _showEmployers = false;
                        });
                      },
                      child: Icon(
                        _showDepartment
                            ? Icons.expand_less_outlined
                            : Icons.expand_more_outlined,
                        size: 30,
                      ),
                    ),
                  )
                ],
              ),
              Visibility(
                  visible: _showDepartment, child: Text("Departamentos")),
              Container(
                margin: EdgeInsets.only(top: 250),
                height: 50,
                width: 320,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(87, 103, 222, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (context) {
                    //     return CreateEventPeople(
                    //         this.widget._employer,
                    //         this.widget._selectedEvent,
                    //         this.date,
                    //         this.time,
                    //         this.selectedPlace);
                    //   }),
                    // );
                  },
                  child: Text(
                    'Confirmar',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
