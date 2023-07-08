import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:loginv1/ui/widgets/statsbutton.dart';
import '/models/task.dart';
import '../../constants/size_config.dart';
import '../../constants/theme.dart';
import 'like_button_widget.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  TaskTile(this.task);

  @override
  Widget build(BuildContext context) {
     

   if (task.titl2 == null ||
    task.location == null ||
    task.note == null ||
    task.price == null ||
    task.startTime == null ||
    task.endTime == null ||
    task.date == null) {
  // Log the null values to the console
  print('task.titl2: ${task.titl2}');
  print('task.location: ${task.location}');
  print('task.note: ${task.note}');
  print('task.price: ${task.price}');
  print('task.startTime: ${task.startTime}');
  print('task.endTime: ${task.endTime}');
  print('task.date: ${task.date}');

  // Handle the null case
  return Container();
}

    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
      width: SizeConfig.screenWidth,
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
      child: Container(
        padding: EdgeInsets.all(16),
        //  width: SizeConfig.screenWidth * 0.78,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: _getBGClr(task.color),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.titl2!,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      task.location!,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.description_outlined,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Container(
                      width: 280, // Set the width of the container
                      child: Text(
                        task.note!,
                        style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(fontSize: 15, color: Colors.grey[100]),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.price_check_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      '${task.price.toString()} \RON ',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.alarm,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${task.startTime} - ${task.endTime}",
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 14, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.edit_calendar_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      task.date!,
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(fontSize: 15, color: Colors.grey[100]),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    LikeButtonW(
                      task: task,
                    ),
                    StatsW(
                      task: task,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 60,
            width: 0.5,
            color: Colors.grey[200]!.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted == 1 ? "SUNT INTERESAT" : "EVENT",
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int? no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }
}


// PARTEA DIN DREAPTA DE LA TASK
