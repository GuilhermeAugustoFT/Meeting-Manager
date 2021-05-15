import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CreateEventPlace extends StatefulWidget {
  @override
  _CreateEventPlaceState createState() => _CreateEventPlaceState();
}

class _CreateEventPlaceState extends State<CreateEventPlace> {
  var date = '__/__/__';
  var time = '__:__';
  var containerColor = Color.fromRGBO(230, 230, 230, 1);
  var places = [
    'Sala de reunião',
    'Sala do cafézinho',
    'Pátio',
    'Google Meet',
  ];
  var selectedPlace = 'Sala de reunião';

  Future<Null> pickDate(BuildContext context) async {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Data e Local',
          style: GoogleFonts.inter(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          //abrir calendario
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
              Container(
                margin: EdgeInsets.only(top: 50, left: 50, right: 50),
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
                    value: selectedPlace,
                    isExpanded: true,
                    items: places.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            value,
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (String value) {
                      setState(() {
                        selectedPlace = value;

                        places.remove(value);
                        places.insert(0, value);
                      });
                    }),
              ),
              Container(
                margin: EdgeInsets.only(top: 250),
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
                    //passar selectedEvent como parametro
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        // return CreateEventPeople();
                      }),
                    );
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
}
