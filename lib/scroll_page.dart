import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScrollBarPage extends StatefulWidget {
  ScrollBarPage({Key? key}) : super(key: key);

  @override
  State<ScrollBarPage> createState() => _ScrollBarPageState();
}

class _ScrollBarPageState extends State<ScrollBarPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readJson();
  }

  List _items = [];

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('json/data.json');
    final data = await json.decode(response);
    setState(() {
      _items = data["data"];
    });
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 72, 70, 70),
        body: Scrollbar(
            thickness: 20,
            controller: controller,
            thumbVisibility: true,
            showTrackOnHover: true,
            child: ListView.builder(
                controller: controller,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _items.length,
                itemBuilder: (context, i) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _items[i]['level'],
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: _items[i]['level'] == 'Advanced'
                                  ? Color.fromARGB(202, 76, 223, 8)
                                  : _items[i]['level'] == 'Intermediate'
                                      ? Colors.orange
                                      : Colors.redAccent,
                            ),
                            height: height * 0.4,
                            width: width * 0.9,
                            child: Center(
                                child: Text(
                              _items[i]['name'],
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ))),
                      ),
                    ],
                  );
                })));
  }
}
