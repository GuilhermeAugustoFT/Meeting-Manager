import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/pages/hero_dialog_route.dart';

class CardContent extends StatelessWidget {
  /// {@macro todo_card}

  var containerColor = Color.fromRGBO(230, 230, 230, 1);
  var eventType = 'Reunião';
  var eventDate = '12/12/21';
  var eventTime = '12:12';
  var eventPlace = 'Sala do cafézinho';

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
                          margin: EdgeInsets.only(left: 10),
                          child: Text(
                            eventType,
                            style: GoogleFonts.inter(
                              fontSize: 27,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.edit,
                            size: 35,
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
                              eventDate,
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
                              eventDate,
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
                        eventPlace,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                    ), // aqui vem a lista de participantes
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.delete_outline,
                        size: 50,
                        color: Colors.red,
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
