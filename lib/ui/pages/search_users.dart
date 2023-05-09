
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/ui/pages/chat1screen.dart';

import '../../models/modele.dart';


class SearchScreen extends StatefulWidget {
  UserModel user;
  SearchScreen(this.user);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map> searchResult =[];
  bool isLoading = false;

  void onSearch()async{
    setState(() {
      searchResult = [];
      isLoading = true;
    });
    await FirebaseFirestore.instance.collection('users').where("name",isEqualTo: searchController.text).get().then((value){
       if(value.docs.length < 1){
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No User Found")));
            setState(() {
      isLoading = false;
    });
    return;
       }
       value.docs.forEach((user) {
          if(user.data()['email'] != widget.user.email){
               searchResult.add(user.data());
          }
        });
     setState(() {
      isLoading = false;
    });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryClr,
        title: Text("searchUser".tr),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
           Row(
             children: [
               
               Expanded(
                 child: Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: TextField(
                     
                     cursorColor: primaryClr,
                     controller: searchController,
                     decoration: InputDecoration(
                         filled: true,

   focusedBorder: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(20)),
     borderSide: BorderSide(width: 1,color: primaryClr),
   ),
   
  
   border: OutlineInputBorder(
     borderRadius: BorderRadius.all(Radius.circular(20)),
     borderSide: BorderSide(width: 1,)
   ),
  
                       hintText: 'typeUser'.tr,
                       
                     ),
                   ),
                 ),
               ),
               IconButton(onPressed: (){
                  onSearch();
               }, icon: Icon(Icons.search))
             ],
           ),
           if(searchResult.length > 0)
              Expanded(child: ListView.builder(
                itemCount: searchResult.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return ListTile(
                    leading: CircleAvatar(
                      child: Image.network(searchResult[index]['photoUrl']),
                    ),
                    title: Text(searchResult[index]['name']),
                    subtitle: Text(searchResult[index]['email']),
                    trailing: IconButton(onPressed: (){
                        setState(() {
                          searchController.text = "";
                        });
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat1Screen(
                             currentUser: widget.user, 
                             friendId: searchResult[index]['uid'],
                              friendName: searchResult[index]['name'],
                               friendImage: searchResult[index]['photoUrl'])));
                    }, icon: Icon(Icons.message)),
                  );
                }))
           else if(isLoading == true)
              Center(child: CircularProgressIndicator(),)
        ],
      ),
      
    );
  }
}