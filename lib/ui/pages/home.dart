import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loginv1/services/Database.dart';
import 'package:loginv1/ui/pages/firebase/addTaskFirebase.dart';
import '/controllers/task_controller.dart';
import '/models/task.dart';
import '../../constants/size_config.dart';
import '../../constants/theme.dart';
import '/ui/widgets/button.dart';
import 'package:intl/intl.dart';
import '/ui/widgets/task_tile.dart';

class Home extends StatefulWidget {
  const Home({Key? key, required this.isAdmin}) : super(key: key);
  final bool isAdmin;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 Stream<List<Task>> _taskStream = FirebaseFirestore.instance
      .collection('tasks')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList());
  @override
  DateTime _selectedDate = DateTime.parse(DateTime.now().toString());
  final _taskController = Get.put(TaskController());

  late var notifyHelper;
  bool animate = false;
  double left = 630;
  double top = 900;
  Timer? _timer;
  @override
  void initState() {
    super.initState();
      _taskStream = DatabaseService().tasks;

    _timer = Timer(Duration(milliseconds: 500), () {
      setState(() {
        animate = true;
        left = 30;
        top = top / 3;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    SizeConfig().init(context);
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _addTaskBar(),
            _dateBar(),
            SizedBox(
              height: 12,
            ),
            _showFBTasks()
          ],
        ),
      ),
    );
  }

  _dateBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 20),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: DatePicker(
          DateTime.now(),
          height: 100.0,
          width: 80,
          initialSelectedDate: DateTime.now(),
          selectionColor: primaryClr,
          //selectedTextColor: primaryClr,
          selectedTextColor: Colors.white,
          dateTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          dayTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          monthTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              fontSize: 10.0,
              color: Colors.grey,
            ),
          ),

          onDateChange: (date) {
            // New date selected

            setState(
              () {
                _selectedDate = date;
              },
            );
          },
        ),
      ),
    );
  }

  _addTaskBar() {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingTextStyle,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'today'.tr,
                style: headingTextStyle,
              ),
            ],
          ),
          widget.isAdmin
              ? MyButton(
                  label: '+addtask'.tr,
                  onTap: () async {
                    //await Get.to(AddTaskPage());
                    await Get.to(AddTaskFirebase());
                    _taskController.getTasks();
                  },
                  padding: EdgeInsets.all(16),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
        backgroundColor: secClr,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.sunny,
            color: darkGreyClr,
          ),
        ),
        actions: [
          Icon(
            Icons.navigation_rounded,
            color: darkGreyClr,
          ),
          SizedBox(
            width: 20,
          ),
        ]);
  }

  _showFBTasks() {
    return StreamBuilder<List<Task>>(
        stream:
            _taskStream, //initializing stream in inIt for performance so it doens't get recalled on every rebuild
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final task = snapshot.data![index];
                if (task.repeat == 'Daily') {
                  var hour = task.startTime.toString().split(":")[0];
                  var minutes = task.startTime.toString().split(":")[1];
                  debugPrint("My time is " + hour);
                  debugPrint("My minute is " + minutes);
                  DateTime date = DateFormat.jm().parse(task.startTime!);
                  var myTime = DateFormat("HH:mm").format(date);
                  /*
                  print("my date "+date.toString());
                  print("my time " +myTime);
                  var t=DateFormat("M/d/yyyy hh:mm a").parse(task.date+" "+task.startTime);
                  print(t);
                  print(int.parse(myTime.toString().split(":")[0]));*/
                  notifyHelper.scheduledNotification(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      task);

                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                                onTap: () {
                                   showBottomSheet(context, task);
                                },
                                child: TaskTile(task)),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (task.date == DateFormat.yMd().format(_selectedDate)) {
                  //notifyHelper.scheduledNotification();
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 1375),
                    child: SlideAnimation(
                      horizontalOffset: 300.0,
                      child: FadeInAnimation(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             widget.isAdmin
              ? 
                            GestureDetector(
                                onTap: () {
                                  showBottomSheet(context, task);
                                },
                                child: TaskTile(task)): TaskTile(task),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              });
        });
  }

  showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        color: Colors.orange[50],
        padding: EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? SizeConfig.screenHeight * 0.18 * 1 / 2
            : SizeConfig.screenHeight * 0.24 * 1 / 2,
        width: SizeConfig.screenWidth,
        // color: Get.isDarkMode ? darkHeaderClr : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
            ),
            Spacer(),
        _buildBottomSheetButton(
  label: "DELETE",
  onTap: () {
    // Uncomment this code to enable the delete functionality
    DatabaseService().deleteTask(task.docId!);
    Get.back();
  },
  clr: Colors.red[300],
),

            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  _buildBottomSheetButton(
      {required String label,
      Function? onTap,
      Color? clr,
      bool isClose = false}) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: SizeConfig.screenWidth! * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : clr!,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose ? Colors.transparent : clr,
        ),
        child: Center(
            child: Text(
          label,
          style: isClose
              ? titleTextStle
              : titleTextStle.copyWith(color: Colors.white),
        )),
      ),
    );
  }

  _noTaskMsg() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 2000),
          left: left,
          top: top,
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "lib/img/task.svg",
                color: primaryClr.withOpacity(0.5),
                height: 90,
                semanticsLabel: 'Task',
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Text(
                  "You do not have any tasks yet!\nAdd new tasks to make your days productive.",
                  textAlign: TextAlign.center,
                  style: subTitleTextStle,
                ),
              ),
              SizedBox(
                height: 80,
              ),
            ],
          )),
        )
      ],
    );
  }
}
