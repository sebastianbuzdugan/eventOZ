import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loginv1/constants/theme.dart';
import 'package:loginv1/ui/reglog/updateprofile.dart';

import '../../constants/globals.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/language_controller.dart';
import '../widgets/dropdown_picker.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secClr,
      appBar: AppBar(
        leading: null,
        title: Text('🌟Settings'),
        backgroundColor: primaryClr,
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 1),
              languageListTile(context),
              SizedBox(
                height: 25,
              ),
              _updateP(),
              SizedBox(
                height: 25,
              ),
              _signOut(),
              SizedBox(
                height: 25,
              ),
              _help(),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  languageListTile(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      width: w * 0.8,
      height: h * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          image: AssetImage("lib/img/loginbtn.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: GetBuilder<LanguageController>(
        builder: (controller) => ListTile(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 0, 0),
            child: Text(
              'settings.language'.tr,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          trailing: DropdownPicker(
            menuOptions: Globals.languageOptions,
            selectedOption: controller.currentLanguage,
            onChanged: (value) async {
              await controller.updateLanguage(value!);
              Get.forceAppUpdate();
            },
          ),
        ),
      ),
    );
  }

  _signOut() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        AuthController.to.logout();
      },
      child: Container(
        width:
            w * 0.4, // increase the width to create more space around the text
        height: h * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: AssetImage("lib/img/loginbtn.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            "signOut".tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _updateP() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () async {
        Get.to(UpdateProfileUI());
      },
      child: Container(
        width: w * 0.6,
        height: h * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: AssetImage("lib/img/loginbtn.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            "updateProfile".tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  _help() {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          barrierColor: Colors.black.withOpacity(0.5),
          builder: (BuildContext context) {
            return Container(
              color: primaryClr,
                width: w * 0.2,
        height: h * 0.07,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'help.text'.tr,
                    style: TextStyle(color: Colors.white,fontSize: 16, fontWeight: FontWeight.bold,
),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: w * 0.30,
        height: h * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: AssetImage("lib/img/loginbtn.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            "help".tr,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
