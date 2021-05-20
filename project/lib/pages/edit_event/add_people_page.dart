import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/department.dart';
import 'package:project/models/employer.dart';
import 'package:project/models/employer_repository.dart';
import 'package:project/models/event_repository.dart';
import 'package:project/models/team.dart';
import 'package:project/pages/home_page.dart';
import 'package:sms/sms.dart';

class AddPeoplePage extends StatefulWidget {
  var _event;
  var _employer;
  var _employers;
  var _teams;
  var _departments;
  var _selectedList;

  AddPeoplePage(this._event, this._employer, this._employers, this._teams,
      this._departments, this._selectedList);

  @override
  _AddPeoplePageState createState() => _AddPeoplePageState(this._event,
      this._employers, this._teams, this._departments, this._selectedList);
}

class _AddPeoplePageState extends State<AddPeoplePage> {
  var _event;
  var _employers;
  var _teams;
  var _departments;

  var containerColor = Color.fromRGBO(230, 230, 230, 1);
  var participants = ['Funcionários', 'Times', 'Departamentos'];

  var selectedParticipants = [];
  var selectedColor = Color.fromRGBO(190, 190, 190, 1);
  var _selectedList;

  _AddPeoplePageState(this._event, this._employers, this._teams,
      this._departments, this._selectedList);

  getNickname(object) {
    if (object is Employer) return object.getNickname();

    return "";
  }

  sendSms(number) async {
    SmsSender sender = new SmsSender();
    var titleMessage =
        "${this._event.getName()} | Criador: ${this._event.getEventCreator().getName()}";

    await sender.sendSms(new SmsMessage(number, titleMessage));

    var day = "${this._event.getDateTime().day}";
    var month = "${this._event.getDateTime().month}";

    if (this._event.getDateTime().day < 10)
      day = "0${this._event.getDateTime().day}";

    if (this._event.getDateTime().month < 10)
      month = "0${this._event.getDateTime().month}";

    var message =
        "Local: ${this._event.getPlace()} | Data: $day/$month/${this._event.getDateTime().year}";
    await sender.sendSms(new SmsMessage(number, message));

    var hours = "${this._event.getDateTime().hour}";
    var minutes = "${this._event.getDateTime().minute}";

    if (this._event.getDateTime().hour < 10)
      hours = "0${this._event.getDateTime().hour}";

    if (this._event.getDateTime().minute < 10)
      minutes = "0${this._event.getDateTime().minute}";

    var time = "Horário: $hours:$minutes";

    await sender.sendSms(new SmsMessage(number, time));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Novo Participante',
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
                                                "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/s75-c-fbw=1/photo.jpg"),
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
                                          color:
                                              Color.fromRGBO(87, 103, 222, 1),
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
                    var statusCode = await EventRepository.updateEventById(
                        this._event.getId(),
                        null,
                        null,
                        null,
                        selectedParticipants,
                        null);

                    if (statusCode == 200) {
                      var events = await EmployerRepository.findEventsByNumber(
                          this.widget._employer.getNumber());

                      for (var participant in selectedParticipants) {
                        if (participant is Employer)
                          await sendSms(participant.getNumber());
                        else if (participant is Team)
                          await sendSms(
                              participant.getTeamLeader().getNumber());
                        else if (participant is Department)
                          for (var departmentMember
                              in participant.getMembersDepartment())
                            await sendSms(departmentMember.getNumber());
                      }

                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return HomePage(events, this.widget._employer);
                        }),
                      );
                    } else
                      print("Erro inserir evento");
                  },
                  child: Text(
                    'Inserir participantes',
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
