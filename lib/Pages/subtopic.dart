import 'dart:ui';

import 'package:Syllabus/Helper/syllabusapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Syllabus/Helper/DeviceSize.dart';

class subtopic extends StatefulWidget {
  final String topic;
  @required
  bool isfav;
  subtopic({this.topic, this.isfav});

  @override
  _subtopicState createState() => _subtopicState();
}

class _subtopicState extends State<subtopic> {
  @override
  int category = 0;

  final listOfCategory2 = ["All", "Complete", "Pending"];

  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser;

    // Complete and pending data display

    Widget displayDataCompleteandPending(
        BuildContext context, DocumentSnapshot doc) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0, top: 0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 15.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: displayWidth(context) * 0.02,
                  child: CircleAvatar(
                    backgroundColor: Colors.lightBlue[100],
                    radius: displayWidth(context) * 0.125,
                    child: Image(
                      image: AssetImage("images/b2.png"),
                      width: displayWidth(context) * 0.15,
                      height: displayHeight(context) * 0.08,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  child: Checkbox(
                    value: doc['complete'],
                    activeColor: doc['complete'] ? Colors.green : Colors.red,
                    onChanged: (value) {
                      setState(() {
                        if (doc['complete']) {
                          // complete -> pending
                          // delete complete
                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(widget.topic)
                              .collection("All")
                              .doc(doc['title'])
                              .update({'title': doc['title'], 'complete': false});
                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(widget.topic)
                              .collection("Pending")
                              .doc(doc['title'])
                              .set({'title': doc['title'], 'complete': false});

                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(widget.topic)
                              .collection("Complete")
                              .doc(doc['title'])
                              .delete();
                        } else {
                          //
                          // pending -> complete
                          // delete pending
                          // create complete

                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(widget.topic)
                              .collection("Pending")
                              .doc(doc['title'])
                              .delete();

                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(widget.topic)
                              .collection("Complete")
                              .doc(doc['title'])
                              .set({'title': doc['title'], 'complete': true});
                           FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(widget.topic)
                              .collection("All")
                              .doc(doc['title'])
                              .update({'title': doc['title'], 'complete': true});

                        }
                      });
                    },
                  ),
                  top: displayHeight(context) * 0.0115,
                  right: displayWidth(context) * 0.02,
                ),
                Positioned(
                  top: displayHeight(context) * 0.085,
                  left: displayWidth(context) * 0.34,
                  right: displayWidth(context) * 0.1,
                  child: Text(
                    doc['title'],
                    style: TextStyle(
                      fontSize: displayWidth(context) * 0.042,
                      fontFamily: "PatuaOne",
                    ),
                  ),
                ),
              ],
            ),
            height: displayHeight(context) * 0.18,
          ),
        ),
      );
    }

    /// Display
    Widget displayData(BuildContext context, DocumentSnapshot doc) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0, top: 0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 15.0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: displayWidth(context) * 0.02,
                  child: CircleAvatar(
                    backgroundColor: Colors.lightBlue[100],
                    radius: displayWidth(context) * 0.125,
                    child: Image(
                      image: AssetImage("images/b2.png"),
                      width: displayWidth(context) * 0.15,
                      height: displayHeight(context) * 0.08,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  child: Checkbox(
                    value: doc['complete'],
                    activeColor: doc['complete'] ? Colors.green : Colors.red,
                    onChanged: (value) {
                      setState(() {
                        if (doc['complete']) {
                          // complete -> pending
                          // delete complete

                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(widget.topic)
                              .collection("All")
                              .doc(doc['title'])
                              .update(
                                  {"title": doc['title'], "complete": false});

                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(widget.topic)
                              .collection("Pending")
                              .doc(doc['title'])
                              .set({'title': doc['title'], 'complete': false});

                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(widget.topic)
                              .collection("Complete")
                              .doc(doc['title'])
                              .delete();
                        } else {
                          //
                          // pending -> complete
                          // delete pending
                          // create complete

                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(widget.topic)
                              .collection("Pending")
                              .doc(doc['title'])
                              .delete();
                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(widget.topic)
                              .collection("All")
                              .doc(doc['title'])
                              .update(
                                  {"title": doc['title'], "complete": true});
                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(widget.topic)
                              .collection("Complete")
                              .doc(doc['title'])
                              .set({'title': doc['title'], 'complete': true});
                        }
                      });
                    },
                  ),
                  top: displayHeight(context) * 0.0115,
                  right: displayWidth(context) * 0.02,
                ),
                Positioned(
                  top: displayHeight(context) * 0.085,
                  left: displayWidth(context) * 0.34,
                  right: displayWidth(context) * 0.1,
                  child: Text(
                    doc['title'],
                    style: TextStyle(
                      fontSize: displayWidth(context) * 0.042,
                      fontFamily: "PatuaOne",
                    ),
                  ),
                ),

                // Delete Syllabus

                Positioned(
                  bottom: displayHeight(context) * 0.00,
                  right: displayWidth(context) * 0.02,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection(currentUser.uid.toString())
                          .doc("All")
                          .collection("list")
                          .doc(widget.topic)
                          .collection("All")
                          .doc(doc['title'])
                          .delete();

                          FirebaseFirestore.instance
                          .collection(currentUser.uid.toString())
                          .doc("All")
                          .collection("list")
                          .doc(widget.topic)
                          .collection("Complete")
                          .doc(doc['title'])
                          .delete();

                          FirebaseFirestore.instance
                          .collection(currentUser.uid.toString())
                          .doc("All")
                          .collection("list")
                          .doc(widget.topic)
                          .collection("Pending")
                          .doc(doc['title'])
                          .delete();
                    },
                  ),
                ),
              ],
            ),
            height: displayHeight(context) * 0.18,
          ),
        ),
      );
    }

    // Display All
    Widget displayAllSubtopic() {
      return StreamBuilder(
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_off_outlined,
                        size: displayWidth(context) * 0.15,
                      ),
                      Opacity(
                        opacity: 0.0,
                        child: Divider(
                          height: displayHeight(context) * 0.005,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Please check your internet connection ...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: displayWidth(context) * 0.055,
                            fontFamily: "PatuaOne",
                          ),
                        ),
                      ),
                    ]),
              );
            return Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 16.0),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0.0),
                itemBuilder: (BuildContext context, int index) {
                  return displayData(context, snapshot.data.docs[index]);
                },
                itemCount: snapshot.data.docs.length,
              ),
            );
          },
          stream: FirebaseFirestore.instance
              .collection(currentUser.uid.toString())
              .doc("All")
              .collection("list")
              .doc(widget.topic)
              .collection("All")
              .snapshots());
    }

