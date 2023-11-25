// import 'dart:convert';
// import 'dart:html';

// ignore_for_file: prefer_typing_uninitialized_variables

// import 'dart:ui';

import 'package:chesstournament/draw_viewer.dart';
// import 'package:chesstournament/showFixtures.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'package:responsive_framework/responsive_framework.dart';

const _credentials = r'''{
  "type": "service_account",
  "project_id": "gsheets-404214",
  "private_key_id": "c1720405d8d59f27b58c5f8e40a7fcaff667f2bd",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCsQ1JsOXO+ZHV+\nx2aMUpP8K9qUIWPFV0/5BiEmR8IifnsaU67/frOcFTUCNTM+DxvMlNbawWBGOI56\nfkYY91k8NPMt1ylObLUI2tc+VSIs48ciaYXaYmN2dGqsGtAG8pBiCCuj8D59tYVV\n22B6Gwkhw13FTKwd0XhoPRtWtoFDkmtWNym6x5X8KWi5lHvkTKVKCwVxY5zVPsKu\nNGSzjMT02QVooH9LDNMswJMZNB6MSSY5iQqFIF2C3BFN+rKC9VS6sQ4BptIQ9Ovt\nH9iEev7PD3VsOHtafmsh2soKO0URoPNLAOIMsuEQi6YfJaejVstoAB6vHCLIfZXx\nSElOlg0vAgMBAAECggEALCz1iaBwIK61fOYY07pnjd8XJi6r3dMmxJdAUAdN7zed\nTSKRuZ6d49SCbAcFlZAdUmkG8kFt9YQScbJJOqTP4wM3K5XGV4DEKjmowijl4zok\nepwyAc+Cb0Gqi2ky2N1CjolG27tD40v2Hg7snlOpk1l9BhhD+T+bD6xAAww5eQC7\nEk/oJAUjqQVDHkSfoH0cz+T1E1dclLknbkGFiDdlqgdbaiq+zL+tBBq190CPqfac\nAHK5LBVzt+YtjFy+sPgeH0cl4Tob/+MmthYAb4+6aPeLAKrPXMHdf/QqWQAwPyaD\nzWz8g8g7fEOpb5sxZYrA2Z6fnhvzm12E2w3VVMYe2QKBgQDfQkMQ7vkgc1UPa2HM\ne8ackrHdOMBid+v9xDFgENU/dlXGRsN3AQmPTFw6Aa1vDsfeIkEgEffTGL0NwAfy\ndTY/iBrtJwuNyWwG+eTCFl7+Pe8kuFn0saFmCY9PweaORe/JCM1KRUgtcrQObWRX\nKbYI34SQfCePueEff7KIJaiPFwKBgQDFhom/EHgPL9gZ+iScu14sphvi047Dw+yB\nZhQsPFei9kaKHrsSm+i4EEF3F5/tMg5Fek1SSHfdifc0kEBfaOQmIyzJouExvey7\neB70EqsAp8MSYHnNeR1TiyKwWMIfiOUVsi8tLBz1wzB0RI2zMvS0ybrs6Mnp0o5q\nS351aJOBqQKBgBbtLQnuIHMupMuCkXZ4N3sYrV80Vr1F51wV66Qb1mo/8qr71VLB\nLoQiqU3jojXHZMrw5ZMvhS2OWsuwrqA9XSbFCU7VNaCH0Koeu1kbBwJAxfAVZld0\nbkiWLrtYBB8UG32fg8Veu/y+zLK2lRlGVUUv/uL/fOiLhAzCBklo5JhdAoGAdrLV\nngqwizfOHjYywDjca+paQaGuXjgjrNMB9l9Arr5eP2weMR2d6NZj8MQyp+B3sQrA\n4lyII4pgEqdI98zZpY1nwbfuqeyfET0rJLL/LgKieC2fpHlOxUCMVPrRlQ+30qTk\nMroaoRltycDUgkZxxR6hBPMTOz77tCav1LBGTBkCgYBgN8HbP9O74Nv4nGrMurg9\nyjni/uLWTeEb9neh7JZPTR/L/xRxK310cXh7Z5NhUr6ZV3BqD8JYnWqeZCYkixsC\nEdNDMSSNzVfDsRpecuzBOKHL93jzX17X0I7K/GoEiXKPWPF7g3iOk+8Cw9YhPcBY\nJafQB9+rZcyQzm79hdtt5g==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-404214.iam.gserviceaccount.com",
  "client_id": "104698606245651718523",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-404214.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}''';
const _soreadsgeetId = '1UJP1Q227ZMTwZ37uXzmbJiZwCM6cJ2VWHlKgK0HsXGw';
var roundsK, roundsB, roundsR, roundsN, roundsU, roundsA;
Iterable<String> rds = [];
final gsheets = GSheets(_credentials);
var ss;
var kingSheet, bishopSheet, rookSheet, knightSheet, u700Sheet, a700Sheet;

