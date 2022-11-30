import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Future<User?> data() async {
      return FirebaseAuth.instance.currentUser;
    }
    return  FutureBuilder(
        future: data(),
        builder:(ctx, futureSnapshot){
          if (futureSnapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          return StreamBuilder<dynamic>(
        stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: true).snapshots(),
        builder: (ctx, chatSnapShot) {
          if (chatSnapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDocs = chatSnapShot.data.docs;

              return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                chatDocs[index]['text'],
                  chatDocs[index]['username'],
                // chatDocs[index]['image_url'],
                chatDocs[index]['userId']==FirebaseAuth.instance.currentUser!.uid
                  // (futureSnapshot as dynamic).data.uid,
                  // FirebaseAuth.instance.currentUser!.uid

              ),
            );
          });
        });
  }
}
