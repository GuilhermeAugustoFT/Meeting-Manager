import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/employer.dart';
import 'package:project/models/employer_repository.dart';
import 'package:project/models/event_repository.dart';
import 'edit_event/edit_event_page.dart';
import 'home_page.dart';

class CardContent extends StatelessWidget {
  var containerColor = Color.fromRGBO(230, 230, 230, 1);
  var eventType = 'Reunião';
  var eventDate = '12/12/21';
  var eventTime = '12:12';
  var eventPlace = 'Sala do cafézinho';
  var _event;
  var _employer;

  CardContent(this._event, this._employer);

  getDate(DateTime dateTime) {
    var day = "${dateTime.day}";
    var month = "${dateTime.month}";
    if (dateTime.day < 10) day = "0${dateTime.day}";

    if (dateTime.month < 10) month = "0${dateTime.month}";

    return "$day/$month/${dateTime.year}";
  }

  getTime(DateTime dateTime) {
    var hours = "${dateTime.hour}";
    var minutes = "${dateTime.minute}";

    if (dateTime.hour < 10) hours = "0${dateTime.hour}";

    if (dateTime.minute < 10) minutes = "0${dateTime.minute}";

    return "$hours:$minutes";
  }

  getNickname(object) {
    if (object is Employer) return object.getNickname();

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        child: Hero(
          tag: 'teste',
          child: Padding(
            padding: const EdgeInsets.only(
                top: 180, bottom: 210, left: 40, right: 40),
            child: Material(
              color: containerColor,
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            this._event.getName(),
                            style: GoogleFonts.inter(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: this._event.getEventCreator().getNumber() ==
                                  this._employer.getNumber()
                              ? true
                              : false,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return EditEventPage(
                                        this._event,
                                        this._event.getName(),
                                        this._event.getEventCreator(),
                                        this._event.getDateTime(),
                                        this._event.getPlace(),
                                        this._event.getMembersEvent());
                                  },
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10, top: 10),
                              child: Icon(
                                Icons.edit,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Icon(
                              Icons.calendar_today,
                              size: 25,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5, top: 5),
                            child: Text(
                              getDate(this._event.getDateTime()),
                              style: GoogleFonts.inter(
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 30),
                            child: Icon(
                              Icons.schedule_outlined,
                              size: 25,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 5, top: 5),
                            child: Text(
                              getTime(this._event.getDateTime()),
                              style: GoogleFonts.inter(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        this._event.getPlace(),
                        style: GoogleFonts.inter(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Criador: ${this._event.getEventCreator().getName()}",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Container(
                      height: 170,
                      child: ListView.builder(
                          padding: EdgeInsets.only(top: 5),
                          itemCount: this._event.getMembersEvent().length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                margin: EdgeInsets.only(top: 5),
                                height: 80,
                                width: 50,
                                child: Card(
                                    color: Color.fromRGBO(190, 190, 190, 1),
                                    elevation: 10,
                                    child: Row(
                                      children: [
                                        Container(
                                            height: 60,
                                            width: 60,
                                            margin: EdgeInsets.only(left: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                shape: BoxShape.circle,
                                                // shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image: this
                                                                ._event
                                                                .getMembersEvent()[
                                                            index] is Employer
                                                        ? NetworkImage(
                                                            this
                                                                ._event
                                                                .getMembersEvent()[
                                                                    index]
                                                                .getPhoto(),
                                                          )
                                                        : NetworkImage(
                                                            "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/s75-c-fbw=1/photo.jpg"),
                                                    fit: BoxFit.fill))),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                    this
                                                        ._event
                                                        .getMembersEvent()[
                                                            index]
                                                        .getName(),
                                                    style: GoogleFonts.inter(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold))),
                                            Visibility(
                                              visible:
                                                  this._event.getMembersEvent()[
                                                          index] is Employer
                                                      ? true
                                                      : false,
                                              child: Container(
                                                  alignment: Alignment.topLeft,
                                                  margin: EdgeInsets.only(
                                                      top: 5, left: 10),
                                                  child: Text(
                                                      getNickname(this
                                                              ._event
                                                              .getMembersEvent()[
                                                          index]),
                                                      style: GoogleFonts.inter(
                                                        fontSize: 15,
                                                      ))),
                                            ),
                                          ],
                                        )
                                      ],
                                    )));
                          }),
                    ), // aqui vem a lista de participantes
                    Visibility(
                      visible: this._event.getEventCreator().getNumber() ==
                              this._employer.getNumber()
                          ? true
                          : false,
                      child: Container(
                        margin: EdgeInsets.only(top: 10),
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                          onTap: () async {
                            var statusCode =
                                await EventRepository.deleteEventById(
                                    this._event.getId());

                            if (statusCode == 200) {
                              var events =
                                  await EmployerRepository.findEventsByNumber(
                                      this._employer.getNumber());
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return HomePage(events, this._employer);
                                }),
                              );
                            }
                          },
                          child: Icon(
                            Icons.delete_outline,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
