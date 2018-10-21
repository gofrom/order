import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SellDocument {
  SellDocument(this.active, this.date, this.number, this.sum, this.ca,
      this.manager, this.mobileAgent, this.deleted, this.exp);

  bool active;
  String date;
  String number;
  double sum;
  String ca;
  String manager;
  bool mobileAgent;
  bool deleted;
  String exp;

  bool selected = false;
}

class SellDocumentsDataSource extends DataTableSource {
  void loadData() async {
    String dataURL =
        "http://192.168.10.2:8080/utapr/hs/mce/%D0%9E%D1%82%D1%87%D0%B5%D1%82?Report=001&BeginDate=20180801000000";

    //    "http://echo.jsontest.com/date/12-12-2018/number/3459/ca/IPBabayan/sum/5273.50";

//    var client = new http.Client();
//    client.post(dataURL, headers: {
//      "Authorization": "Basic c2VydmljZTpzZXJ2aWNl"
//    }, body: {
//      "Report": "001",
//      "BeginDate": "20180801000000",
//      "EndDate": "20180801235959"
//    }).then((response) => print(response.body));

//    print("GH1" + dataURL);
//    http.Response response = await http.post(dataURL, headers: {
//      "Authorization": "Basic c2VydmljZTpzZXJ2aWNl"
//    }, body: {
//      "Report": "001",
//      "BeginDate": "20180801000000",
//      "EndDate": "20180801235959"
//    });

    http.Response response = await http
        .get(dataURL, headers: {"Authorization": "Basic c2VydmljZTpzZXJ2aWNl"});

    //"Период": {"Начало": "20180801000000", "Окончание": "20180801235959"}
    print(response.body);

    //Map<String, dynamic> data = json.decode(response.body);
    List<dynamic> data = json.decode(response.body);

    for (Map<String, dynamic> Element in data) {
      _documents.add(SellDocument(
          Element['Проведен'],
          Element['ДатаДокумента'],
          Element['НомерДокумента'],
          double.parse(Element['СуммаДокумента'].toString()),
          Element['Клиент'],
          Element['Менеджер'],
          Element['МобильныйАгент'],
          Element['ПометкаУдаления'],
          Element['Экспедитор']));
    }

    notifyListeners();
  }

  List<SellDocument> _documents = <SellDocument>[];

  int _selectedCount = 0;

  //DataCell dataCell = DataCell(child);

  @override
  DataRow getRow(int index) {
    assert(index >= 0);

    if (index >= _documents.length) {
      return null;
    }

    final SellDocument document = _documents[index];

    return DataRow.byIndex(
        index: index,
        selected: document.selected,
        onSelectChanged: (bool value) {
          if (document.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            document.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(
              Container(
                  child: Checkbox(
                      value: document.active,
                      onChanged: null
                  ),
                color: Colors.black12,
              ),

          ),
          DataCell(
            Container(
                child: Checkbox(
                  value: document.deleted,
                  onChanged: null
                ),
      color: Colors.black26 ,
      )
    ),
    DataCell(Text('${document.date}'), onTap: () {
    print(document.date);
    }),
    DataCell(Text('${document.number}'), onTap: () {
    print(document.number);
    }),
    DataCell(
    Container(
    child: Text(
    '${document.ca}',
    softWrap: true,
    maxLines: 2,
    overflow: TextOverflow.ellipsis
    ),
    width: 300.0,
    ),
    ),
    DataCell(Text('${document.sum}')),
    DataCell(Checkbox(value: document.mobileAgent, onChanged: null)),
    DataCell(Text('${document.manager}')),
    DataCell(Text('${document.exp}')),
    ]);
  }

  @override
  int get rowCount => _documents.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

class SellPage extends StatefulWidget {
  SellPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SellPageState createState() => new _SellPageState();
}

class _SellPageState extends State<SellPage> {
  @override
  Widget build(BuildContext context) {
    SellDocumentsDataSource _sellDocumentsDataSource =
    SellDocumentsDataSource();
    _sellDocumentsDataSource.loadData();

    return new Scaffold(
//      appBar: new AppBar(
//        title: new Text(''),
//      ),
      body: new Center(
          child: ListView(children: <Widget>[
            PaginatedDataTable(
                header: const Text('Документы реализации'),
                rowsPerPage: PaginatedDataTable.defaultRowsPerPage,
                columns: <DataColumn>[
                  DataColumn(label: const Text('Проведен')),
              DataColumn(label: const Text('Удален')),
              DataColumn(label: const Text('Дата')),
              DataColumn(label: const Text('Номер')),
              DataColumn(
                  label: const Text(
                'Клиент',
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              )),
              DataColumn(label: const Text('Сумма'), numeric: true),
              DataColumn(label: const Text('МобильныйАгент')),
              DataColumn(label: const Text('Менеджер')),
              DataColumn(label: const Text('Экспедитор'))
            ],
            source: _sellDocumentsDataSource)
      ])),
    );
  }
}
