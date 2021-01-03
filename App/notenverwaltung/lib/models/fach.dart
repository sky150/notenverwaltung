import 'package:http/http.dart' as http;
import 'package:notenverwaltung/global.dart';
import 'dart:convert';

class Fach {
  int id;
  String name;
  String gewichtung;
  double durchschnitt;
  int semesterId;

  Fach(
      {this.id,
      this.name,
      this.gewichtung,
      this.durchschnitt,
      this.semesterId});

  factory Fach.fromJson(Map<String, dynamic> json) {
    Fach newFach = Fach(
      id: json['fach_id'],
      name: json['fach_name'],
      gewichtung: json['fach_gewichtung'],
      durchschnitt: json['fach_durchschnitt'],
      semesterId: json['semester_id'],
    );
    return newFach;
  }
  factory Fach.fromFach(Fach anotherFach) {
    return Fach(
      id: anotherFach.id,
      name: anotherFach.name,
      gewichtung: anotherFach.gewichtung,
      durchschnitt: anotherFach.durchschnitt,
      semesterId: anotherFach.semesterId,
    );
  }
}

//Controller
Future<List<Fach>> getFaecher(int semesterId) async {
  final response = await http.get('$URL_FAECHER_BY_SEMESTER$semesterId');
  if (response.statusCode == 200) {
    List responseJson = json.decode(response.body.toString());
    List<Fach> fachList = createFachList(responseJson);
    print(fachList);
    for (int i = 0; i < fachList.length; i++) {
      print(fachList[i].id);
      print(fachList[i].name);
      print(fachList[i].durchschnitt);
      print(fachList[i].gewichtung);
      print(fachList[i].semesterId);
    }

    return fachList;
  } else {
    throw Exception('Failed to load note');
  }
}

List<Fach> createFachList(List data) {
  List<Fach> list = new List();

  for (int i = 0; i < data.length; i++) {
    int id = data[i]["fach_id"];
    String name = data[i]["fach_name"];
    String gewichtung = data[i]["fach_gewichtung"];
    double durchschnitt = data[i]["fach_durchschnitt"];
    int semesterId = data[i]["semester_id"];
    Fach fachObject = new Fach(
        id: id,
        name: name,
        durchschnitt: durchschnitt,
        gewichtung: gewichtung,
        semesterId: semesterId);
    list.add(fachObject);
  }
  return list;
}

Future deleteFach(int id) async {
  String status = '';
  final url = '$URL_FAECHER/$id';
  final response = await http.delete(url, headers: URL_HEADERS);
  if (response.statusCode == 200) {
    print('Fach deleted with this id: $id');
    status = 'DONE';
  } else {
    status = 'NOT_DONE';
  }
  return status;
}