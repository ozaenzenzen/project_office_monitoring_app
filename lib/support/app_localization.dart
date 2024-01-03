// import 'package:flutter/material.dart';

// class LocalizationProvider extends ChangeNotifier {
//   Locale _locale = const Locale("id");
//   Locale get locale => _locale;

//   void setLocale(Locale locale) async {
//     _locale = locale;
//     notifyListeners();
//     await LocalRepository.setLanguage(_locale.languageCode);
//   }

//   void getLocale() async {
//     String? value = await LocalRepository.getLanguage();
//     if (value != null) {
//       _locale = Locale(value);
//     }
//     notifyListeners();
//   }
// }
