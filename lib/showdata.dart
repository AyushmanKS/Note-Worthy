import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_worthy/getdata.dart';
import 'package:google_fonts/google_fonts.dart';

class Showdata extends StatefulWidget {
  const Showdata({super.key});

  @override
  State<Showdata> createState() => _ShowdataState();
}

class _ShowdataState extends State<Showdata> {
  final _firestore = FirebaseFirestore.instance;
  bool upd = false;

// note delete method
  void confirmdelete(id) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete this data?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Close the dialog
                  // Call your delete function here
                  // Perform the delete operation

                  try {
                    CollectionReference collection =
                        _firestore.collection('message');

                    DocumentReference docref = collection.doc(id);

                    await docref.delete();
                  } catch (e) {
                    print("Error deleting document: $e");
                  }
                },
                child: const Text('Delete'),
              ),
            ],
          );
        });
  }

// scaffold body
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a1a26),
      appBar: AppBar(
        backgroundColor: const Color(0xff0a1a26),
        title: Center(
          child: Text(
            'My Notes',
            style: GoogleFonts.lexend(textStyle: const TextStyle(fontSize: 30)),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _firestore.collection('message').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
            ));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final messages = snapshot.data?.docs.reversed;
            List<Widget> messagetextwidget = [];

            for (var message in messages!) {
              final titletext = message.data()['title'];
              final timetext = message.data()['time'];
              final messagetext = message.data()['message'];
              final color = message.data()['color'];
              final docId = message.id;

              final messagewidget = MessageNote(
                  title: titletext,
                  time: timetext,
                  message: messagetext,
                  id: docId,
                  deletedata: (String? id) => confirmdelete(id),
                  color: color);
              messagetextwidget.add(messagewidget);
            }
            return ListView(
              reverse: false,
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
              children: messagetextwidget,
            );
          }
        },
      ),
      // floating action button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Getdata(upd: false)));
        },
        backgroundColor: const Color(0xff005273),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}

class MessageNote extends StatelessWidget {
  const MessageNote(
      {super.key,
      required this.title,
      required this.time,
      required this.message,
      this.id,
      this.deletedata,
      this.color});

  final String title;
  final String time;
  final String message;
  final String? id;
  final Function(String?)? deletedata;
  final String? color;

// random color generator
  Color randomcolorgenerate() {
    final random = Random();
    return Color.fromARGB(
      255,
      150 + random.nextInt(106), // Red component between 150 and 255
      150 + random.nextInt(106), // Green component between 150 and 255
      150 + random.nextInt(106), // Blue component between 150 and 255
    );
  }

// hex to color method
  Color hexToColor(String hexCode) {
    final buffer = StringBuffer();
    if (hexCode.length == 6 || hexCode.length == 7) {
      buffer.write('ff');
    }
    buffer.write(hexCode.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Getdata(
                      upd: true,
                      title: title,
                      message: message,
                      time: time,
                      docId: id)));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: hexToColor(color!),
          ),
          padding: const EdgeInsets.all(18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title of note
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 240),
                    child: Text(
                      title == "" ? "Undefined" : title,
                      style: GoogleFonts.lexend(
                          textStyle: const TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // message of note
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 240),
                    child: Text(
                      message == "" ? "Undefined" : message,
                      softWrap: true,
                      style: GoogleFonts.kanit(
                          textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600)),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // date/time of note
                  Text(
                    time,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.9),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic),
                  )
                ],
              ),
              // Delete icon
              Center(
                child: IconButton(
                  onPressed: () {
                    deletedata!(id);
                  },
                  icon:
                      Icon(Icons.delete, size: 26, color: Colors.grey.shade800),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
