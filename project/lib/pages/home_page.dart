import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/pages/create_event_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var defaultColor = Color.fromRGBO(87, 103, 222, 1);

  var events = ['opa', 'salve'];
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
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: Center(
        child: Stack(children: [
          Container(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 350,
                    height: 80,
                    child: Card(
                      color: Color.fromRGBO(230, 230, 230, 1),
                      elevation: 7,
                      child: InkWell(
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 13, top: 7),
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Reunião',
                                style: GoogleFonts.inter(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 13),
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    'Sala do cafézinho',
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                    left: 50,
                                    right: 5,
                                  ),
                                  child: Icon(
                                    Icons.calendar_today,
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    '12/08/21',
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
                width: 70,
                height: 70,
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
