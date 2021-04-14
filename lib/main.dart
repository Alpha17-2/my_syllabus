import 'package:Syllabus/Helper/auth.dart';
import 'package:Syllabus/Pages/authscreen.dart';
import 'package:Syllabus/Pages/mySyllabus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Helper/auth_notifier.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
        providers: [         
          ChangeNotifierProvider(
            create: (context) => AuthNotifier(),
          ),
          Provider<authservice>(
              create: (_) => authservice(FirebaseAuth.instance)),
          StreamProvider(
              create: (context) =>
                  context.read<authservice>().authStateChanges),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Consumer<AuthNotifier>(
          builder: (context, notifier, child) {
            return notifier.user != null ? mySyllabus() : wrapper();
          },
        )));
  }
}

class wrapper extends StatelessWidget {
  const wrapper({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    
    if (firebaseUser != null) {
      return mySyllabus();
    } else
      return authscreen();
  }
}