var currentRoundK,
    currentRoundB,
    currentRoundR,
    currentRoundN,
    currentRoundU,
    currentRoundA,
    groupName;
// List<Widget> rows, cols;
void main() async {
  ss = await gsheets.spreadsheet(_soreadsgeetId);
  groupName = 'Beginners1';
  //ShowFixtures.showFixtures(ss, groupName);
  kingSheet = ss.worksheetByTitle('Beginners1');
  bishopSheet = ss.worksheetByTitle('Beginners2');
  rookSheet = ss.worksheetByTitle('Intermediate1');
  knightSheet = ss.worksheetByTitle('Intermediate2');
  u700Sheet = ss.worksheetByTitle('U700');
  a700Sheet = ss.worksheetByTitle('A700');

  roundsK = await kingSheet!.values.allRows(fromRow: 1);
  rds = roundsK[1];
  currentRoundK = rds.elementAt(0);
  roundsB = await bishopSheet!.values.allRows(fromRow: 1);
  rds = roundsB[1];
  currentRoundB = rds.elementAt(0);
  roundsR = await rookSheet!.values.allRows(fromRow: 1);
  rds = roundsR[1];
  currentRoundR = rds.elementAt(0);
  roundsN = await knightSheet!.values.allRows(fromRow: 1);
  rds = roundsN[1];
  currentRoundN = rds.elementAt(0);
  roundsU = await u700Sheet!.values.allRows(fromRow: 1);
  rds = roundsU[1];
  currentRoundU = rds.elementAt(0);
  roundsA = await a700Sheet!.values.allRows(fromRow: 1);
  rds = roundsU[1];
  currentRoundA = rds.elementAt(0);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'LRKnights Tournament',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'LRKnights Tournament'),
    );
  }
}

String title = 'LRKnights Tournament';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage = 0;
  // static final double spaceBetween = 5.0;

  // ShowFixtures sf = ShowFixtures(ss, groupName);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(248, 248, 3, 248)),
                  elevation: const MaterialStatePropertyAll(50),
                ),
                child: const Text('Begginers 1 Pairings',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 247, 248, 248))),
                onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DrawViewer1(
                        groupName: 'Begginers 1',
                        title: title,
                        sheet: kingSheet,
                        rounds: roundsK,
                        currentRound: currentRoundK,
                      ),
                    ),
                  )
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.deepOrangeAccent)),
                child: const Text('Begginers 2 Pairings',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 247, 248, 248))),
                onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DrawViewer1(
                        groupName: 'Begginers 2',
                        title: title,
                        sheet: bishopSheet,
                        rounds: roundsB,
                        currentRound: currentRoundB,
                      ),
                    ),
                  )
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightGreenAccent),
                    shadowColor:
                        const MaterialStatePropertyAll(Colors.amberAccent)),
                child: const Text(
                  'Intermediate 1 Pairings',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
                onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DrawViewer1(
                        groupName: 'Intermediate 1',
                        title: title,
                        sheet: rookSheet,
                        rounds: roundsR,
                        currentRound: currentRoundR,
                      ),
                    ),
                  )
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.tealAccent)),
                child: const Text('Intermediate 2 Pairings',
                    style: TextStyle(
                      fontSize: 20.0,
                    )),
                onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DrawViewer1(
                        groupName: 'Intermediate 2',
                        title: title,
                        sheet: knightSheet,
                        rounds: roundsN,
                        currentRound: currentRoundN,
                      ),
                    ),
                  )
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.green[900])),
                child: const Text('USCF U700 Pairings',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 247, 248, 248))),
                onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DrawViewer1(
                        groupName: 'USCF Under 700',
                        title: title,
                        sheet: u700Sheet,
                        rounds: roundsU,
                        currentRound: currentRoundU,
                      ),
                    ),
                  )
                },
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent)),
                child: const Text('USCF 700 & Above Pairings',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Color.fromARGB(255, 247, 248, 248))),
                onPressed: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DrawViewer1(
                        groupName: 'USCF 700 & Above',
                        title: title,
                        sheet: a700Sheet,
                        rounds: roundsA,
                        currentRound: currentRoundA,
                      ),
                    ),
                  )
                },
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: getAll,
      //   tooltip: 'Refresh',
      //   child: const Icon(Icons.refresh),
      // ), // T
    );
  }

  Future getAll() async {
    roundsK = await kingSheet!.values.allRows(fromRow: 1);
    rds = roundsK[1];
    currentRoundK = rds.elementAt(0);
    roundsB = await bishopSheet!.values.allRows(fromRow: 1);
    rds = roundsB[1];
    currentRoundB = rds.elementAt(0);
    roundsR = await rookSheet!.values.allRows(fromRow: 1);
    rds = roundsR[1];
    currentRoundR = rds.elementAt(0);
    roundsN = await knightSheet!.values.allRows(fromRow: 1);
    rds = roundsN[1];
    currentRoundN = rds.elementAt(0);
    setState(() {});
  }
}
