import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateEvent extends StatefulWidget {
  @override
  _CreateEventState createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  var defaultColor = Color.fromRGBO(87, 103, 222, 1);
  var containerColor = Color.fromRGBO(230, 230, 230, 1);
  var selected = 0;
  var scrumTypes = [
    'Backlog do produto',
    'Sprint backlog',
    'Daily meeting',
    'Sprint review',
    'Sprint Retropesctive'
  ];
  var scrumType = 'Backlog do produto';

  // var animalTypes = ['Cachorro', 'Gato'];
  // var animalType = 'Cachorro';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Selecione o tipo do evento',
                  style: GoogleFonts.inter(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selected = 1;
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
                              fontSize: 25,
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
                          'Mini Curso',
                          style: GoogleFonts.inter(
                              fontSize: 25,
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
                              fontSize: 25,
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
                      decoration:
                          InputDecoration(enabledBorder: InputBorder.none),
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
                                color:
                                    selected == 5 ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String value) {
                        setState(() {
                          scrumType = value;
                          selected = 5;
                        });
                      }),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 200),
                height: 60,
                width: 350,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(87, 103, 222, 1),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Continuar',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 25,
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
