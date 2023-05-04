import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_graph/page/top/top_view_model.dart';
import 'package:flutter_graph/widget/fl_chart.dart';

class TopPage extends StatefulWidget {
  const TopPage({super.key, required this.title});

  final String title;

  @override
  State<TopPage> createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  TopViewModel viewModel = TopViewModel();

  void _incrementCounter() async {
    await viewModel.csvImport();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = <Widget>[
      const Text(
        '該当者',
      ),
      if (viewModel.names.isNotEmpty)
        DropdownButton(
          items: makeDropdownMenuItems(),
          onChanged: (String? value) {
            setState(() {
              viewModel.isSelectedItem = value;
            });
          },
          value: viewModel.isSelectedItem,
        ),
      const SizedBox(
        height: 32,
      ),
    ];

    children += makeAnswerList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.upload_file),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  List<DropdownMenuItem<String>> makeDropdownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String name in viewModel.names) {
      items.add(DropdownMenuItem(
        value: name,
        child: Text(name),
      ));
    }
    return items;
  }

  List<Widget> makeAnswerList() {
    if (viewModel.names.isEmpty) return [];
    List<Widget> items = [];
    var myItems = viewModel.items
        .where((element) => element[1] == viewModel.isSelectedItem);

    for (int i = 0; i < viewModel.titles.length - 1; i++) {
      if(i == 1) continue;
      items.add(Text(
        viewModel.titles[i],
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ));
      items.add(const SizedBox(height: 8));
      // ignore: unnecessary_null_comparison
      if (double.tryParse(myItems.first[i]) != null) {
        items.add(makeAnswerGraph(myItems, i));
      } else {
        items += makeAnswerString(myItems, i);
      }
      items.add(const SizedBox(height: 16));
    }
    return items;
  }

  Widget makeAnswerGraph(Iterable<List<String>> myItems, int section) {
    List<double> records = [];
    for (List<String> item in myItems) {
      records.add(double.parse(item[section]));
    }
    return  FlChart(records, section);
  }

  List<Widget> makeAnswerString(Iterable<List<String>> myItems, int section) {
    List<Widget> texts = [];
    for (List<String> item in myItems) {
      texts.add(Text(utf8.decode(item[section].runes.toList())));
    }
    return texts;
  }
}
