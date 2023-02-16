// ignore_for_file: avoid_print, non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:read_excel/model.dart';

String? university, region, city, ADM, LCoGV, LCoGTa, LCoGTe;
late Excel excel;
List<Map> list = [];

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
  for (var table in excel.tables.keys) {
    if (excel.tables[table]?.maxCols == 8 && excel.tables[table]?.maxRows == 448 && table == 'NEW Universities Allocation 202') {
      print('TABLE - $table | COLS -  ${excel.tables[table]?.maxCols} | ROWS - ${excel.tables[table]?.maxRows}');
      int t = 0;
      for (List<Data?> row in excel.tables[table]!.rows) {
        t++;
        getLastValue(row);

        if (t > 3) {
          //print('$t ${row[1]?.value ?? university} ,${row[2]?.value ?? region} ,${row[3]?.value ?? city} ,${row[4]?.value ?? ADM} ,${row[5]?.value ?? LCoGV} ,${row[6]?.value ?? LCoGTa} ,${row[7]?.value ?? LCoGTe}');
          list.add(modelCreate(row).toJson());
        }
      }
    }
  }
  print(list.length);
  log(jsonEncode(list));
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
