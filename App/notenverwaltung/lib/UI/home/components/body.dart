import 'package:flutter/material.dart';
import 'package:notenverwaltung/models/global.dart';

import 'featurred_plants.dart';
import 'header_with_seachbox.dart';
import 'semester.dart';
import '../../../components/title_with_more_bbtn.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderWithSearchBox(size: size),
          TitleWithMoreBtn(title: "Semester", press: () {}),
          Semester(),
          TitleWithMoreBtn(title: "Statistiken", press: () {}),
          FeaturedPlants(),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}