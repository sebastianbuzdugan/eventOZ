import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/models/modele.dart';
import 'package:slimy_card/slimy_card.dart';

import '../widgets/reusable_card.dart';

class statsPage extends StatefulWidget {
  const statsPage({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  _statsPageState createState() => _statsPageState();
}

class _statsPageState extends State<statsPage> {
  int _currentIndexNumber = 0;
  double _initial = 0.1;



  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(
    //       backgroundColor: Colors.blue,
    //       elevation: 0.0,
    //     ),
    //     body: BottomCardWidget(task: widget.task)
        // body: Container(
        //   padding: EdgeInsetsDirectional.fromSTEB(0, 200, 0, 0),
        //   decoration: BoxDecoration(
        //     gradient: LinearGradient(
        //       colors: [
        //         Color(0xFFFFF3E0),
        //         Color(0xFFFF6E40),
        //       ],
        //       begin: Alignment.topCenter,
        //       end: Alignment.bottomCenter,
        //     ),
        //   ),
        //   child: StreamBuilder(
        //     initialData: false,
        //     stream: slimyCard.stream,
        //     builder: ((BuildContext context, AsyncSnapshot snapshot) {
        //       return ListView(
        //         padding: EdgeInsets.zero,
        //         children: <Widget>[
        //           SizedBox(height: 70),
        //           SlimyCard(
        //             color: secClr,
        //             topCardWidget: topCardWidget((snapshot.data)
        //                 ? 'lib/img/chart.jpeg'
        //                 : 'lib/img/chart.jpeg'),
        //             bottomCardWidget: BottomCardWidget(
        //               task: widget.task,
        //             ),
        //           ),
        //         ],
        //       );
        //     }),
        //   ),
        // ),
return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
            centerTitle: true,
            title: Text("Statistics", style: TextStyle(fontSize: 30)),
            backgroundColor: primaryClr,
            toolbarHeight: 70,
            elevation: 5,
            shadowColor: primaryClr,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        body: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: LinearProgressIndicator(
                  backgroundColor: secClr,
                  valueColor: AlwaysStoppedAnimation(primaryClr),
                  minHeight: 1,
                  value: 5,
                ),
              ),
              SizedBox(height: 25),
              SizedBox(
                  width: 500,
                  height: 500,
                  child: FlipCard(
                      direction: FlipDirection.VERTICAL,
                      back: BottomCardWidget(task: widget.task),
                      front: ReusableCard(
                          text: 'pressDetails'.tr))),
     
            ])));
      
        
  }

 
}


  // Widget topCardWidget(String imagePath) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       Container(
  //         height: 70,
  //         width: 70,
  //         decoration: BoxDecoration(
  //           color: Colors.black,
  //           borderRadius: BorderRadius.circular(15),
  //           image: DecorationImage(image: AssetImage(imagePath)),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black.withOpacity(0.1),
  //               blurRadius: 20,
  //               spreadRadius: 1,
  //             ),
  //           ],
  //         ),
  //       ),
  //       SizedBox(height: 15),
  //       Text(
  //         'Stats',
  //         style: TextStyle(color: Colors.black, fontSize: 20),
  //       ),
  //       SizedBox(height: 15),
  //       Center(
  //         child: Text(
  //           'Flutter is Google’s UI toolkit for building beautiful, natively compiled applications'
  //           ' for mobile, web, and desktop from a single codebase.',
  //           style: TextStyle(
  //               color: Colors.black.withOpacity(0.8),
  //               fontSize: 12,
  //               fontWeight: FontWeight.w500),
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //       SizedBox(height: 10),
  //     ],
  //   );
  // }

//   Widget bottomCardWidget(Task task) {
//     Future<List<UserModel>> getUserDetailsById(List<String>? ids) async {
//       try {
//         List<UserModel> users = [];
//         for (var id in ids ?? []) {
//           final DocumentSnapshot documentSnapshot = await FirebaseFirestore
//               .instance
//               .collection('users')
//               .doc(id)
//               .get();
//           users.add(UserModel.fromMap(
//               documentSnapshot.data() as Map<String, dynamic>));
//         }
//         return users;
//       } catch (e) {
//         print(e);
//         return [];
//       }
//     }

//     return Column(
//       children: [
//         Text(
//           'https://flutterdevs.com/',
//           style: TextStyle(
//             color: Colors.black,
//             fontSize: 12,
//             fontWeight: FontWeight.w500,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 15),
//         Expanded(
//           child: FutureBuilder<List<UserModel>>(
//               future: getUserDetailsById(task.favoriteUsers),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.done) {
//                   print(snapshot.data!.length);
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (context, index) {
//                       print(snapshot.data![index].name);
//                       return Text(
//                         snapshot.data![index].name,
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         textAlign: TextAlign.center,
//                       );
//                     },
//                   );
//                 }
//                 return const CircularProgressIndicator();
//               }),
//         ),
//       ],
//     );
//   }
// }
//}

class BottomCardWidget extends StatefulWidget {
  const BottomCardWidget({Key? key, required this.task}) : super(key: key);
  final Task task;

  @override
  State<BottomCardWidget> createState() => _BottomCardWidgetState();
}

class _BottomCardWidgetState extends State<BottomCardWidget> {
  Future<List<UserModel>> getUserDetailsById(List<String>? ids) async {
    try {
      List<UserModel> users = [];
      for (var id in ids ?? []) {
        final DocumentSnapshot documentSnapshot =
            await FirebaseFirestore.instance.collection('users').doc(id).get();
        users.add(
            UserModel.fromMap(documentSnapshot.data() as Map<String, dynamic>));
      }
      return users;
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
        future: getUserDetailsById(widget.task.favoriteUsers),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!.isEmpty)
              return  Center(
                child: Text("noDetails".tr),
              );
          double? averageAge = snapshot.data != null
    ? snapshot.data!
        .map((u) => double.parse(u.age))
        .reduce((a, b) => a + b) /
        snapshot.data!.length
    : null;
  List<UserModel>? noOfMales = snapshot.data?.where((u) => u.sex == 'Gender.Male').toList();
List<UserModel>? noOfFemales = snapshot.data?.where((u) => u.sex == 'Gender.Female').toList();
            return Padding(
               padding: EdgeInsets.all(20.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 7,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            
        
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'averageAge'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          averageAge!.toStringAsFixed(0),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'noOfMales'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          noOfMales?.length.toString() ?? '0',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'noOfFemales'.tr,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          noOfFemales?.length.toString() ?? '0',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'listOfUsers'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Text(
                          snapshot.data![index].name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ],
                ),
              ),
          ),
          ),
          ),
            );
          }
          return const CircularProgressIndicator();
        });
    // return Column(
    //   children: [
    //     Text(
    //       'https://flutterdevs.com/',
    //       style: TextStyle(
    //         color: Colors.black,
    //         fontSize: 12,
    //         fontWeight: FontWeight.w500,
    //       ),
    //       textAlign: TextAlign.center,
    //     ),

    //   ],
    // );
  }
}
