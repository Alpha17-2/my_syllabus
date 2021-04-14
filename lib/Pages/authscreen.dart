import 'package:Syllabus/Helper/DeviceSize.dart';
import 'package:Syllabus/Helper/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class authscreen extends StatefulWidget {
  @override
  _authscreenState createState() => _authscreenState();
}

class _authscreenState extends State<authscreen> {
  final authservice _auth = authservice(FirebaseAuth.instance);
  bool loginstate = true;
  String mobileNumber = "";
  String email = "";
  String pass = "";
  String name = "";
  TextEditingController emailControl;
  TextEditingController passControl;
  TextEditingController confirmPassControl;
  TextEditingController nameController;
  bool loginPass = true;
  bool seePass = true;
  bool seeConfirmPass = true;

  void initState() {
    super.initState();
    emailControl = TextEditingController();
    passControl = TextEditingController();
  }

  @override
  void dispose() {
    emailControl.dispose();
    confirmPassControl.dispose();
    nameController.dispose();
    passControl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lg1 = Text(
      "Don't have an account ?",
      style: TextStyle(
        color: Colors.black,
        fontSize: displayWidth(context) * 0.04,
        fontWeight: FontWeight.w500,
      ),
    );

    final lg2 = Text(
      "Register Now",
      style: TextStyle(
          color: Colors.blue[800],
          fontWeight: FontWeight.w500,
          fontSize: displayWidth(context) * 0.04),
    );

    final sp1 = Text(
      "Already have an account ?",
      style: TextStyle(
        color: Colors.black,
        fontSize: displayWidth(context) * 0.04,
        fontWeight: FontWeight.w500,
      ),
    );

    final sp2 = Text(
      "Sign in",
      style: TextStyle(
          color: Colors.blue[800],
          fontWeight: FontWeight.w500,
          fontSize: displayWidth(context) * 0.04),
    );
    final displayatLastofLogin = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        lg1,
        TextButton(
          child: lg2,
          onPressed: () {
            setState(() {
              loginstate = !loginstate;
            });
          },
        )
      ],
    );
    final displayLastofSignup = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        sp1,
        TextButton(
          child: sp2,
          onPressed: () {
            setState(() {
              loginstate = !loginstate;
            });
          },
        )
      ],
    );
    Widget signup(BuildContext context) {
      // To do
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 50),
              child: Text(
                "Register in to get started",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: displayWidth(context) * 0.045,
                ),
              ),
            ),
            Opacity(
              opacity: 0.0,
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Experience the all new App!",
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: displayWidth(context) * 0.045,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle_outlined),
                  suffix: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => emailControl.clear()),
                  hintText: "Name",
                  labelText: "Name",
                ),
                keyboardType: TextInputType.name,
                showCursor: true,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: TextFormField(
                controller: emailControl,
                decoration: InputDecoration(
                  icon: Icon(Icons.mail),
                  suffix: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => emailControl.clear()),
                  hintText: "abc@gmail.com",
                  labelText: "Email ID",
                ),
                keyboardType: TextInputType.emailAddress,
                showCursor: true,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
              ),
              child: TextFormField(
                controller: passControl,
                decoration: InputDecoration(
                  suffix: IconButton(
                      icon: Icon(seePass
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined),
                      onPressed: () {
                        setState(() {
                          seePass = !seePass;
                        });
                      }),
                  icon: Icon(Icons.no_encryption_gmailerrorred_rounded),
                  hintText: "******",
                  labelText: "Password",
                ),
                obscureText: seePass,
                keyboardType: TextInputType.emailAddress,
                showCursor: true,
                onChanged: (value) {
                  setState(() {
                    pass = value;
                  });
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    pass = value;
                  });
                },
              ),
            ),
           
            Opacity(opacity: 0.0,child: Divider(
              height: displayHeight(context)*0.04,
            ),),
            Center(
              child: GestureDetector(
            onTap: (){
            _auth.signUp(email: email,password: pass);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: displayHeight(context)*0.06,
              width: displayWidth(context)*0.8,
              child: Center(child: Text("REGISTER",style: TextStyle(
                color: Colors.white,

              ),)),
            ),
          ),
            ),
            Opacity(opacity: 0.0,child: Divider()),
            Center(child: displayLastofSignup,),
          ],
        ),
      );
    }

    Widget login(BuildContext context) {
      // To do
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 50),
              child: Text(
                "Login to get started",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: displayWidth(context) * 0.045,
                ),
              ),
            ),
            Opacity(
              opacity: 0.0,
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Experience the all new App!",
                style: TextStyle(
                  // fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: displayWidth(context) * 0.045,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 35),
              child: TextFormField(
                controller: emailControl,
                decoration: InputDecoration(
                  icon: Icon(Icons.mail),
                  suffix: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => emailControl.clear()),
                  hintText: "abc@gmail.com",
                  labelText: "Email ID",
                ),
                keyboardType: TextInputType.emailAddress,
                showCursor: true,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    email = value;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
              ),
              child: TextFormField(
                controller: passControl,
                decoration: InputDecoration(
                  suffix: IconButton(
                      icon: Icon(loginPass
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined),
                      onPressed: () {
                        setState(() {
                          loginPass = !loginPass;
                        });
                      }),
                  icon: Icon(Icons.no_encryption_gmailerrorred_rounded),
                  hintText: "******",
                  labelText: "Password",
                ),
                obscureText: loginPass,
                keyboardType: TextInputType.emailAddress,
                showCursor: true,
                onChanged: (value) {
                  setState(() {
                    pass = value;
                  });
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    pass = value;
                  });
                },
              ),
            ),
            Opacity(opacity: 0.0,child: Divider(
              height: displayHeight(context)*0.05,
            ),),
            Center(
              child: GestureDetector(
            onTap: () async {
                      dynamic currentUser =
                          await _auth.signIn(email: email,password: pass);
                      if (currentUser.toString() != 'valid') {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  content: Text("Wrong password"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Try again"))
                                  ],
                                ));
                      }
                    },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(15.0),
              ),
              height: displayHeight(context)*0.06,
              width: displayWidth(context)*0.8,
              child: Center(child: Text("LOGIN",style: TextStyle(
                color: Colors.white,

              ),)),
            ),
          ),
              
            ),
            Opacity(
              opacity: 0.0,
              child: Divider(
                height: displayHeight(context) * 0.2,
              ),
            ),
            Center(
              child: displayatLastofLogin,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: loginstate ? login(context) : signup(context),
    );
  }
}
