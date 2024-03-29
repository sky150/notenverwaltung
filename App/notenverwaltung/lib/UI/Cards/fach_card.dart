import 'package:flutter/material.dart';
import 'package:notenverwaltung/global.dart';

class FachCard extends StatelessWidget {
  const FachCard(
      {Key key,
      this.fachName,
      this.weight,
      this.fachAvg,
      this.press,
      this.longPress})
      : super(key: key);

  final String fachName, weight;
  final double fachAvg;
  final Function press;
  final Function longPress;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding / 2,
      ),
      width: size.width * 0.9,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: press,
            onLongPress: longPress,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Color(0xff343a40),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$fachName\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "Gewichtung: $weight \%".toUpperCase(),
                          style: TextStyle(
                            color: Color(0xffced4da).withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text('$fachAvg',
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: ((this.fachAvg == null)
                                ? Colors.transparent
                                : (this.fachAvg < 4.0)
                                    ? kTextRed
                                    : (this.fachAvg < 5.0 && this.fachAvg > 4.0)
                                        ? kTextYellow
                                        : kTextGreen),
                          ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
