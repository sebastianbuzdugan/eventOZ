import 'package:cached_network_image/cached_network_image.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/models/modele.dart';
import 'package:loginv1/ui/pages/chat1screen.dart';
import 'package:loginv1/ui/pages/search_users.dart';



class HomeChat extends StatefulWidget {
  UserModel user;
  HomeChat(this.user);
  @override
  _HomeChatState createState() => _HomeChatState();
}

class _HomeChatState extends State<HomeChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secClr,
      appBar: AppBar(
        title: Text('chatRooms'.tr),
        centerTitle: true,
        backgroundColor: primaryClr,
        
      ),

      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(widget.user.uid).collection('messages').snapshots(),
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            if(snapshot.data.docs.length < 1){
              return Center(
                child: Text("noChats".tr),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context,index){
                var friendId = snapshot.data.docs[index].id;
                var lastMsg = snapshot.data.docs[index]['last_msg'];
                return FutureBuilder(
                  future: FirebaseFirestore.instance.collection('users').doc(friendId).get(),
                  builder: (context,AsyncSnapshot asyncSnapshot){
                    if(asyncSnapshot.hasData){
                      var friend = asyncSnapshot.data;
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: CachedNetworkImage(
                            imageUrl:friend['photoUrl'],
                            placeholder: (conteext,url)=>CircularProgressIndicator(),
                            errorWidget: (context,url,error)=>Icon(Icons.error,),
                            height: 50,
                          ),
                        ),
                        title: Text(friend['name']),
                        subtitle: Container(
                          child: Text("$lastMsg",style: TextStyle(color: Colors.grey),overflow: TextOverflow.ellipsis,),
                        ),
                        onTap: (){
                         Get.to(Chat1Screen(
                            currentUser: widget.user,
                             friendId: friend['uid'],
                              friendName: friend['name'],
                               friendImage: friend['photoUrl'])

                         );
                          
                        },
                      );
                    }
                    return LinearProgressIndicator();
                  },

                );
              });
          }
          return Center(child: CircularProgressIndicator(),);
        }),

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryClr,
        child: Icon(Icons.search),
            onPressed: ()  {
         Get.to(SearchScreen(widget.user));
       },
      ),
      
    );
  }
}