// Display Complete
//
    Widget displayCompleteSubtopic() {
      return StreamBuilder(
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_off_outlined,
                        size: displayWidth(context) * 0.15,
                      ),
                      Opacity(
                        opacity: 0.0,
                        child: Divider(
                          height: displayHeight(context) * 0.005,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Please check your internet connection ...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: displayWidth(context) * 0.055,
                            fontFamily: "PatuaOne",
                          ),
                        ),
                      ),
                    ]),
              );
            return Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 16.0),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0.0),
                itemBuilder: (BuildContext context, int index) {
                  return displayDataCompleteandPending(
                      context, snapshot.data.docs[index]);
                },
                itemCount: snapshot.data.docs.length,
              ),
            );
          },
          stream: FirebaseFirestore.instance
              .collection(currentUser.uid.toString())
              .doc("All")
              .collection("list")
              .doc(widget.topic)
              .collection("Complete")
              .snapshots());
    }

    Widget displayPendingSubtopic() {
      return StreamBuilder(
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi_off_outlined,
                        size: displayWidth(context) * 0.15,
                      ),
                      Opacity(
                        opacity: 0.0,
                        child: Divider(
                          height: displayHeight(context) * 0.005,
                        ),
                      ),
                      Center(
                        child: Text(
                          "Please check your internet connection ...",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            //fontWeight: FontWeight.bold,
                            fontSize: displayWidth(context) * 0.055,
                            fontFamily: "PatuaOne",
                          ),
                        ),
                      ),
                    ]),
              );
            return Padding(
              padding: const EdgeInsets.only(top: 0.0, bottom: 16.0),
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0.0),
                itemBuilder: (BuildContext context, int index) {
                  return displayDataCompleteandPending(
                      context, snapshot.data.docs[index]);
                },
                itemCount: snapshot.data.docs.length,
              ),
            );
          },
          stream: FirebaseFirestore.instance
              .collection(currentUser.uid.toString())
              .doc("All")
              .collection("list")
              .doc(widget.topic)
              .collection("Pending")
              .snapshots());
    }

    String myTitle = widget.topic;
    String imageLoc = "";
    if (myTitle.toLowerCase().contains("chemistry"))
      imageLoc = "images/chemistry.jpeg";
    else if (myTitle.toLowerCase().contains("biology") ||
        myTitle.toLowerCase() == "bio")
      imageLoc = "images/biology.jpg";
    else if (myTitle.toLowerCase().contains("physics"))
      imageLoc = "images/physics.jpg";
    else if (myTitle.toLowerCase().contains("operating system") ||
        myTitle.toLowerCase().contains("os"))
      imageLoc = "images/os.jpg";
    else if (myTitle.toLowerCase().contains("english"))
      imageLoc = "images/english.jpg";
    else if (myTitle.toLowerCase().contains("commerce"))
      imageLoc = "images/commerce.jpg";
    else if (myTitle.toLowerCase().contains("computer"))
      imageLoc = "images/computer.jpg";
    else if (myTitle.toLowerCase().contains("history"))
      imageLoc = "images/history.jpeg";
    else if (myTitle.toLowerCase().contains("maths") ||
        myTitle.toLowerCase().contains("mathematics") ||
        myTitle.toLowerCase().contains("mathematic"))
      imageLoc = "images/maths.jpg";
    else if (myTitle.toLowerCase().contains("data structure"))
      imageLoc = "images/datastructure.webp";
    else if (myTitle.toLowerCase().contains("data science"))
      imageLoc = "images/datascience.webp";
    else if (myTitle.toLowerCase().contains("geography") ||
        myTitle.toLowerCase() == ("geo"))
      imageLoc = "images/geography.webp";
    else if (myTitle.toLowerCase().contains("engineering drawing") ||
        myTitle.toLowerCase() == "ed")
      imageLoc = "images/ed.jpg";
    else
      imageLoc = "images/default.jpg";

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              child: Container(
            constraints: BoxConstraints.expand(),
            height: displayHeight(context),
            width: displayWidth(context),
            color: Color(0xfbbebf6f7),
          )),
          Positioned(
            top: 0.0,
            width: displayWidth(context),
            child: Container(
              height: displayHeight(context) * 0.3,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Navigating back
                  Positioned(
                    top: displayHeight(context) * 0.05,
                    left: displayWidth(context) * 0.06,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.arrow_back_ios,
                          size: displayWidth(context) * 0.06),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),

                  // Topic image
                  Positioned(
                    top: displayHeight(context) * 0.052,
                    right: displayWidth(context) * 0.04,
                    child: Hero(
                      tag: myTitle,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        //elevation: 40.0,
                        borderOnForeground: true,
                        shadowColor: Colors.red,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: Image.asset(
                            imageLoc,
                            height: displayHeight(context) * 0.165,
                            width: displayWidth(context) * 0.33,
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Topic Name

                  Positioned(
                    right: displayWidth(context) * 0.06,
                    top: displayHeight(context) * 0.235,
                    child: Text(
                      widget.topic,
                      style: TextStyle(
                          fontFamily: "PatuaOne",
                          letterSpacing: 1.3,
                          color: Colors.white,
                          fontSize: displayWidth(context) * 0.0445),
                    ),
                  ),

                  // favourite Subject !!

                  Positioned(
                      top: displayHeight(context) * 0.17,
                      left: displayWidth(context) * 0.0535,
                      child: CircleAvatar(
                        radius: displayWidth(context) * 0.0735,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: displayWidth(context) * 0.066,
                          backgroundColor: Colors.white,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(widget.isfav
                                ? Icons.favorite
                                : Icons.favorite_border_outlined),
                            color: Colors.red,
                            iconSize: displayWidth(context) * 0.068,
                          ),
                        ),
                      )),
                ],
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/a4.jpg"),
                  fit: BoxFit.fitWidth,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          Positioned(
              top: displayHeight(context) * 0.32,
              left: displayWidth(context) * 0.04,
              right: displayWidth(context) * 0.04,
              child: Container(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int current) {
                    return GestureDetector(
                      onTap: () {
                        print("tap");
                        setState(() {
                          category = current;
                        });
                        print(category);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 18.0, bottom: 10.0, left: 42.0, right: 20.0),
                        child: Text(
                          listOfCategory2[current],
                          style: TextStyle(
                            color: (current == category)
                                ? Colors.white
                                : Colors.white60,
                            fontSize: displayWidth(context) * 0.045,
                            fontWeight: (current == category)
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: listOfCategory2.length,
                  scrollDirection: Axis.horizontal,
                ),
                height: displayHeight(context) * 0.075,
                width: displayWidth(context) * 0.64,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        "images/a4.jpg",
                      ),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
              )),
          Positioned(
            top: displayHeight(context) * 0.42,
            child: Container(
              alignment: Alignment.center,
              height: displayHeight(context) * 0.58,
              width: displayWidth(context) * 0.85,
              //color: Colors.purple,

              child: (category == 0)
                  ? displayAllSubtopic()
                  : (category == 1)
                      ? displayCompleteSubtopic()
                      : displayPendingSubtopic(),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        child: Icon(Icons.add),
        onPressed: () {
          // to do
          AddNdewSubtopic(context, widget.topic);
        },
      ),
    );
  }
}
