import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:project/models/department_repository.dart';
import 'package:project/models/employer_repository.dart';
import 'package:project/models/event_repository.dart';
import 'package:project/models/team_repository.dart';
import '../home_page.dart';
import 'add_people_page.dart';
import 'delete_people_page.dart';

class EditEventPage extends StatefulWidget {
  var _id;
  var _eventType;
  var _eventCreator;
  var _dateTime;
  var _place;
  var _participants;

  EditEventPage(this._id, this._eventType, this._eventCreator, this._dateTime,
      this._place, this._participants);

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  var scrumTypes = [
    'Reunião',
    'Mini curso',
    'Palestra',
    'Apresentação',
    'Backlog do produto',
    'Sprint backlog',
    'Daily meeting',
    'Sprint review',
    'Sprint Retropesctive'
  ];

  var places = [
    'Sala de reunião',
    'Sala do cafézinho',
    'Pátio',
    'Google Meet',
    'Sala do diretor'
  ];

  var scrumType = 'Reunião';
  var place = "Sala de reunião";

  var date;
  var time;

  pickDate(BuildContext context) async {
    var selectedDate;
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(DateTime.now().year),
        lastDate: DateTime(DateTime.now().year + 10));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        date = '';
        date += DateFormat.d().format(selectedDate).padLeft(2, '0');
        date += '/' + DateFormat.M().format(selectedDate).padLeft(2, '0');
        date += '/' + DateFormat.y().format(selectedDate);
      });
  }

  Future<Null> pickTime(BuildContext context) async {
    var selectedTime;
    var hour;
    var minute;

    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 12, minute: 0),
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        hour = selectedTime.hour.toString().padLeft(2, '0');
        minute = selectedTime.minute.toString().padLeft(2, '0');
        time = hour + ':' + minute;
      });
  }

  @override
  void initState() {
    super.initState();
    date = '';
    date += DateFormat.d().format(this.widget._dateTime).padLeft(2, '0');
    date += '/' + DateFormat.M().format(this.widget._dateTime).padLeft(2, '0');
    date += '/' + DateFormat.y().format(this.widget._dateTime);
    var hour = this.widget._dateTime.hour.toString().padLeft(2, '0');
    var minute = this.widget._dateTime.minute.toString().padLeft(2, '0');
    time = hour + ':' + minute;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Editar Evento',
          style: GoogleFonts.inter(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        alignment: Alignment.center,
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 30, left: 20),
              child: Text(
                'Tipo do Evento',
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 20),
              height: 60,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color.fromRGBO(230, 230, 230, 1),
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: DropdownButtonFormField<String>(
                    onTap: () {},
                    dropdownColor: Color.fromRGBO(230, 230, 230, 1),
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusColor: Colors.green),
                    value: this.widget._eventType,
                    isExpanded: true,
                    items: scrumTypes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            value,
                            style: GoogleFonts.inter(
                                fontSize: 20, color: Colors.black),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        this.widget._eventType = value;
                        scrumTypes.remove(value);
                        scrumTypes.insert(0, value);
                      });
                    }),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            pickDate(context);
                          });
                        },
                        child: Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.black,
                            size: 50,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          date,
                          style: GoogleFonts.inter(
                            fontSize: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    // espacar os containers
                    width: 60,
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // abrir relogio
                          setState(() {
                            pickTime(context);
                          });
                        },
                        child: Container(
                          height: 110,
                          width: 110,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: Icon(
                            Icons.schedule_outlined,
                            color: Colors.black,
                            size: 50,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          time,
                          style: GoogleFonts.inter(
                            fontSize: 25,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 30),
              height: 60,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color.fromRGBO(230, 230, 230, 1),
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: DropdownButtonFormField<String>(
                    onTap: () {},
                    dropdownColor: Color.fromRGBO(230, 230, 230, 1),
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusColor: Colors.green),
                    value: this.widget._place,
                    isExpanded: true,
                    items: places.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            value,
                            style: GoogleFonts.inter(
                                fontSize: 20, color: Colors.black),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        this.widget._place = value;
                        places.remove(value);
                        places.insert(0, value);
                      });
                    }),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(top: 30, left: 20),
              child: Text(
                'Editar Participantes',
                style: GoogleFonts.inter(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () async {
                      var employers =
                          await EmployerRepository.findAllEmployers();
                      var teams = await TeamRepository.findAllTeams();
                      var departments =
                          await DepartmentRepository.findAllDepartments();

                      for (var employer in employers)
                        if (employer.getNumber() ==
                            this.widget._eventCreator.getNumber()) {
                          employers.remove(employer);
                          break;
                        }

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AddPeoplePage(
                                this.widget._id,
                                this.widget._eventCreator,
                                employers,
                                teams,
                                departments,
                                employers);
                          },
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Adicionar',
                        style: GoogleFonts.inter(fontSize: 18),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return DeletePeoplePage(
                                this.widget._id,
                                this.widget._eventCreator,
                                this.widget._participants);
                          },
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 120,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Excluir',
                        style: GoogleFonts.inter(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50),
              height: 50,
              width: 320,
              decoration: BoxDecoration(
                color: Color.fromRGBO(87, 103, 222, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: TextButton(
                onPressed: () async {
                  print("$date $time");
                  var statusCode = await EventRepository.updateEventById(
                      this.widget._id,
                      this.widget._eventType,
                      "$date $time",
                      this.widget._place,
                      null,
                      null);

                  if (statusCode == 200) {
                    var events = await EmployerRepository.findEventsByNumber(
                        this.widget._eventCreator.getNumber());

                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            HomePage(events, this.widget._eventCreator)));
                  }
                },
                child: Text(
                  'Salvar Evento',
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
    );
  }
}
