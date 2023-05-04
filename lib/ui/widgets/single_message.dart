import 'package:flutter/material.dart';
import 'package:loginv1/constants/theme.dart';


class SingleMessage extends StatelessWidget {
  final String message;
  final bool isMe;
  SingleMessage({
    required this.message,
    required this.isMe
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Material(
            elevation: 5.0,
              color: isMe ? primaryClr: Colors.white,
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
              
            
            child: Padding(
               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              message,
             style: TextStyle(
                    color: isMe ? Colors.white : Colors.black54,
                    fontSize: 15.0,
                  ),
                  )
            ),
          ),
      
        ],
        
      ),
    );
  }
}