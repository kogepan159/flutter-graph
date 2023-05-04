import 'dart:convert';

import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';

class TopViewModel {
  List<String> names = [];
  List<String> titles = [];
  List<List<String>> items = [];
  int counter = 0;
  String? isSelectedItem = 'a';

  Future<List<List>> csvImport() async {
    FilePickerResult? result = await FilePickerWeb.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );
    names = [];
    titles = [];
    items = [];
    List<List> importList = [];
    if (result == null) return [];
    var fileBytes = result.files.single.bytes;
    var formater = String.fromCharCodes(fileBytes!);

    final contacts = formater.split('\r');
    for (int i = 0; i < contacts.length - 1; i++) {
      final contactData = contacts[i].split(',');
      if (i == 0) {
        for (String element in contactData) {
          titles.add(utf8.decode(element.runes.toList()));
        }
      } else {
        final name = utf8.decode(contactData[1].runes.toList());
        names.add(name);
        contactData[1] = name;
        items.add(contactData);
      }
    }
    names = names.toSet().toList();
    isSelectedItem = names.first;
    return Future<List<List>>.value(importList);
  }
}
