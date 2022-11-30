import 'package:chat_app/screens/auth_screen.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App',
      theme: ThemeData(

        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor:  Colors.deepPurple,
        accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
        buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
      )
      ),
      home:StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(),builder:(ctx, snapshot){
        if(snapshot.hasData) {
          return const ChatScreen();
    }
        return const AuthScreen();
    } ),);
  }
}

