import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Getdata extends StatefulWidget {
  Getdata({this.title, this.message, this.time, required this.upd, this.docId});

  String? title;
  String? message;
  String? time;
  bool upd;
  String? docId;

  @override
  State<Getdata> createState() => _GetdataState();
}

class _GetdataState extends State<Getdata> {
  final _firestore = FirebaseFirestore.instance;
  late final titlecontroller = TextEditingController();
  final messagecontroller = TextEditingController();
  String? date;

// random color generator method
  String randomColorGenerate() {
    final random = Random();
    final red = 150 + random.nextInt(106);
    final green = 150 + random.nextInt(106);
    final blue = 150 + random.nextInt(106);
    //final color = Color.fromARGB(255, red, green, blue);
    return '#${red.toRadixString(16).padLeft(2, '0')}${green.toRadixString(16).padLeft(2, '0')}${blue.toRadixString(16).padLeft(2, '0')}';
  }

// update data in note method
  void updatedata() async {
    print(widget.title == titlecontroller.text);
    if (widget.title == titlecontroller.text &&
        widget.message == messagecontroller.text) {
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
                        'Update Some data Before Updating',
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
      try {
        await _firestore.collection('message').doc(widget.docId).update({
          'title': titlecontroller.text,
          'time': date,
          'message': messagecontroller.text
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
                            'Your Data has been Updated Successfully',
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
      } catch (e) {
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
                          'Try Again',
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
      }
    }
  }

// save note-data to db method
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
  void Currentdate() {
    DateTime now = DateTime.now();

    String formatteddate = DateFormat(
            'dd MMM, yyyy                                                          HH:mm:ss')
        .format(now);
    date = formatteddate;
  }

// initstate method
  @override
  void initState() {
    super.initState();
    Currentdate();

    if (widget.upd == true) {
      setState(() {
        titlecontroller.text = '${widget.title}';
        messagecontroller.text = '${widget.message}';
        date = widget.time;
      });
    }
  }

// main scaffold body
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a1a26),
      appBar: AppBar(
        backgroundColor: const Color(0xff0a1a26),
        title: Text(
          (widget.upd) ? 'Update note' : 'Add a new note',
          style: GoogleFonts.lexend(textStyle: const TextStyle(fontSize: 24)),
        ),
        // save data/ update data button
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: TextButton(
                onPressed: () {
                  if (widget.upd == false) {
                    savedata();
                  } else {
                    updatedata();
                  }
                },
                child: Text((widget.upd) ? 'Update data' : 'Save note',
                    style: GoogleFonts.lexend(
                        textStyle: const TextStyle(fontSize: 18)))),
          ),
          // TextButton(
          //     onPressed: () {
          //       Navigator.pop(context);
          //     },
          //     child: const Text('Close'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // title input field
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                    color: const Color(0xff005273),
                    borderRadius: BorderRadius.circular(30)),
                child: Row(
                  children: [
                    Text(
                      'Title:',
                      style: GoogleFonts.lexend(
                          textStyle: const TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(width: 9),
                    Expanded(
                      child: TextField(
                        controller: titlecontroller,
                        decoration: const InputDecoration(
                            hintText: "Enter title...",
                            border: InputBorder.none),
                        style: GoogleFonts.kanit(
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        onChanged: (value) {
                          print(titlecontroller.text);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            // date/time ui
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  date!,
                  style: const TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // message input field
            Expanded(
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xff005273),
                ),
                child: TextField(
                  controller: messagecontroller,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  decoration: const InputDecoration(
                    hintText: "Enter message...",
                    border: InputBorder.none,
                  ),
                  style: GoogleFonts.kanit(
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
