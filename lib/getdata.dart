import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final _firestore = FirebaseFirestore.instance;

// random colors generator
  String randomColorGenerate() {
    final random = Random();
    final red = 150 + random.nextInt(106);
    final green = 150 + random.nextInt(106);
    final blue = 150 + random.nextInt(106);
    final color = Color.fromARGB(255, red, green, blue);
    return '#' +
        red.toRadixString(16).padLeft(2, '0') +
        green.toRadixString(16).padLeft(2, '0') +
        blue.toRadixString(16).padLeft(2, '0');
  }

// save data method
  Future<void> savedata() async {
    CollectionReference users = _firestore.collection('message');
    try {
      if (titlecontroller.text == "" && messagecontroller.text == "") {
        showDialog(
            context: context,
            builder: (context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AlertDialog(
                    title: const Center(
                        child: Text(
                      'Error',
                      style: TextStyle(fontSize: 30),
                    )),
                    content: const Column(
                      children: [
                        Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 130,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Center(
                            child: Text(
                          'Enter Some Data Before Saving',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )),
                      ],
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Ok'))
                    ],
                  ),
                ],
              );
            });
      } else {
        await users.add({
          'title': titlecontroller.text,
          'message': messagecontroller.text,
          'time': date!,
          'color': randomColorGenerate()
        }).whenComplete(() {
          Navigator.pop(context);

          showDialog(
              context: context,
              builder: (context) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AlertDialog(
                      title: const Center(
                          child: Text(
                        'Data Saved',
                        style: TextStyle(fontSize: 30),
                      )),
                      content: const Column(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 130,
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Center(
                              child: Text(
                            'Your Data has been saved Successfully',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          )),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'))
                      ],
                    ),
                  ],
                );
              });
        });
      }
    } catch (e) {
      print('error $e');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Column(
                children: [
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 24,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text('Try Again'),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
            );
          });
    }
  }

// current date formatted method
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
                onPressed: () {
                  savedata();
                },
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
