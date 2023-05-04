import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/models/user_models.dart';
import 'package:loginv1/ui/widgets/message_textfield.dart';
import 'package:loginv1/ui/widgets/single_message.dart';

class Chat1Screen extends StatelessWidget {
  final UserModel currentUser;
  final String friendId;
  final String friendName;
  final String friendImage;
  
  Chat1Screen({
    required this.currentUser,
    required this.friendId,
    required this.friendName,
    required this.friendImage,
  });
  
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold( 
      backgroundColor: secClr,
      appBar: AppBar(
        foregroundColor: Colors.black87,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
          children: [
            SizedBox(width: w/6,),
            ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child:  CachedNetworkImage(
                            imageUrl:friendImage,
                            placeholder: (conteext,url)=>CircularProgressIndicator(),
                            errorWidget: (context,url,error)=>Icon(Icons.error,),
                            height: 40,
                          ),
            ),
            SizedBox(width: 5,),
            Text(friendName,style: TextStyle(fontSize: 20),)
          ],
        ),
      ),

      body: Column(
        children: [
         
           Expanded(child: Container(
             padding: EdgeInsets.all(10),
             decoration: BoxDecoration(
               color: secClr,
               borderRadius: BorderRadius.only(
                 topLeft: Radius.circular(25),
                 topRight: Radius.circular(25)
               )
             ),
             child: StreamBuilder(
               stream: FirebaseFirestore.instance.collection("users").doc(currentUser.uid).collection('messages').doc(friendId).collection('chats').orderBy("date",descending: true).snapshots(),
               builder: (context,AsyncSnapshot snapshot){
                   if(snapshot.hasData){
                     if(snapshot.data.docs.length < 1){
                       return Center(
                         child: Text("Say Hi"),
                       );
                     }
                     return ListView.builder(
                       itemCount: snapshot.data.docs.length,
                       reverse: true,
                       physics: BouncingScrollPhysics(),
                       itemBuilder: (context,index){
                          bool isMe = snapshot.data.docs[index]['senderId'] == currentUser.uid;
                          return SingleMessage(message: snapshot.data.docs[index]['message'], isMe: isMe);
                       });
                   }
                   return Center(
                     child: CircularProgressIndicator()
                   );
               }),
           )),
           MessageTextField(currentUser.uid, friendId),
        ],
      ),
      
    );
  }
}