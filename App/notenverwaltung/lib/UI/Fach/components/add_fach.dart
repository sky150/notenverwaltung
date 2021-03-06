import 'package:flutter/material.dart';
import 'package:notenverwaltung/UI/TextFields/MyTextFormField.dart';
import 'package:notenverwaltung/fach_page.dart';
import 'package:notenverwaltung/models/fach.dart';
import 'package:notenverwaltung/components/my_bottom_nav_bar.dart';
import 'package:notenverwaltung/global.dart';
import 'package:notenverwaltung/models/note.dart';
import 'dart:async';

class AddFach extends StatefulWidget {
  final int id;
  final int semesterId;
  AddFach({this.id, this.semesterId}) : super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    print("AddFach id= " +
        id.toString() +
        " semesterId: " +
        semesterId.toString());
    return _FormState(semesterId: semesterId);
  }
}

class _FormState extends State<AddFach> {
  final int semesterId;
  _FormState({this.semesterId}) : super();
  Fach fach = Fach();
  bool isLoadedSemester = false;

  @override
  Widget build(BuildContext context) {
    print("Semester id: " + semesterId.toString());
    return Scaffold(
      appBar: buildAppBar(),
      body: FutureBuilder(
        future: getFachById(widget.id),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          if (snapshot.hasData) {
            print("Widget id: " + widget.id.toString());
            return DetailFach(fach: snapshot.data, semesterId: semesterId);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text('Neues Fach'),
      elevation: 0,
    );
  }
}

class DetailFach extends StatefulWidget {
  final Fach fach;
  final int semesterId;
  DetailFach({Key key, this.fach, this.semesterId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DetailFachState(semesterId: semesterId);
  }
}

class _DetailFachState extends State<DetailFach> {
  Fach fach = new Fach();
  bool isLoadedSemester = false;
  final int semesterId;
  _DetailFachState({this.semesterId}) : super();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.0;
    // TODO: implement build
    if (widget.fach.id == null) {
      setState(() {
        this.isLoadedSemester = false;
      });
    } else {
      setState(() {
        this.fach = Fach.fromFach(widget.fach);
        this.isLoadedSemester = true;
      });
    }

    String wunschNoteValue = this.fach.wunschNote.toString();
    if (wunschNoteValue == 'null') {
      wunschNoteValue = '';
    }
    TextEditingController fachName =
        TextEditingController(text: this.fach.name);
    TextEditingController fachGewichtung =
        TextEditingController(text: this.fach.gewichtung);
    TextEditingController fachWunschNote =
        TextEditingController(text: wunschNoteValue);

    final MyTextFormField txtName = MyTextFormField(
      controller: fachName,
      labelText: 'Fach Name',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Gib den Fach Name ein';
        }
        if (value.length > 40) {
          return 'Fach Name zu lang';
        }
        return null;
      },
      textAlign: TextAlign.left,
      autocorrect: false,
      onChanged: (text) {
        print(text);
      },
    );
    final MyTextFormField txtGewichtung = MyTextFormField(
      controller: fachGewichtung,
      labelText: 'Gewichtung',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Gib die Gewichtung ein';
        }
        if (value.length > 3) {
          return 'Ungültige Gewichtung';
        }
        return null;
      },
      textAlign: TextAlign.left,
      autocorrect: false,
      onChanged: (text) {
        print(text);
      },
    );
    final MyTextFormField txtWunschNote = MyTextFormField(
      controller: fachWunschNote,
      labelText: 'Wunschnote',
      validator: (String value) {
        if (value.isEmpty) {
          return 'Gib die Gewichtung ein';
        }
        return null;
      },
      textAlign: TextAlign.left,
      autocorrect: false,
    );
    final btnSave = RaisedButton(
      color: kPrimaryColor,
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          if (isLoadedSemester) {
            print("entered in update");
            await updateFach(
                this.fach.id,
                this.fach.durchschnitt,
                this.fach.wunschNote,
                fachName,
                fachGewichtung,
                this.fach.semesterId);

            Timer(Duration(seconds: 1), () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FachScreen(semesterId: this.fach.semesterId),
                ),
              );
            });
          }
          if (!isLoadedSemester) {
            print("the id" + this.semesterId.toString());
            await createFach(
                fachName, fachGewichtung, fachWunschNote, this.semesterId);
            print("entered in create fach");
            Timer(Duration(seconds: 1), () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => FachScreen(semesterId: this.semesterId),
                ),
              );
            });
          }
        }
      },
      child: Text(
        'Speichern',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
    final container = Container(
        alignment: Alignment.bottomCenter,
        width: halfMediaWidth * 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(alignment: Alignment.topCenter, child: txtName),
            Container(alignment: Alignment.topCenter, child: txtGewichtung),
            Container(alignment: Alignment.topCenter, child: txtWunschNote),
            Container(alignment: Alignment.topCenter, child: btnSave)
          ],
        ));
    return Form(key: _formKey, child: container);
  }
}
