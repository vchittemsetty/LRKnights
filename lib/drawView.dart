import 'package:flutter/material.dart';

var sheet, ss;
var currentRound;
var rounds;

class DrawViewer extends StatelessWidget {
  final ss, groupName, title;
  DrawViewer(
      {super.key,
      required this.ss,
      required this.groupName,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: BackButton(onPressed: () => Navigator.pop(context)),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Group:   $groupName    Round     $currentRound',
                style: TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
                width: double.infinity,
              ),
              moreRows(),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: getAll,
        tooltip: 'Refresh',
        child: const Icon(Icons.refresh),
      ), // T
    );
  }

  Future<void> _refresh() async {}
  Table moreRows() {
    var trs = <TableRow>[];
    var writeHeader = true;
    getAll();
    for (Iterable<String> rdd in rounds) {
      var cells = <TableCell>[];
      cells.add(
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              rdd.elementAt(1),
              style: TextStyle(
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
            padding: EdgeInsets.all(8.0),
            child: Text(
              rdd.elementAt(3),
              style: TextStyle(
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
            padding: EdgeInsets.all(8.0),
            child: Text(
              rdd.elementAt(5),
              style: TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
      var trow;
      if (writeHeader) {
        trow = TableRow(
          children: cells,
          decoration: BoxDecoration(color: Colors.amberAccent),
        );
        writeHeader = false;
      } else {
        trow = TableRow(children: cells);
      }
      trs.add(trow);
    }

    var tbl = Table(
      defaultColumnWidth: IntrinsicColumnWidth(),
      children: trs,
      border: TableBorder.all(color: Colors.black),
    );
    return tbl;
  }

  Future getAll() async {
    sheet = ss.worksheetByTitle(groupName);
    rounds = await sheet!.values.allRows(fromRow: 1);
    debugPrint('rounds $rounds');
    _refresh();
    // setState(() {});
  }
}
