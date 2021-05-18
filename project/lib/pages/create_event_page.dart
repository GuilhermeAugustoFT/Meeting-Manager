import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/pages/create_event_place.dart';

class CreateEvent extends StatefulWidget {
  var _employer;

  CreateEvent(this._employer);

  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  var defaultColor = Color.fromRGBO(87, 103, 222, 1);
  var containerColor = Color.fromRGBO(230, 230, 230, 1);
  var selected = 0;
  var textColor = Colors.black;
  var inDropDown = false;
  var selectedEvent = '';

  var scrumTypes = [
    'Backlog do produto',
    'Sprint backlog',
    'Daily meeting',
    'Sprint review',
    'Sprint Retropesctive'
  ];

  var scrumType = 'Backlog do produto';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Tipo de evento',
          style: GoogleFonts.inter(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 50),
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: [
              // Container(
              //   alignment: Alignment.topLeft,
              //   child: Text(
              //     'Selecione o tipo do evento',
              //     style: GoogleFonts.inter(
              //       fontSize: 27,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 1;
                        selectedEvent = 'Reunião';
                        inDropDown = false;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: selected == 1 ? defaultColor : containerColor,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Reunião',
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              color:
                                  selected == 1 ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 2;
                        selectedEvent = 'Mini Curso';
                        inDropDown = false;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: selected == 2 ? defaultColor : containerColor,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Mini curso',
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              color:
                                  selected == 2 ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 3;
                        selectedEvent = 'Palestra';
                        inDropDown = false;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: selected == 3 ? defaultColor : containerColor,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Palestra',
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              color:
                                  selected == 3 ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 4;
                        selectedEvent = 'Apresentação';
                        inDropDown = false;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 50),
                      height: 60,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: selected == 4 ? defaultColor : containerColor,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Apresentação',
                          style: GoogleFonts.inter(
                              fontSize: 20,
                              color:
                                  selected == 4 ? Colors.white : Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  color: containerColor,
                ),
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    color: selected == 5 ? defaultColor : containerColor,
                  ),
                  child: DropdownButtonFormField<String>(
                      onTap: () {
                        inDropDown = false;
                      },
                      dropdownColor: containerColor,
                      decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusColor: Colors.green),
                      value: scrumType,
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
                                fontSize: 20,
                                color: selected == 5 && !inDropDown
                                    ? textColor
                                    : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          scrumType = value;
                          textColor = Colors.white;
                          selected = 5;
                          selectedEvent = value;
                          inDropDown = true;
                          scrumTypes.remove(value);
                          scrumTypes.insert(0, value);
                        });
                      }),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 220),
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
                    if (selected == 0)
                      showAlertDialog(context);
                    else {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) {
                          return CreateEventPlace(
                              this.widget._employer, this.selectedEvent);
                        }),
                      );
                    }
                  },
                  child: Text(
                    'Continuar',
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

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Escolha um tipo"),
      content: Text("Selecione um tipo de evento"),
      actions: [],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
