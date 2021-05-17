import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/pages/card_content.dart';
import 'package:project/pages/create_event_page.dart';
import 'package:project/pages/hero_dialog_route.dart';

class HomePage extends StatefulWidget {
  var _events;

  HomePage(this._events);

  @override
  _HomePageState createState() => _HomePageState(this._events);
}

class _HomePageState extends State<HomePage> {
  var _events;

  _HomePageState(this._events);

  var defaultColor = Color.fromRGBO(87, 103, 222, 1);

  getDate(DateTime dateTime) {
    var day = "${dateTime.day}";
    var month = "${dateTime.month}";
    if (dateTime.day < 10) day = "0${dateTime.day}";

    if (dateTime.month < 10) month = "0${dateTime.month}";

    return "$day/$month/${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Home',
            style: GoogleFonts.inter(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: Center(
        child: Stack(children: [
          Container(
            child: ListView.builder(
              itemCount: this._events.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 350,
                    height: 80,
                    child: Card(
                      color: Color.fromRGBO(230, 230, 230, 1),
                      elevation: 7,
                      child: Hero(
                        tag: 'teste',
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(HeroDialogRoute(builder: (context) {
                              return CardContent(this._events[index]);
                            }));
                          },
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 13, top: 7),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  this._events[index].getName(),
                                  style: GoogleFonts.inter(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 13, top: 5),
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      this._events[index].getPlace(),
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    margin: EdgeInsets.only(
                                        left: 50, right: 5, top: 5),
                                    child: Icon(
                                      Icons.calendar_today,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 5, right: 0),
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      getDate(
                                          this._events[index].getDateTime()),
                                      style: GoogleFonts.inter(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return CreateEvent();
                  }),
                );
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 30),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: defaultColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
                child: Icon(
                  Icons.add,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
