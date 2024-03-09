import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Getdata extends StatefulWidget {
  @override
  State<Getdata> createState() => _GetdataState();
}

class _GetdataState extends State<Getdata> {
  late final titlecontroller = TextEditingController();
  final messagecontroller = TextEditingController();
  String? date;

  Currentdate() {
    DateTime now = DateTime.now();

    String formatDate =
        DateFormat('HH:MM:SS                                     dd MMM, yyyy')
            .format(now);
    date = formatDate;
  }

  @override
  void initState() {
    super.initState();
    Currentdate();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff0a1a26),
        appBar: AppBar(
          backgroundColor: const Color(0xff0a1a26),
          title: const Text(
            'Add Notes',
            style: TextStyle(fontSize: 22),
          ),
          actions: [
            TextButton(
                onPressed: () {},
                child: const Text(
                  'Save data',
                  style: TextStyle(fontSize: 18),
                )),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close', style: TextStyle(fontSize: 18)))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: const Color(0xff1e4e72),
                      borderRadius: BorderRadius.circular(22)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 2.0, horizontal: 4),
                    child: Row(
                      children: [
                        const Text(
                          'Title:',
                          style: TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TextField(
                            controller: titlecontroller,
                            decoration: const InputDecoration(
                                hintText: "Enter title......",
                                border: InputBorder.none),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            onChanged: (value) {
                              print(titlecontroller.text);
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    date!,
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff1e4e72),
                  ),
                  child: TextField(
                    controller: messagecontroller,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    decoration: const InputDecoration(
                      hintText: "Enter message....",
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
