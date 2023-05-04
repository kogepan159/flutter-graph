import 'dart:convert';
import 'dart:html';

import 'package:file_picker/file_picker.dart';

class TopViewModel {
  List<String> names = [];
  List<String> titles = [];
  List<List<String>> items = [];
  int counter = 0;
  String? isSelectedItem = 'a';

  Future<List<List>> csvImport() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    List<List> importList = [];
    if (result == null) return [];
    var fileBytes = result.files.first.bytes;
    var formater = String.fromCharCodes(fileBytes!);

    final contacts = formater.split('\r');
    for (int i = 0; i < contacts.length - 1; i++) {
      final contactData = contacts[i].split(',');
      if (i == 0) {
        for (String element in contactData) {
          titles.add(utf8.decode(element.runes.toList()));
        }
      } else {
        names.add(utf8.decode(contactData[1].runes.toList()));
        items.add(contactData);
      }
    }
    names = names.toSet().toList();
    isSelectedItem = names.first;

    // csvのタイトルを求める
    // 2列の名前でlistを作成する
    // 3列目以降はグラフにする
    // 数字に変更できない場合、List表示にする
    // 全員と個別対応できるようにする

    return Future<List<List>>.value(importList);
  }
}
