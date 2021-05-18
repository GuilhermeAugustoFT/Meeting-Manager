import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/employer.dart';
import 'package:project/models/employer_repository.dart';
import 'package:project/models/event_repository.dart';
import 'package:project/pages/home_page.dart';
import 'package:sms/sms.dart';

class EditPeoplePage extends StatefulWidget {
  var _adding;
  var _participants;
  var _id;
  var _name;
  var _date;
  var _place;
  var _eventCreator;

  EditPeoplePage(this._id, this._name, this._eventCreator, this._date,
      this._place, this._adding, this._participants);

  @override
  _EditPeoplePageState createState() => _EditPeoplePageState();
}

class _EditPeoplePageState extends State<EditPeoplePage> {
  var containerColor = Color.fromRGBO(230, 230, 230, 1);

  var selectedParticipants = [];
  var selectedColor = Color.fromRGBO(190, 190, 190, 1);

  getNickname(object) {
    if (object is Employer) return object.getNickname();

    return "";
  }

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
              margin: EdgeInsets.only(top: 15),
              height: 500,
              child: ListView.builder(
                  itemCount: this.widget._participants.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 120,
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                      child: Card(
                        color: selectedParticipants
                                .contains(this.widget._participants[index])
                            ? selectedColor
                            : Colors.white,
                        elevation: 10,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (selectedParticipants
                                  .contains(this.widget._participants[index])) {
                                selectedParticipants
                                    .remove(this.widget._participants[index]);
                                return;
                              }

                              selectedParticipants
                                  .add(this.widget._participants[index]);
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
                                        image: this.widget._participants[index]
                                                is Employer
                                            ? NetworkImage(
                                                this
                                                    .widget
                                                    ._participants[index]
                                                    .getPhoto(),
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
                                          this
                                              .widget
                                              ._participants[index]
                                              .getName(),
                                          style: GoogleFonts.inter(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold))),
                                  Visibility(
                                    visible:
                                        this.widget._participants[0] is Employer
                                            ? true
                                            : false,
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        margin:
                                            EdgeInsets.only(top: 5, left: 15),
                                        child: Text(
                                            getNickname(this
                                                .widget
                                                ._participants[index]),
                                            style: GoogleFonts.inter(
                                              fontSize: 15,
                                            ))),
                                  ),
                                  Visibility(
                                      visible: selectedParticipants.contains(
                                              this.widget._participants[index])
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
                    for (var selectedParticipant in selectedParticipants)
                      print(selectedParticipant.toString());

                    if (this.widget._adding) {
                      var statusCode = await EventRepository.updateEventById(
                          this.widget._id,
                          this.widget._name,
                          this.widget._date,
                          this.widget._place,
                          selectedParticipants,
                          null);
                      if (statusCode == 200) {
                        for (var participant in selectedParticipants) {
                          if (participant is Employer) {
                            SmsSender sender = new SmsSender();
                            print(participant.getNumber());
                            var titleMessage =
                                "${this.widget._name} | Criador: ${this.widget._eventCreator.getName()}";
                            await sender.sendSms(new SmsMessage(
                                participant.getNumber(), titleMessage));

                            var message =
                                "Local: ${this.widget._place} | Data: ${this.widget._date}";
                            await sender.sendSms(new SmsMessage(
                                participant.getNumber(), message));
                          }
                        }
                      } else
                        print("Erro inserir evento");
                    } else {
                      await EventRepository.updateEventById(
                          this.widget._id,
                          this.widget._name,
                          this.widget._date,
                          this.widget._place,
                          null,
                          selectedParticipants);
                    }
                  },
                  child: Text(
                    this.widget._adding
                        ? 'Adicionar Participantes'
                        : 'Excluir Participantes',
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
