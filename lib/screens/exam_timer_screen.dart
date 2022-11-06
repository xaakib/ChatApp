import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GoogleSigninSc extends StatefulWidget {
  const GoogleSigninSc({super.key});

  @override
  State<GoogleSigninSc> createState() => _GoogleSigninScState();
}

class _GoogleSigninScState extends State<GoogleSigninSc> {
  Timer? countdownTimer;
  Duration myDuration = Duration(seconds: 10);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    setState(() => countdownTimer!.cancel());
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    setState(() => myDuration = Duration(seconds: 10));
  }

  // Step 6
  void setCountDown() {
    final reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds <= 0) {
        countdownTimer!.cancel();
        submit();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exam"),
      ),
      body: Container(
          child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: listOfQestion.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        hoverColor: Colors.red,
                        title: Text(listOfQestion[index]['question']),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Card(
                                  color: Colors.black87,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Q.N ${index + 1}",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Card(
                                  color: Colors.black87,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "MARKS: 1",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                selectOption(listOfQestion[index]['a'], index);
                              },
                              child: Card(
                                color: listOfQestion[index]['selected'] ==
                                        listOfQestion[index]['a']
                                    ? Colors.green
                                    : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(listOfQestion[index]['a']),
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  selectOption(
                                      listOfQestion[index]['b'], index);
                                },
                                child: Card(
                                  color: listOfQestion[index]['selected'] ==
                                          listOfQestion[index]['b']
                                      ? Colors.green
                                      : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(listOfQestion[index]['b']),
                                  ),
                                )),
                            InkWell(
                                onTap: () {
                                  selectOption(
                                      listOfQestion[index]['c'], index);
                                },
                                child: Card(
                                  color: listOfQestion[index]['selected'] ==
                                          listOfQestion[index]['c']
                                      ? Colors.green
                                      : Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(listOfQestion[index]['c']),
                                  ),
                                )),
                            InkWell(
                              onTap: () {
                                selectOption(listOfQestion[index]['d'], index);
                              },
                              child: Card(
                                color: listOfQestion[index]['selected'] ==
                                        listOfQestion[index]['d']
                                    ? Colors.green
                                    : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(listOfQestion[index]['d']),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            submit();
          },
          child: Icon(Icons.check)),
      bottomNavigationBar: Container(
        color: Colors.black45,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            "${myDuration.inMinutes.remainder(60)} : ${myDuration.inSeconds.remainder(60)}",
            style: TextStyle(fontSize: 25),
          )),
        ),
      ),
    );
  }

  int totalScore = 0;
  void selectOption(String opt, int index) {
    listOfQestion[index]['selected'] = opt;
    setState(() {});
  }

  void submit() {
    totalScore = 0;
    for (var i = 0; i < listOfQestion.length; i++) {
      if (listOfQestion[i]['correct'] == listOfQestion[i]['selected']) {
        totalScore++;
      }
    }
    print("totalScore::::$totalScore");
    var snackBar = SnackBar(
      content: Text('Your total score $totalScore!'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

List listOfQestion = [
  {
    "question": "ENTREPRENEUR : PROFITS :",
    "a": "Philanthropist : Charity",
    "b": "Organizer : Union",
    "c": "Hermit : Lonely",
    "d": "Scholar : Knowledg",
    "correct": "Scholar : Knowledg",
    "explain": "",
    "": ""
  },
  {
    "question": "BIOGRAPHY : AUTOBIOGRAPHY ::",
    "a": "dead : living",
    "b": "testimony : confession",
    "c": "mobile : automobile",
    "d": "author : performer",
    "correct": "testimony : confession",
    "explain": "",
    "": ""
  },
  {
    "question": "ABHOR : DISLIKE ::",
    "a": "chastise : punish",
    "b": "win : defeat",
    "c": "qualify : limit",
    "d": "ruin : damage",
    "correct": "ruin : damage",
    "explain": "",
    "": ""
  },
  {
    "question": "AFFLUENT : IMPOVERISHED : :",
    "a": ". impecunious : needy",
    "b": "rich : poor",
    "c": "wealthy : opulent",
    "d": "sick: sad",
    "correct": "rich : poor",
    "explain": "",
    "": ""
  },
  {
    "question": "COTTON : RAYON ::",
    "a": "sheets : dresses",
    "b": "synthetic : natural",
    "c": "summer : winter",
    "d": "natural : synthetic",
    "correct": "synthetic : natural",
    "explain": "",
    "": ""
  },
  {
    "question": "HEART : HUMAN ::",
    "a": "tail : dog",
    "b": "hand : child",
    "c": "kitchen : house",
    "d": "engine : car",
    "correct": "engine : car",
    "explain": "",
    "": ""
  },
  {
    "question": "CONSTELLATION : STAR ::",
    "a": "sun: milky way",
    "b": "telescope : astronomer",
    "c": "solar system : planet",
    "d": "quasar : comet",
    "correct": "solar system : planet",
    "explain": "",
    "": ""
  },
  {
    "question": "HANDWRITING : SIGNATURE ::",
    "a": "biographer : confession",
    "b": "painting : self-portrait",
    "c": "eulogy : speech",
    "d": "sculptor : model",
    "correct": "painting : self-portrait",
    "explain": "",
    "": ""
  },
  {
    "question": "GERM : DISEASE ::",
    "a": "trichinosis",
    "b": "men",
    "c": "war : destruction",
    "d": "insurance : premium",
    "correct": "war : destruction",
    "explain": "",
    "": ""
  },
];
