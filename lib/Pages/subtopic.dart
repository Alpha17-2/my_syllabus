import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Syllabus/Helper/DeviceSize.dart';

class subtopic extends StatelessWidget {
  final String topic;
  subtopic({this.topic});
  @override
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser;
    Widget displayData(BuildContext context, DocumentSnapshot doc) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
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
                    radius: displayWidth(context) * 0.135,
                    child: Image(
                      image: AssetImage("images/a6.png"),
                      width: displayWidth(context) * 0.18,
                      height: displayHeight(context) * 0.1,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  top: displayHeight(context) * 0.03,
                  left: displayWidth(context) * 0.36,
                  child: Text(
                    doc['title'],
                    style: TextStyle(
                      fontSize: displayWidth(context) * 0.055,
                      fontFamily: "PatuaOne",
                    ),
                  ),
                ),

                Positioned(
                  top: displayHeight(context) * 0.09,
                  left: displayWidth(context) * 0.36,
                  child: Text(
                    "Total topics : ",
                    style: TextStyle(
                      fontSize: displayWidth(context) * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  top: displayHeight(context) * 0.09,
                  left: displayWidth(context) * 0.6,
                  child: Text(
                    "5",
                    style: TextStyle(
                      fontSize: displayWidth(context) * 0.0415,
                    ),
                  ),
                ),
                Positioned(
                  top: displayHeight(context) * 0.12,
                  left: displayWidth(context) * 0.36,
                  child: Text(
                    "Covered topics : ",
                    style: TextStyle(
                      fontSize: displayWidth(context) * 0.04,
                    ),
                  ),
                ),
                Positioned(
                  top: displayHeight(context) * 0.12,
                  left: displayWidth(context) * 0.66,
                  child: Text(
                    "5",
                    style: TextStyle(
                      fontSize: displayWidth(context) * 0.04,
                    ),
                  ),
                ),

                // Mark favourite

                Positioned(
                  top: displayHeight(context) * 0.0115,
                  right: displayWidth(context) * 0.02,
                  child: IconButton(
                    icon: Icon(Icons.star_border),
                    onPressed: () {
                      // To-do implementation
                    },
                  ),
                ),

                // Delete Syllabus

                Positioned(
                  bottom: displayHeight(context) * 0.00,
                  right: displayWidth(context) * 0.02,
                  child: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // To-do implementation
                      FirebaseFirestore.instance
                          .collection(currentUser.uid.toString())
                          .doc(topic)
                          .collection(topic)
                          .doc(doc['title'])
                          .delete();
                    },
                  ),
                ),
              ],
            ),
            height: displayHeight(context) * 0.2,
          ),
        ),
      );
    }

    void AddNdewSubject(BuildContext context) async {
      TextEditingController mycontroller = TextEditingController();
      return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Add new subject !",
              style: TextStyle(
                fontSize: displayWidth(context) * 0.05,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            content: TextField(
              controller: mycontroller,
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection(currentUser.uid.toString())
                      .doc(topic)
                      .collection(topic)
                      .doc(mycontroller.text.toString())
                      .set({
                    "title": mycontroller.text.toString(),
                    "important": false,
                    "complete": false
                  });
                  Navigator.pop(context);
                },
                child: Text("Submit"),
              )
            ],
          );
        },
      );
    }

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
              height: displayHeight(context) * 0.25,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      top: displayHeight(context) * 0.064,
                      left: displayWidth(context) * 0.04,
                      child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.arrow_back_ios,
                            size: displayWidth(context) * 0.06),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )),

                  // Profile Name

                  Positioned(
                    top: displayHeight(context) * 0.08,
                    child: Text(
                      topic,
                      style: TextStyle(
                          fontFamily: "PatuaOne",
                          letterSpacing: 1.3,
                          color: Colors.white,
                          fontSize: displayWidth(context) * 0.05),
                    ),
                  ),

                  // Total topic heading

                  Positioned(
                    child: Text(
                      "Total Topics  : ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: displayWidth(context) * 0.045,
                        fontFamily: "PatuaOne",
                      ),
                    ),
                    top: displayHeight(context) * 0.18,
                    left: displayWidth(context) * 0.08,
                  ),

                  // Total topic answer in integer

                  Positioned(
                    top: displayHeight(context) * 0.18,
                    left: displayWidth(context) * 0.37,
                    child: Text(
                      "5",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: displayWidth(context) * 0.045,
                        fontFamily: "PatuaOne",
                      ),
                    ),
                  ),

                  // Covered topic heading

                  Positioned(
                    child: Text(
                      "Covered Topics  : ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: displayWidth(context) * 0.045,
                        fontFamily: "PatuaOne",
                      ),
                    ),
                    top: displayHeight(context) * 0.18,
                    right: displayWidth(context) * 0.1,
                  ),

                  // Total topic answer in integer

                  Positioned(
                    top: displayHeight(context) * 0.18,
                    right: displayWidth(context) * 0.06,
                    child: Text(
                      "5",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: displayWidth(context) * 0.045,
                        fontFamily: "PatuaOne",
                      ),
                    ),
                  )
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
            top: displayHeight(context) * 0.26,
            child: Container(
                alignment: Alignment.center,
                height: displayHeight(context) * 0.74,
                width: displayWidth(context) * 0.85,
                //rcolor: Colors.purple,
                child: StreamBuilder(
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
                      return ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return displayData(
                              context, snapshot.data.docs[index]);
                        },
                        itemCount: snapshot.data.docs.length,
                      );
                    },
                    stream: FirebaseFirestore.instance
                        .collection(currentUser.uid.toString())
                        .doc(topic)
                        .collection(topic)
                        .snapshots())),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[400],
        child: Icon(Icons.add),
        onPressed: () {
          // to do
          AddNdewSubject(context);
        },
      ),
    );
  }
}
