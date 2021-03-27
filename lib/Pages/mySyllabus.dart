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

    // Displaying all data

    Widget displayAllData(BuildContext context, DocumentSnapshot doc) {
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
               gradient: LinearGradient(colors: [
                  Color(0xfbb003366),
                 Color(0xfbb003366)

                 
                 
               ],
               begin: Alignment.topLeft,
               end: Alignment.bottomRight
               ),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: displayWidth(context) * 0.02,
                    child:Card(
                      elevation: 10.5,
                      color: Colors.blue[100],
                      child: Container(
                        height: displayHeight(context)*0.14,
                        width: displayWidth(context)*0.25,
                        child: Center(
                          child: Image(
                            image: AssetImage("images/a6.png"),
                            width: displayWidth(context) * 0.22,
                            height: displayHeight(context) * 0.12,
                            fit: BoxFit.fill,
                          ),
                        ),
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
                        doc['important'] ? Icons.star : Icons.star_border,
                        color: Colors.purple,
                      ),
                      onPressed: () {
                        // To-do implementation
                        if (doc['important']) {
                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
                              .doc(doc['title'])
                              .update({"important": false});
                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("Important")
                              .collection("list")
                              .doc(doc['title'])
                              .delete();
                        } else {
                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("Important")
                              .collection("list")
                              .doc(doc['title'])
                              .set({"title": doc['title'], "important": true});
                          FirebaseFirestore.instance
                              .collection(currentUser.uid.toString())
                              .doc("All")
                              .collection("list")
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
                            .doc("All")
                            .collection("list")
                            .doc(doc['title'])
                            .delete();
                        FirebaseFirestore.instance
                            .collection(currentUser.uid.toString())
                            .doc("Important")
                            .collection("list")
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

    Widget displayImportatntData(BuildContext context, DocumentSnapshot doc) {
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
                    child:Card(
                      elevation: 10.5,
                      color: Colors.blue[100],
                      child: Container(
                        height: displayHeight(context)*0.14,
                        width: displayWidth(context)*0.25,
                        child: Center(
                          child: Image(
                            image: AssetImage("images/a6.png"),
                            width: displayWidth(context) * 0.22,
                            height: displayHeight(context) * 0.12,
                            fit: BoxFit.fill,
                          ),
                        ),
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

                
                ],
              ),
              height: displayHeight(context) * 0.2,
            ),
          ),
        ),
      );
    }

    Widget displayAllSyllabus() {
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
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return (category == 0)
                    ? displayAllData(context, snapshot.data.docs[index])
                    : displayImportatntData(context, snapshot.data.docs[index]);
              },
              itemCount: snapshot.data.docs.length,
            );
          },
          stream: FirebaseFirestore.instance
              .collection(currentUser.uid.toString())
              .doc(listOfCategory[category])
              .collection("list")
              .snapshots());
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
              top: displayHeight(context)*0.2,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                ),
                height: displayHeight(context)*0.78,
                width: displayWidth(context),
                child: Opacity(opacity: 0.35,child: Image(image: AssetImage("images/d2.jpg"),height: displayHeight(context)*0.75,fit: BoxFit.fill,),),))
           , Positioned(
              top: 0.0,
              width: displayWidth(context),
              child: Container(
                height: displayHeight(context) * 0.272,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Profile Picture
                    Positioned(
                      top: displayHeight(context) * 0.07,
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
                      top: displayHeight(context) * 0.088,
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
                      top: displayHeight(context) * 0.072,
                      right: displayWidth(context) * 0.02,
                    ),

                    // Chosing Category

                    Positioned(
                        top: displayHeight(context) * 0.175,
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
                child: displayAllSyllabus(),
              ),
            ),
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
