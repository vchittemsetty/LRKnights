import 'package:flutter/material.dart';

class DrawViewer1 extends StatefulWidget {
  final groupName, title, sheet, currentRound, rounds;

  const DrawViewer1(
      {super.key,
      required this.groupName,
      required this.title,
      required this.sheet,
      required this.rounds,
      required this.currentRound});

  @override
  State<DrawViewer1> createState() => _DrawViewerState();
}

class _DrawViewerState extends State<DrawViewer1> {
  dynamic rds, dataTable = Text('Wait for the refresh');

  Future<void> _fetcData() async {
    dataTable = Text('Wait for the refresh');
    final response = await widget.sheet.values.allRows(fromRow: 1);
    debugPrint('Future vmc $response');
    setState(() {
      rds = response;
      dataTable = moreRows(rds);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetcData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorGetter(),
      appBar: AppBar(title: Text(widget.title)),
      body: RefreshIndicator(
        backgroundColor: Colors.red,
        onRefresh: _refresh,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Group:   ${widget.groupName}    Round     ${widget.currentRound}',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
                width: double.infinity,
              ),
              dataTable,
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ), // T
    );
  }

  Color colorGetter() {
    Color bgrColor = Colors.redAccent;
    switch (widget.groupName) {
      case 'Begginers 1':
        bgrColor = const Color.fromARGB(248, 248, 3, 248);
        break;
      case 'Begginers 2':
        bgrColor = Colors.deepOrangeAccent;
        break;
      case 'Intermediate 1':
        bgrColor = Colors.lightGreenAccent;
        break;
      case 'Intermediate 2':
        bgrColor = Colors.tealAccent;
        break;
      case 'USCF Under 700':
        bgrColor = Colors.green;
        break;
      case 'USCF 700 & Above':
        bgrColor = Colors.redAccent;
        break;
      default:
        bgrColor = Colors.redAccent;
    }

    return (bgrColor);
  }

  Future<void> _refresh() async {
    _fetcData();
  }

  Table moreRows(rds) {
    var trs = <TableRow>[];
    var writeHeader = true;
    bool sp = true;

    // rds = await widget.sheet.values.allRows(fromRow: 1);
    for (Iterable<String> rdd in rds) {
      var cells = <TableCell>[];
      String lastCell;
      if (rdd.elementAt(4) == 'BYE') {
        lastCell = 'BYE';
      } else {
        lastCell = rdd.elementAt(5);
      }
      cells.add(
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              rdd.elementAt(1),
              style: const TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
      cells.add(
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              rdd.elementAt(3),
              style: const TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
      cells.add(
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              lastCell,
              style: const TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
      TableRow trow;

      if (writeHeader) {
        trow = TableRow(
          children: cells,
          decoration: const BoxDecoration(
            color: Colors.pinkAccent,
          ),
        );

        writeHeader = false;
      } else {
        if (sp) {
          trow = TableRow(
            children: cells,
            decoration: BoxDecoration(color: Colors.cyanAccent[100]),
          );
          sp = false;
        } else {
          trow = TableRow(
            children: cells,
            decoration: BoxDecoration(color: Colors.blue[400]),
          );
          sp = true;
        }
      }
      trs.add(trow);
    }

    var tbl = Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: trs,
      border: TableBorder.all(color: Colors.black),
    );
    return tbl;
  }

  // Future getAll() async {
  //   sheet = widget.ss.worksheetByTitle(widget.groupName);
  //   rounds = await sheet.values.allRows(fromRow: 1);
  //   var rds = rounds[1];
  //   currentRound = rds.elementAt(0);

  //   debugPrint('rounds $currentRound');

  //   setState(() {});
  // }

  // Future getAll() async {
  //   var rds1 = await widget.sheet.values.allRows(fromRow: 1);
  //   setState(() {
  //     rds = rds1;
  //   });
  // }
}
