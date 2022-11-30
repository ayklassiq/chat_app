import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  // final String userImage;
  final String userName;

  MessageBubble(
    // this.userImage,
    this.userName,
    this.message,
    this.isMe,
  );
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: isMe ? Colors.grey[500] : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(12),
              topLeft: const Radius.circular(12),
              bottomLeft: !isMe ? const Radius.circular(0) : const Radius.circular(12),
              bottomRight: isMe ? const Radius.circular(0) : const Radius.circular(12),
            ),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          margin: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 8,
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              // FutureBuilder<dynamic>(
              //     future: FirebaseFirestore.instance.collection('users').doc(userId).get(),
              //     builder: (context,  snapshot) {
              //     if (snapshot.connectionState==ConnectionState.waiting){
              //       return  Text('loading...........');
              //     }
              //
              Text(
                userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMe
                      ? Colors.black
                      : Theme.of(context).accentTextTheme.subtitle1!.color,
                ),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
