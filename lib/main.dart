// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:read_excel/last_cities.dart';
import 'package:read_excel/model.dart';

String? university, region, city, ADM, LCoGV, LCoGTa, LCoGTe;
late Excel excel;
List<Map> list = [];
List<Map> cidades = [];

void main() {
  runApp(Container());
  init();
}

Future<void> init() async {
  ByteData data = await rootBundle.load("assets/aiesec.xlsx");
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  excel = Excel.decodeBytes(bytes);
  doit();
}

Future<void> doit() async {
  list = [];
  cidades = [];
  for (var table in excel.tables.keys) {
    if (excel.tables[table]?.maxCols == 8 && excel.tables[table]?.maxRows == 448 && table == 'NEW Universities Allocation 202') {
      print('TABLE - $table | COLS -  ${excel.tables[table]?.maxCols} | ROWS - ${excel.tables[table]?.maxRows}');
      int t = 0;
      for (List<Data?> row in excel.tables[table]!.rows) {
        t++;
        getLastValue(row);

        if (t > 3) {
          checkCities(row);
          //print('$t ${row[1]?.value ?? university} ,${row[2]?.value ?? region} ,${row[3]?.value ?? city} ,${row[4]?.value ?? ADM} ,${row[5]?.value ?? LCoGV} ,${row[6]?.value ?? LCoGTa} ,${row[7]?.value ?? LCoGTe}');

          list.add(modelCreate(row).toJson());
        }
      }
    }
  }
  if (true) {
    print(list.length);
    String json = jsonEncode(list);
    log(json);
  }

  cidades.sort((a, b) => a['name']!.compareTo(b['name']!));
  var jsonCity = jsonEncode(cidades);
  // log(jsonCity);
  print('lastCities leng ${lastCities.length}');
  print('cidades leng ${cidades.length}');
  for (var element in lastCities) {
    cidades.removeWhere((elementA) => elementA['name'] == element['name']);
  }
  print(lastCities.length);
  print(cidades.length);
  print('NEW CITY $cidades');
}

void checkCities(List<Data?> row) {
  if (row[3]?.value != null) {
    bool tem = false;
    for (var element in cidades) {
      if (element['name'] == '${row[3]?.value}') {
        tem = true;
      }
    }

    if (!tem) {
      String name = '${row[3]?.value}';
      if (name[0] == ' ') {
        name = name.substring(1);
      }
      cidades.add({"name": name});
    }
  }
}

void getLastValue(List<Data?> row) {
  university = '${row[1]?.value ?? university}';
  region = '${row[2]?.value ?? region}';
  city = '${row[3]?.value ?? city}';
  ADM = '${row[4]?.value ?? ADM}';
  LCoGV = '${row[5]?.value ?? LCoGV}';
  LCoGTa = '${row[6]?.value ?? LCoGTa}';
  LCoGTe = '${row[7]?.value ?? LCoGTe}';
}

Model modelCreate(row) {
  return Model(
    '${row[1]?.value ?? university}',
    '${row[2]?.value ?? university}',
    '${row[3]?.value ?? university}',
    '${row[4]?.value ?? university}',
    '${row[5]?.value ?? university}',
    '${row[6]?.value ?? university}',
    '${row[7]?.value ?? university}',
  );
}
