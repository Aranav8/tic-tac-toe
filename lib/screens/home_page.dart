import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true;
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  List<String> displayXO = [
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
    '',
  ];

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayXO[index] == '') {
        displayXO[index] = 'o';
        filledBoxes += 1;
      } else if (!oTurn && displayXO[index] == '') {
        displayXO[index] = 'x';
        filledBoxes += 1;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displayXO[0] == displayXO[1] &&
        displayXO[0] == displayXO[2] &&
        displayXO[0] != '') {
      _showWinDialog(displayXO[0]);
    } else if (displayXO[0] == displayXO[3] &&
        displayXO[0] == displayXO[6] &&
        displayXO[0] != '') {
      _showWinDialog(displayXO[6]);
    } else if (displayXO[1] == displayXO[4] &&
        displayXO[1] == displayXO[7] &&
        displayXO[1] != '') {
      _showWinDialog(displayXO[7]);
    } else if (displayXO[2] == displayXO[5] &&
        displayXO[2] == displayXO[8] &&
        displayXO[2] != '') {
      _showWinDialog(displayXO[8]);
    } else if (displayXO[3] == displayXO[4] &&
        displayXO[3] == displayXO[5] &&
        displayXO[3] != '') {
      _showWinDialog(displayXO[5]);
    } else if (displayXO[6] == displayXO[7] &&
        displayXO[6] == displayXO[8] &&
        displayXO[6] != '') {
      _showWinDialog(displayXO[8]);
    } else if (displayXO[0] == displayXO[4] &&
        displayXO[0] == displayXO[8] &&
        displayXO[0] != '') {
      _showWinDialog(displayXO[4]);
    } else if (displayXO[2] == displayXO[4] &&
        displayXO[2] == displayXO[6] &&
        displayXO[2] != '') {
      _showWinDialog(displayXO[6]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Draw'),
            actions: [
              TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text('Play Again'),
              )
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Winner is: ' + winner),
            actions: [
              TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
                child: Text('Play Again'),
              )
            ],
          );
        });

    if (winner == 'o') {
      oScore += 1;
    } else if (winner == 'x') {
      xScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayXO[i] = '';
      }
    });
    filledBoxes = 0;
  }

  static const myTextStyle = TextStyle(color: Colors.white, fontSize: 30.0);

  static var myNewFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.black, letterSpacing: 3),
  );
  static var myNewFontWhite = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 20.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player x',
                          style: myNewFontWhite,
                        ),
                        Text(
                          '$xScore',
                          style: myNewFontWhite,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player o',
                          style: myNewFontWhite,
                        ),
                        Text(
                          '$oScore',
                          style: myNewFontWhite,
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade700,
                        ),
                      ),
                      child: Center(
                          child: Text(
                        displayXO[index],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40.0,
                        ),
                      )),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  'TIC TAC TOE',
                  style: myNewFontWhite,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
