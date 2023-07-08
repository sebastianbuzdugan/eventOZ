import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:loginv1/controllers/controllers.dart';
import 'package:loginv1/services/Database.dart';
import '../../../constants/theme.dart';
import '/ui/widgets/button.dart';
import '/ui/widgets/input_field.dart';
import 'package:intl/intl.dart';

class AddTaskFirebase extends StatefulWidget {
  const AddTaskFirebase({Key? key}) : super(key: key);

  @override
  State<AddTaskFirebase> createState() => _AddTaskFirebaseState();
}

class _AddTaskFirebaseState extends State<AddTaskFirebase> {
//  final TaskController _taskController = Get.find<TaskController>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  //String _startTime = DateFormat("hh:mm").format(DateTime.now());
  //_startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String? _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  String? _endTime = "9:30 AM";
  int _selectedColor = 0;

  int _selectedRemind = 5;
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String? _selectedRepeat = 'None';
  List<String> repeatList = [
    'None',
    'Daily',
    'Weekly',
    'Monthly',
  ];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    //Below shows the time like Sep 15, 2021
    //print(new DateFormat.yMMMd().format(new DateTime.now()));
    print(" starttime " + _startTime!);
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, now.minute, now.second);
    final format = DateFormat.jm();
    print(format.format(dt));
    print("add Task date: " + DateFormat.yMd().format(_selectedDate));
    //_startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
    return Scaffold(
      backgroundColor: secClr,
      appBar: _appBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'event'.tr,
                style: headingTextStyle,
              ),
              SizedBox(
                height: 8,
              ),

              InputField(
                title: 'title'.tr,
                hint: 'titled'.tr,
                maxLength: 30,
                controller: _titleController,
              ),
              InputField(
                title: 'price'.tr,
                hint: 'priced'.tr,
                controller: _priceController,
                maxLength: 7,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
              ),
              InputField(
                title: 'loc'.tr,
                hint: 'locd'.tr,
                maxLength: 30,
                controller: _locationController,
              ),
              InputField(
                  title: 'desc'.tr,
                  hint: 'descd'.tr,
                  controller: _noteController),
              InputField(
                title: "date".tr,
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  icon: (Icon(
                    Icons.calendar_month_sharp,
                    color: Colors.grey,
                  )),
                  onPressed: () {
                    //_showDatePicker(context);
                    _getDateFromUser();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "startTime".tr,
                      hint: _startTime,
                      widget: IconButton(
                        icon: (Icon(
                          Icons.alarm,
                          color: Colors.grey,
                        )),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputField(
                      title: "endTime".tr,
                      hint: _endTime,
                      widget: IconButton(
                        icon: (Icon(
                          Icons.alarm,
                          color: Colors.grey,
                        )),
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                      ),
                    ),
                  )
                ],
              ),

              SizedBox(
                height: 18.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _colorChips(),
                  isLoading != true
                      ? MyButton(
                          label: "createTask".tr,
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await _validateInputs();
                            setState(() {
                              isLoading = false;
                            });
                          },
                        )
                      : CircularProgressIndicator(),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _validateInputs() async {
    if (_titleController.text.isNotEmpty &&
        _noteController.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
        _locationController.text.isNotEmpty) {
      await _addTaskToFirebase();
    } else if (_titleController.text.isEmpty ||
        _noteController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _priceController.text.isEmpty) {
      Get.snackbar(
        "Required",
        "All fields are required.",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      print("############ SOMETHING BAD HAPPENED #################");
    }
  }

  Future<void> _addTaskToFirebase() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final _userId = _auth.currentUser!.uid;
    try {
      await DatabaseService(uid: _userId).createTask(
          _noteController.text.trim(),
          _titleController.text.trim(),
          _priceController.text.trim(),
          _locationController.text.trim(),
          DateFormat.yMd().format(_selectedDate),
          _startTime,
          _endTime,
          _selectedRemind,
          _selectedRepeat,
          _selectedColor,
          0,
          Timestamp.now(),
          0, []).then((value) => Navigator.of(context).pop());
      Get.snackbar(
        "Task created",
        "Task create successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
      // Get.back();
    } catch (e) {
      print(e.toString());
    }
  }

  _colorChips() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "color".tr,
        style: titleTextStle,
      ),
      SizedBox(
        height: 8,
      ),
      Wrap(
        children: List<Widget>.generate(
          3,
          (int index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = index;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CircleAvatar(
                  radius: 14,
                  backgroundColor: index == 0
                      ? bluishClr
                      : index == 1
                          ? pinkClr
                          : yellowClr,
                  child: index == _selectedColor
                      ? Center(
                          child: Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 18,
                          ),
                        )
                      : Container(),
                ),
              ),
            );
          },
        ).toList(),
      ),
    ]);
  }

  _appBar() {
    var controller = AuthController();
    return AppBar(
        elevation: 0,
        backgroundColor: secClr,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back_ios, size: 24, color: primaryClr),
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


  double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

  _getTimeFromUser({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    print(_pickedTime.format(context));
    String? _formatedTime = _pickedTime.format(context);
    print(_formatedTime);
    if (_pickedTime == null)
      print("time canceld");
    else if (isStartTime)
      setState(() {
        _startTime = _formatedTime;
      });
    else if (!isStartTime) {
      setState(() {
        _endTime = _formatedTime;
      });
      //_compareTime();
    }
  }

  _showTimePicker() async {
    return showTimePicker(
      initialTime: TimeOfDay(
          hour: int.parse(_startTime!.split(":")[0]),
          minute: int.parse(_startTime!.split(":")[1].split(" ")[0])),
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
    );
  }

  _getDateFromUser() async {
    final DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
  }
}
