import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginv1/constants/theme.dart';


class MessageTextField extends StatefulWidget {
  final String currentId;
  final String friendId;

  MessageTextField(this.currentId,this.friendId);

  @override
  _MessageTextFieldState createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends State<MessageTextField> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
         
         decoration: kMessageContainerDecoration,

         child: Row(
           children: [
             Expanded(child: TextField(
               cursorColor: primaryClr,
               controller: _controller,
                decoration: kMessageTextFieldDecoration,
                
             )),
             SizedBox(width: 20,),
             GestureDetector(
               onTap: ()async{
                 String message = _controller.text;
                 _controller.clear();
                 await FirebaseFirestore.instance.collection('users').doc(widget.currentId).collection('messages').doc(widget.friendId).collection('chats').add({
                    "senderId":widget.currentId,
                    "receiverId":widget.friendId,
                    "message":message,
                    "type":"text",
                    "date": DateTime.now(),
                 }).then((value) {
                   FirebaseFirestore.instance.collection('users').doc(widget.currentId).collection('messages').doc(widget.friendId).set({
                       'last_msg':message,
                   });
                 });

                 await FirebaseFirestore.instance.collection('users').doc(widget.friendId).collection('messages').doc(widget.currentId).collection("chats").add({
                   "senderId":widget.currentId,
                   "receiverId":widget.friendId,
                   "message":message,
                   "type":"text",
                   "date": DateTime.now(),

                 }).then((value){
                   FirebaseFirestore.instance.collection('users').doc(widget.friendId).collection('messages').doc(widget.currentId).set({
                     "last_msg":message
                   });
                 });
               },
               child: Text(
                 'Send',
                 style: kSendButtonTextStyle,
               ),
             )
           ],
         ),
        
      ),
    );
  }
}