import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:ideal_atm/main/business/models/atm/atm.dart';

class AtmProvider {
  Future<List<dynamic>> loadJsonData() async {
    final String response =
        await rootBundle.loadString('assets/data/atms.json');
    final data = await json.decode(response);
    return data['atms'];
  }

  Future<List<Atm>> fetchAtms() async {
    final atmJson = await loadJsonData();
    // final atms = atmJson.map((e) => Atm.fromMap(e) as List<Atm>);
    final atms = List<Atm>.from(
      atmJson.map(
        (e) => Atm.fromMap(e),
      ),
    );
    return atms;
  }
}
