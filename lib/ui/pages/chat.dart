import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/ui/pages/homechat.dart';
import '../../controllers/controllers.dart';
import '../../models/modele.dart';

final _firestore = FirebaseFirestore.instance;
late User loggedInUser;

class ChatScreen extends StatefulWidget {
  final bool isAdmin;

  ChatScreen({required this.isAdmin});

  @override
  _ChatScreenState createState() => _ChatScreenState(isAdmin: isAdmin);
}

class _ChatScreenState extends State<ChatScreen> {
  final bool isAdmin;
  _ChatScreenState({required this.isAdmin});

  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final AuthController authController = AuthController.to;
  String messageText = '';

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        return user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secClr,
      appBar: AppBar(
        leading: null,
        title: Text('⚡️Chat'),
        actions: [
          FloatingActionButton(
            onPressed: () async {
              User? user = FirebaseAuth.instance.currentUser;
              final DocumentSnapshot documentSnapshot = await FirebaseFirestore
                  .instance
                  .collection('users')
                  .doc(user!.uid)
                  .get();
              UserModel userModel = UserModel.fromMap(
                  documentSnapshot.data() as Map<String, dynamic>);
              Get.to(HomeChat(userModel));
            },
            elevation: 1,
            backgroundColor: primaryClr,
            child: const Icon(Icons.search),
          ),
        ],
        backgroundColor: primaryClr,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            MessagesStream(),
            isAdmin
              ? Container(
                  decoration: kMessageContainerDecoration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          cursorColor: primaryClr,
                          controller: messageTextController,
                          onChanged: (value) {
                            messageText = value;
                          },
                          decoration: kMessageTextFieldDecoration,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          if (messageText.isNotEmpty) {
                            print('USERNAME: ${loggedInUser.displayName}' );
                            messageTextController.clear();
                            _firestore.collection('messages').add({
                              'text': messageText,
                              'name': loggedInUser.displayName,
                              'sender': loggedInUser.email,
                              'msgTime': DateTime.now(),
                            });
                            messageText = '';
                          }
                        },
                        child: Text(
                          'send'.tr,
                          style: kSendButtonTextStyle,
                        ),
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .orderBy('msgTime', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText =
              (message.data() as Map<String, dynamic>)['text'];
          final messageSender =
              (message.data() as Map<String, dynamic>)['sender'];
          final messageName =
              (message.data() as Map<String, dynamic>)['name'];
          final currentUser = loggedInUser.email;
          final messageBubble = MessageBubble(
            sender: messageSender,
            name: messageName,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}


class MessageBubble extends StatelessWidget {
  MessageBubble({
    this.sender,
    this.name,
    this.text = '',
    this.isMe = false,
  });

  final String? sender;
  final String? name;
  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name ?? 'Unknown',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Text(
            sender ?? 'Unknown',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? primaryClr : Colors.white,
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  color: isMe ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
