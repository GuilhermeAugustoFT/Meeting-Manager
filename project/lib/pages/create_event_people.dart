import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/employer.dart';
import 'package:project/models/employer_repository.dart';
import 'package:project/models/event_repository.dart';
import 'package:project/pages/home_page.dart';
import 'package:sms/sms.dart';

class CreateEventPeople extends StatefulWidget {
  var _employer;
  var _selectedEvent;
  var _date;
  var _time;
  var _place;
  var _employers;
  var _teams;
  var _departments;
  var _selectedList;

  CreateEventPeople(
      this._employer,
      this._selectedEvent,
      this._date,
      this._time,
      this._place,
      this._employers,
      this._teams,
      this._departments,
      this._selectedList);

  @override
  _CreateEventPeopleState createState() => _CreateEventPeopleState(
      this._employers, this._teams, this._departments, this._selectedList);
}

class _CreateEventPeopleState extends State<CreateEventPeople> {
  var _showEmployers = false;
  var _showTeams = false;
  var _showDepartment = false;

  var _employers;
  var _teams;
  var _departments;

  var containerColor = Color.fromRGBO(230, 230, 230, 1);
  var participants = ['Funcionários', 'Times', 'Departamentos'];

  var selectedParticipants = [];
  var selectedColor = Color.fromRGBO(190, 190, 190, 1);
  var _selectedList;

  getNickname(object) {
    if (object is Employer) return object.getNickname();

    return "";
  }

  _CreateEventPeopleState(
      this._employers, this._teams, this._departments, this._selectedList);

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
      body: Container(
        height: double.infinity,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, left: 40, right: 40),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: containerColor,
              ),
              child: DropdownButtonFormField<String>(
                  dropdownColor: containerColor,
                  decoration: InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusColor: Colors.green),
                  value: 'Funcionários',
                  isExpanded: true,
                  items: participants
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          value,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      participants.remove(value);
                      participants.insert(0, value);

                      setState(() {
                        if (value == "Funcionários")
                          _selectedList = this._employers;
                        else if (value == "Times")
                          _selectedList = this._teams;
                        else
                          _selectedList = this._departments;
                      });
                    });
                  }),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              height: 500,
              child: ListView.builder(
                  itemCount: _selectedList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 120,
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Card(
                        color: selectedParticipants
                                .contains(this._selectedList[index])
                            ? selectedColor
                            : Colors.white,
                        elevation: 10,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (selectedParticipants
                                  .contains(this._selectedList[index])) {
                                selectedParticipants
                                    .remove(this._selectedList[index]);
                                return;
                              }

                              selectedParticipants
                                  .add(this._selectedList[index]);
                            });
                          },
                          child: Row(
                            children: [
                              Container(
                                height: 80,
                                width: 80,
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    color: Colors.orange,
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: _selectedList[index] is Employer
                                            ? NetworkImage(
                                                _selectedList[index].getPhoto(),
                                              )
                                            : NetworkImage(
                                                "https://th.bing.com/th/id/OIP.hV6MoBaE8NYeMCugmhd7_QHaEo?pid=ImgDet&rs=1"),
                                        fit: BoxFit.fill)),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 15),
                                      child: Text(
                                          _selectedList[index].getName(),
                                          style: GoogleFonts.inter(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold))),
                                  Visibility(
                                    visible: _selectedList[0] is Employer
                                        ? true
                                        : false,
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        margin:
                                            EdgeInsets.only(top: 5, left: 15),
                                        child: Text(
                                            getNickname(_selectedList[index]),
                                            style: GoogleFonts.inter(
                                              fontSize: 15,
                                            ))),
                                  ),
                                  Visibility(
                                      visible: selectedParticipants.contains(
                                              this._selectedList[index])
                                          ? true
                                          : false,
                                      child: Container(
                                        margin:
                                            EdgeInsets.only(left: 15, top: 7),
                                        child: Icon(
                                          Icons.check_circle_outline_sharp,
                                          color: Colors.black,
                                        ),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            Container(
                margin: EdgeInsets.only(top: 20),
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
                    print(
                        "Name: ${this.widget._selectedEvent} \n Creator number: ${this.widget._employer.getNumber()} \n Place: ${this.widget._place} \n Date: ${this.widget._date} \n Time: ${this.widget._time}");

                    print('\n\n');
                    for (var participant in selectedParticipants)
                      print(participant.toString());

                    var statusCode = await EventRepository.insertEvent(
                        this.widget._selectedEvent,
                        this.widget._employer,
                        selectedParticipants,
                        this.widget._place,
                        this.widget._date,
                        this.widget._time);

                    if (statusCode == 200) {
                      for (var participant in selectedParticipants) {
                        if (participant is Employer) {
                          SmsSender sender = new SmsSender();
                          print(participant.getNumber());
                          var titleMessage =
                              "${this.widget._selectedEvent} | Criador: ${this.widget._employer.getName()}";
                          await sender.sendSms(new SmsMessage(
                              participant.getNumber(), titleMessage));

                          var message =
                              "Local: ${this.widget._place} | Data: ${this.widget._date}";
                          await sender.sendSms(
                              new SmsMessage(participant.getNumber(), message));
                        }
                      }

                      var events = await EmployerRepository.findEventsByNumber(
                          this.widget._employer.getNumber());
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return HomePage(events, this.widget._employer);
                        }),
                      );
                    } else
                      print("Erro inserir evento");
                  },
                  child: Text(
                    'Criar Evento',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
