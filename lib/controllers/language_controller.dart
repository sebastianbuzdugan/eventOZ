import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;

import '../constants/globals.dart';


class LanguageController extends GetxController {
  static LanguageController get to => Get.find();
  final language = "".obs;
  final store = GetStorage();

  String get currentLanguage => language.value;

  @override
  void onReady() async {
    //setInitialLocalLanguage();
    super.onInit();
  }
//setari dispozitiv extragere si setare limba

  setInitialLocalLanguage() {
    if (currentLanguageStore.value == '') {
      String _deviceLanguage = ui.window.locale.toString();
      _deviceLanguage =
          _deviceLanguage.substring(0, 2); //extrage primele 2 caractere
      print(ui.window.locale.toString());
      updateLanguage(_deviceLanguage);
    }
  }

// limba curenta retinuta
  RxString get currentLanguageStore {
    language.value = store.read('language') ?? '';
    return language;
  }

  // locale app, setari
  Locale? get getLocale {
    if (currentLanguageStore.value == '') {
      language.value = Globals.defaultLanguage;
      updateLanguage(Globals.defaultLanguage);
    } else if (currentLanguageStore.value != '') {
      return Locale(currentLanguageStore.value);
    }
    return Get.deviceLocale;
  }

//actualizare limba stocata 
  Future<void> updateLanguage(String value) async {
    language.value = value;
    await store.write('language', value);
    if (getLocale != null) {
      Get.updateLocale(getLocale!);
    }
    update();
  }
}
