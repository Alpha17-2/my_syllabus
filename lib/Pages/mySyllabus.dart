import 'package:Syllabus/Helper/DeviceSize.dart';
import 'package:Syllabus/Helper/auth_notifier.dart';
import 'package:Syllabus/Helper/syllabusapi.dart';
import 'package:Syllabus/Pages/subtopic.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class mySyllabus extends StatefulWidget {
  @override
  _mySyllabusState createState() => _mySyllabusState();
}

class _mySyllabusState extends State<mySyllabus> {
  @override
  @override
  int category = 0;
  Widget build(BuildContext context) {
    User currentUser = FirebaseAuth.instance.currentUser;
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    
    final listOfCategory = ["All", "Important"];

    // Adding a subject
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
                  int newValue;
                  FirebaseFirestore.instance
                      .collection(currentUser.uid.toString())
                      .doc(mycontroller.text.toString())
                      .set({
                    "title": mycontroller.text.toString(),
                    "important": false
                  });

                  Navigator.of(context).pop();
                },
                child: Text("Submit"),
              )
            ],
          );
        },
      );
    }

    Widget displayData(BuildContext context, DocumentSnapshot doc) {
      bool isImportant = doc['important'];
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => subtopic(
                        topic: doc['title'],
                      )));
        },
        child: Padding(
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
                    top: displayHeight(context) * 0.08,
                    left: displayWidth(context) * 0.37,
                    child: Text(
                      doc['title'],
                      style: TextStyle(
                        fontSize: displayWidth(context) * 0.055,
                        fontFamily: "PatuaOne",
                      ),
                    ),
                  ),

                  // Mark important

                  Positioned(
                    top: displayHeight(context) * 0.0115,
                    right: displayWidth(context) * 0.02,
                    child: IconButton(
                      icon: Icon(
                        isImportant ? Icons.star : Icons.star_border,
                        color: Colors.yellow,
                      ),
                      onPressed: () {
                        // To-do implementation
                        if (isImportant) {
                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc(doc['title'])
                              .update({"important": false});
                          setState(() {
                            isImportant = false;
                          });
                        } else {
                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc(doc['title'])
                              .update({"important": true});
                        }
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
        ),
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
                    // Profile Picture
                    Positioned(
                      top: displayHeight(context) * 0.064,
                      left: displayWidth(context) * 0.08,
                      child: Card(
                          color: Colors.blue[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Icon(Icons.person,
                              size: displayWidth(context) * 0.12)),
                    ),

                    // Profile Name

                    Positioned(
                      top: displayHeight(context) * 0.082,
                      left: displayWidth(context) * 0.25,
                      child: Text(
                        currentUser.displayName,
                        style: TextStyle(
                            fontFamily: "PatuaOne",
                            letterSpacing: 1.3,
                            color: Colors.white,
                            fontSize: displayWidth(context) * 0.05),
                      ),
                    ),

                    // Logout Icon

                    Positioned(
                      child: IconButton(
                        icon: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          signout(authNotifier);
                        },
                      ),
                      top: displayHeight(context) * 0.064,
                      right: displayWidth(context) * 0.02,
                    ),

                    // Chosing Category

                    Positioned(
                        top: displayHeight(context) * 0.16,
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
                                      top: 18.0,
                                      bottom: 10.0,
                                      left: 75.0,
                                      right: 50.0),
                                  child: Text(
                                    listOfCategory[current],
                                    style: TextStyle(
                                      color: (current == category)
                                          ? Colors.black
                                          : Colors.black45,
                                      fontSize: displayWidth(context) * 0.045,
                                      fontWeight: (current == category)
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: listOfCategory.length,
                            scrollDirection: Axis.horizontal,
                          ),
                          height: displayHeight(context) * 0.075,
                          width: displayWidth(context) * 0.64,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                        ))
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

            // 
            Positioned(
              top: displayHeight(context) * 0.26,
              child: Container(
                  alignment: Alignment.center,
                  height: displayHeight(context) * 0.74,
                  width: displayWidth(context) * 0.85,
                  //color: Colors.purple,
                  child: StreamBuilder(
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            }));
  }
}
