import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../all_constants.dart';
import '../../questions_answers_file.dart';
import '../../reusable_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndexNumber = 0;
  double _initial = 0.1;

  @override
  Widget build(BuildContext context) {
    String value = (_initial * 10).toStringAsFixed(0);
    return Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
            centerTitle: true,
            title: Text("Computer Science Flashcards App", style: TextStyle(fontSize: 20)),
            backgroundColor: mainColor,
            toolbarHeight: 80,
            elevation: 5,
            shadowColor: mainColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Question $value of 10", style: otherTextStyle),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.blueGrey,
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                      minHeight: 5,
                      value: _initial,
                    ),
                  ),
                  SizedBox(height: 25),
                  SizedBox(
                      width: 300,
                      height: 300,
                      child: FlipCard(
                          direction: FlipDirection.VERTICAL,
                          front: ReusableCard(
                              text: quesAnsList[_currentIndexNumber].question),
                          back: ReusableCard(
                              text: quesAnsList[_currentIndexNumber].answer))),
                  Text("Tap to see Answer", style: otherTextStyle),
                  SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly
                      ,
                      children: <Widget>[
                        ElevatedButton.icon(
                            onPressed: () {
                              showPreviousCard();
                              updateToPrev();
                            },
                            icon: Icon(FontAwesomeIcons.chevronLeft, size: 20),
                            label: Text(""),
                            style: ElevatedButton.styleFrom(
                                primary: mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.only(
                                    right: 20, left: 25, top: 15, bottom: 15))),
                        ElevatedButton.icon(
                            onPressed: () {
                              showNextCard();
                              updateToNext();
                            },
                            icon: Icon(FontAwesomeIcons.chevronRight, size: 20),
                            label: Text(""),
                            style: ElevatedButton.styleFrom(
                                primary: mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                padding: EdgeInsets.only(
                                    right: 20, left: 25, top: 15, bottom: 15)))
                      ])
                ])));
  }

  void updateToNext() {
    setState(() {
      _initial = _initial + 0.1;
      if (_initial > 1.0) {
        _initial = 0.1;
      }
    });
  }

  void updateToPrev() {
    setState(() {
      _initial = _initial - 0.1;
      if (_initial < 0.1) {
        _initial = 1.0;
      }
    });
  }

  void showNextCard() {
    setState(() {
      _currentIndexNumber = (_currentIndexNumber + 1 < quesAnsList.length)
          ? _currentIndexNumber + 1
          : 0;
    });
  }

  void showPreviousCard() {
    setState(() {
      _currentIndexNumber = (_currentIndexNumber - 1 >= 0)
          ? _currentIndexNumber - 1
          : quesAnsList.length - 1;
    });
  }
}