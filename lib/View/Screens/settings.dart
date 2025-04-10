import 'dart:convert';
import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:gftr/ViewModel/Cubits/Delete_pre_Events.dart';
import 'package:gftr/ViewModel/Cubits/getGifting.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Screens/ManageBottom/articlsviewpage.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/setting_cubit.dart';
import 'package:gftr/ViewModel/Cubits/viewsetting.dart';
import 'package:gftr/ViewModel/prefsService.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ImagePicker picker = ImagePicker();
  bool groupOnly = false;
  bool anyGftr = false;
  String selectBirthDayReminders = "1 Week out";
  String selectHolidayRemindersData = "1 Week out";
  String selectEmailOrTextData = "Email";
  TextEditingController giftingController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  GetgifingCubit getgifingCubit = GetgifingCubit();
  TextEditingController _streetNumber_name = TextEditingController();
  TextEditingController _apt_unitNumber = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _zipcode = TextEditingController();
  DeletePreEventsCubit deletePreEventsCubit = DeletePreEventsCubit();
  FocusNode _sNumber = FocusNode();
  var _contry = "USA";
  List<Reminde> addRemaind = [];
  List<String> Eventss = [];
  Map _events = {};
  List<String> showEventss = [];
  String? formattedDate;
  String? formattedBirthDate;
  String? giftingDay;
  String? dateDay;
  bool _change = false;
  final dio = Dio();
  List<String> birthDayRemindersData = [
    '1 Week out',
    '2 Weeks out',
    '3 Weeks out',
    '4 Weeks out',
  ];
  List<String> holidayRemindersData = [
    '1 Week out',
    '2 Weeks out',
    '3 Weeks out',
    '4 Weeks out',
  ];
// Initial Selected Value
  String? dropdownDayvalue;
  String? dropdownMonthvalue;
  String? dropdownYearvalue;

  List<String> emailOrTextData = ["Email", "Text"];
  SharedPrefsService prefsService = SharedPrefsService();
  LinearGradient whiteColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white, Colors.white],
  );

  LinearGradient transparentColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.transparent, Colors.transparent],
  );

  LinearGradient coralTealColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ColorCodes.teal, ColorCodes.coral],
  );
  LinearGradient white_Color = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Colors.white, Colors.white],
  );

  String halfformatDate(String date) {
    List<String> parts = date.split('-');
    // Rearrange the parts into DD/MM/YYYY format
    return '${parts[2]}/${parts[1]}/${parts[0]}';
  }

  String formatDate(String date) {
    List<String> parts = date.split('/');
    // Swap day and month, return in MM/DD/YYYY format
    return '${parts[1]}/${parts[0]}/${parts[2]}';
  }

  FocusNode emailNode = FocusNode();
  updateNumber(
      {required TextEditingController controller, required String hintText}) {
    return StatefulBuilder(builder: (context, StateSetter setState) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        children: [
          Container(
            width: screenWidth(context),
            height: screenHeight(context, dividedBy: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: screenWidth(context, dividedBy: 7),
                  child: GestureDetector(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          print('Select country: ${country.phoneCode}');
                          countryCodeSelect = country.phoneCode;
                          flutterToast(country.displayNameNoCountryCode, true);
                          setState(() {
                            countryCodeSelect;
                          });
                        },
                      );
                    },
                    child: customText("+$countryCodeSelect",
                        ColorCodes.greyText, 20, FontWeight.w100, poppins),
                  ),
                ),
                Container(
                    height: screenHeight(context, dividedBy: 19),
                    width: screenWidth(context, dividedBy: 1.7),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 1.0),
                      child: TextField(
                        cursorColor: Colors.black,
                        controller: controller,
                        style:
                            TextStyle(fontSize: 20, color: ColorCodes.greyText),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: hintText,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
          Container(
            width: 200,
            height: 1,
            decoration: const BoxDecoration(
                color: Colors.black12,
                boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 20,
                  width: 100,
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: customText("Cancel", ColorCodes.greyText, 14,
                          FontWeight.w400, poppins)),
                ),
              ),
              Container(
                width: 1,
                height: 30,
                decoration: const BoxDecoration(
                    color: Colors.black12,
                    boxShadow: [
                      BoxShadow(color: Colors.black38, blurRadius: 5)
                    ]),
              ),
              InkWell(
                onTap: () {
                  phoneNumberPre = "${countryCodeSelect}${controller.text}";
                  log('CountryCode : $countryCodeSelect');
                  settingCubit
                      .getSetting(
                          context: context,
                          phoneNumber: "${countryCodeSelect}${controller.text}")
                      .then(
                    (value) {
                      print("Done");
                      Navigator.pop(context);
                      setState(() {
                        _change = true;
                        print("_change :$_change");
                      });
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  height: 20,
                  width: 100,
                  alignment: Alignment.center,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: BlocBuilder<SettingCubit, SettingState>(
                          builder: (context, state) {
                        if (state is SettingLoading) {
                          spinkitLoader(context, ColorCodes.greyText);
                        }
                        return customText("Save", ColorCodes.greyText, 14,
                            FontWeight.w400, poppins);
                      })),
                ),
              )
            ],
          )
        ],
      );
    });
  }

  renameData(
      {required TextEditingController controller, required String hintText}) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            cursorColor: Colors.black45,
            controller: controller,
            maxLines: null,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(fontFamily: poppins)),
          ),
        ),
        Container(
          width: 200,
          height: 1,
          decoration: const BoxDecoration(
              color: Colors.black12,
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                height: 20,
                width: 100,
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: customText("Cancel", ColorCodes.greyText, 14,
                        FontWeight.w400, poppins)),
              ),
            ),
            Container(
              width: 1,
              height: 30,
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
            ),
            InkWell(
              onTap: () {
                String pattern =
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                RegExp regExp = RegExp(pattern);
                if (controller.text.isNotEmpty && controller.text != null) {
                  if (controller == phoneNumberController) {
                    phoneNumberPre = controller.text;
                    settingCubit.getSetting(
                        context: context, phoneNumber: "${controller.text}");
                    Navigator.pop(context);
                    setState(() {});
                  }
                  if (controller == emailController) {
                    if (!regExp.hasMatch(emailController.text)) {
                      flutterToast('Please enter valid mobile number', false);
                    } else {
                      emailPre = controller.text;
                      settingCubit.getSetting(
                          context: context, email: controller.text);
                      Navigator.pop(context);
                    }
                  }
                  // if (controller == adressController) {
                  //   street = controller.text;
                  //   settingCubit.getSetting(context: context, address: controller.text);
                  //   Navigator.pop(context);
                  // }
                  // Navigator.pop(context);
                  setState(() {});
                } else {
                  flutterToast('Enter $hintText', false);
                }
              },
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                height: 20,
                width: 100,
                alignment: Alignment.center,
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: BlocBuilder<SettingCubit, SettingState>(
                        builder: (context, state) {
                      if (state is SettingLoading) {
                        spinkitLoader(context, ColorCodes.greyText);
                      }
                      return customText("Save", ColorCodes.greyText, 14,
                          FontWeight.w400, poppins);
                    })),
              ),
            )
          ],
        )
      ],
    );
  }

  update_Address() {
    // builder: (context, StateSetter setState)
    return StatefulBuilder(
      builder: (context, setState) {
        return SimpleDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          children: [
            SizedBox(
              height: screenHeight(context, dividedBy: 2.5),
              width: screenWidth(context),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth(context, dividedBy: 25),
                  vertical: screenHeight(context, dividedBy: 90),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    customText("Edit your Address ", ColorCodes.greyText, 20,
                        FontWeight.w600, poppins),
                    Row(
                      children: [
                        customText("Street Number/Name :", ColorCodes.greyText,
                            13, FontWeight.w600, poppins),
                        // Expanded(
                        //   child: Container(
                        //     alignment: Alignment.center,
                        //     height: screenHeight(context,dividedBy: 25),
                        //    // width: screenWidth(context,dividedBy: 10),
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(8),
                        //         boxShadow: const [
                        //           BoxShadow(
                        //             color: Colors.black12,
                        //             blurRadius: 5,
                        //           )
                        //         ]),
                        //     child: Padding(
                        //       padding: const EdgeInsets.only(left: 5),
                        //       child: TextField(
                        //         controller: _streetNumber_name,
                        //         cursorColor: Colors.grey.shade600,
                        //         cursorHeight: 12,
                        //         scribbleEnabled: true,
                        //         scrollPhysics: BouncingScrollPhysics(),
                        //         maxLines: 1,
                        //         focusNode: _sNumber,
                        //         autofocus: true,
                        //         style: TextStyle(fontSize: 13),
                        //         decoration: InputDecoration(
                        //             border: UnderlineInputBorder(
                        //                 borderSide: BorderSide.none,
                        //             )
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: screenHeight(context, dividedBy: 25),
                            width: screenWidth(context),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: TextField(
                                controller: _streetNumber_name,
                                cursorColor: Colors.grey.shade600,
                                cursorHeight: 12,
                                maxLines: 1,
                                focusNode: _sNumber,
                                autofocus: true,
                                style: TextStyle(fontSize: 13),
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 10),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors
                                      .white, // Background color for input field
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth(context, dividedBy: 13)),
                          child: customText(
                              "Apt/Unit Number :",
                              ColorCodes.greyText,
                              13,
                              FontWeight.w600,
                              poppins),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: screenHeight(context, dividedBy: 25),
                            width: screenWidth(context, dividedBy: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: _apt_unitNumber,
                                  cursorColor: Colors.grey.shade600,
                                  cursorHeight: 13,
                                  style: TextStyle(fontSize: 13),
                                  decoration: InputDecoration(
                                      hintText: "(optional)",
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.zero)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth(context, dividedBy: 3.3)),
                          child: customText("City :", ColorCodes.greyText, 13,
                              FontWeight.w600, poppins),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: screenHeight(context, dividedBy: 25),
                            width: screenWidth(context, dividedBy: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: _city,
                                  cursorColor: Colors.grey.shade600,
                                  cursorHeight: 13,
                                  style: TextStyle(fontSize: 13),
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors
                                        .white, // Background color for input field
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth(context, dividedBy: 12)),
                          child: customText(
                              "Zip / Postal Code :",
                              ColorCodes.greyText,
                              13,
                              FontWeight.w600,
                              poppins),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: screenHeight(context, dividedBy: 25),
                            width: screenWidth(context, dividedBy: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: _zipcode,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.grey.shade600,
                                  cursorHeight: 13,
                                  style: TextStyle(fontSize: 13),
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors
                                        .white, // Background color for input field
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customText("Country :", ColorCodes.greyText, 13,
                            FontWeight.w600, poppins),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: screenHeight(context, dividedBy: 25),
                            width: screenWidth(context, dividedBy: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextField(
                                  readOnly: true,
                                  onTap: () {
                                    showCountryPicker(
                                        context: context,
                                        exclude: <String>[
                                          'KN',
                                          'MF'
                                        ], //It takes a list of country code(iso2).
                                        onSelect: (Country country) {
                                          setState(() {
                                            _contry = country.name;
                                          });
                                          print("country = $country");
                                          setState(() {});
                                        });
                                  },
                                  cursorColor: Colors.grey.shade600,
                                  textAlign: TextAlign.center,
                                  cursorHeight: 13,
                                  style: TextStyle(fontSize: 13),
                                  decoration: InputDecoration(
                                      hintText: "$_contry",
                                      border: UnderlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.zero)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        customText("State :", ColorCodes.greyText, 13,
                            FontWeight.w600, poppins),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            height: screenHeight(context, dividedBy: 25),
                            width: screenWidth(context, dividedBy: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5,
                                  )
                                ]),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextField(
                                  controller: _state,
                                  cursorColor: Colors.grey.shade600,
                                  cursorHeight: 13,
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 11, horizontal: 10),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    fillColor: Colors
                                        .white, // Background color for input field
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 200,
              height: 1,
              decoration: const BoxDecoration(
                  color: Colors.black12,
                  boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 5)]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 20,
                    width: 100,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: customText("Cancel", ColorCodes.greyText, 14,
                            FontWeight.w400, poppins)),
                  ),
                ),
                Container(
                  width: 1,
                  height: 30,
                  decoration: const BoxDecoration(
                      color: Colors.black12,
                      boxShadow: [
                        BoxShadow(color: Colors.black38, blurRadius: 5)
                      ]),
                ),
                InkWell(
                  onTap: () {
                    settingCubit
                        .getSetting(
                            context: context,
                            street: _streetNumber_name.text,
                            city: _city.text,
                            state: _state.text,
                            country: _contry.toString(),
                            unit: _apt_unitNumber.text,
                            zipcode: _zipcode.text)
                        .then((value) {
                      //added
                      viewSettingCubit
                          .getviewSetting(); // Trigger Cubit to fetch updated data
                      setState(() {
                        street = _streetNumber_name.text;
                        unit = _apt_unitNumber.text;
                        zipcode = _zipcode.text;
                        contry = _contry.toString();
                        state = _state.text;
                        city = _city.text;
                      });
                      Navigator.pop(context);
                    });

                    //   }
                    //   // Navigator.pop(context);
                    //   setState(() {});
                    // } else {
                    //   flutterToast('Enter $hintText', false);
                    // }
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 20,
                    width: 100,
                    alignment: Alignment.center,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: BlocBuilder<SettingCubit, SettingState>(
                            builder: (context, state) {
                          if (state is SettingLoading) {
                            spinkitLoader(context, ColorCodes.greyText);
                          }
                          return customText("Save", ColorCodes.greyText, 14,
                              FontWeight.w400, poppins);
                        })),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }

  String selectEvent = "";

  // Widget giftingDays(String text, String date, String Eid) {
  //   return GestureDetector(
  //     onTap: () {
  //       //selectEvent = text;
  //       Eventss.add(Eid);
  //       showEventss.add(Eid);
  //       print("Eventss :$showEventss");
  //       prefsService.setStringlistData("Eventss", showEventss);
  //       settingCubit
  //           .getSetting(context: context, checkholidaystatus: Eventss)
  //           .then(
  //         (value) {
  //           Eventss.clear();
  //         },
  //       );
  //       selectEvent = text;
  //       setState(() {});
  //     },
  //     child: showEventss.contains(Eid)
  //         //selectEvent == text
  //         ? Container(
  //             // alignment: Alignment.center,
  //             // height: screenHeight(context, dividedBy: 15),
  //             // width: screenWidth(context, dividedBy: 2.9),
  //             padding: EdgeInsets.all(8),
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 gradient: coralTealColor),
  //             child: Wrap(
  //               children: [
  //                 Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     customText(
  //                         text, Colors.white, 12, FontWeight.w100, poppins),
  //                     customText(
  //                         date, Colors.white, 12, FontWeight.w100, poppins),
  //                   ],
  //                 ),
  //                 InkWell(
  //                     onTap: () {
  //                       showDialog(
  //                         context: context,
  //                         builder: (context) {
  //                           return SimpleDialog(
  //                             shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(20)),
  //                             children: [
  //                               Padding(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       horizontal: 20, vertical: 20),
  //                                   child: Center(
  //                                       child: Text(
  //                                           "Are you sure to delete $text"))),
  //                               Container(
  //                                 width: 200,
  //                                 height: 1,
  //                                 decoration: const BoxDecoration(
  //                                     color: Colors.black12,
  //                                     boxShadow: [
  //                                       BoxShadow(
  //                                           color: Colors.black38,
  //                                           blurRadius: 5)
  //                                     ]),
  //                               ),
  //                               Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceEvenly,
  //                                 children: [
  //                                   InkWell(
  //                                     onTap: () async {
  //                                       setState(() {
  //                                         Navigator.pop(context);
  //                                       });
  //                                     },
  //                                     child: Container(
  //                                       margin: const EdgeInsets.only(top: 5),
  //                                       height: 20,
  //                                       width: 100,
  //                                       alignment: Alignment.center,
  //                                       child: Padding(
  //                                           padding: const EdgeInsets.only(
  //                                               left: 8.0),
  //                                           child: customText(
  //                                               "No",
  //                                               ColorCodes.greyText,
  //                                               14,
  //                                               FontWeight.w400,
  //                                               poppins)),
  //                                     ),
  //                                   ),
  //                                   Container(
  //                                     width:
  //                                         screenWidth(context, dividedBy: 300),
  //                                     height:
  //                                         screenHeight(context, dividedBy: 20),
  //                                     decoration: const BoxDecoration(
  //                                         color: Colors.black12,
  //                                         boxShadow: [
  //                                           BoxShadow(
  //                                               color: Colors.black38,
  //                                               blurRadius: 5)
  //                                         ]),
  //                                   ),
  //                                   InkWell(
  //                                     onTap: () async {
  //                                       deletePreEventsCubit.Delete_frdss(
  //                                               context,
  //                                               c_id: Eid)
  //                                           .then((value) {
  //                                         setState(() {
  //                                           viewSettingCubit.getviewSetting();
  //                                           viewSettingCubit.viewSetting?.data;
  //                                           // preRimendCubit.getpreRimend();
  //                                           showEventss.remove(Eid);
  //                                         });
  //                                         Navigator.pop(context);
  //                                         setState(() {
  //                                           viewSettingCubit.getviewSetting();
  //                                           // preRimendCubit.getpreRimend();
  //                                           showEventss.remove(Eid);
  //                                         });
  //                                       });
  //                                     },
  //                                     child: Container(
  //                                         margin: const EdgeInsets.only(top: 5),
  //                                         height: 20,
  //                                         width: 100,
  //                                         alignment: Alignment.center,
  //                                         child: Padding(
  //                                             padding: const EdgeInsets.only(
  //                                                 left: 8.0),
  //                                             child: customText(
  //                                                 "Yes",
  //                                                 ColorCodes.greyText,
  //                                                 14,
  //                                                 FontWeight.w400,
  //                                                 poppins))),
  //                                   )
  //                                 ],
  //                               )
  //                             ],
  //                           );
  //                         },
  //                       );
  //                     },
  //                     child: Icon(
  //                       Icons.close,
  //                       size: 13,
  //                     ))
  //               ],
  //             ))
  //         : Container(
  //             decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(8),
  //                 color: Colors.white,
  //                 gradient:
  //                     showEventss.contains(Eid) ? coralTealColor : white_Color,
  //                 boxShadow: shadow),
  //             padding: const EdgeInsets.all(5),
  //             child: Wrap(
  //               alignment: WrapAlignment.center,
  //               children: [
  //                 customText(
  //                     text,
  //                     Eventss.contains(Eid) ? Colors.white : Colors.black,
  //                     13,
  //                     FontWeight.w400,
  //                     poppins),
  //                 InkWell(
  //                     onTap: () {
  //                       showDialog(
  //                         context: context,
  //                         builder: (context) {
  //                           return SimpleDialog(
  //                             shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(20)),
  //                             children: [
  //                               Padding(
  //                                   padding: const EdgeInsets.symmetric(
  //                                       horizontal: 20, vertical: 20),
  //                                   child: Center(
  //                                       child: Text(
  //                                           "Are you sure to delete $text"))),
  //                               Container(
  //                                 width: 200,
  //                                 height: 1,
  //                                 decoration: const BoxDecoration(
  //                                     color: Colors.black12,
  //                                     boxShadow: [
  //                                       BoxShadow(
  //                                           color: Colors.black38,
  //                                           blurRadius: 5)
  //                                     ]),
  //                               ),
  //                               Row(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceEvenly,
  //                                 children: [
  //                                   InkWell(
  //                                     onTap: () async {
  //                                       setState(() {
  //                                         Navigator.pop(context);
  //                                       });
  //                                     },
  //                                     child: Container(
  //                                       margin: const EdgeInsets.only(top: 5),
  //                                       height: 20,
  //                                       width: 100,
  //                                       alignment: Alignment.center,
  //                                       child: Padding(
  //                                           padding: const EdgeInsets.only(
  //                                               left: 8.0),
  //                                           child: customText(
  //                                               "No",
  //                                               ColorCodes.greyText,
  //                                               14,
  //                                               FontWeight.w400,
  //                                               poppins)),
  //                                     ),
  //                                   ),
  //                                   Container(
  //                                     width:
  //                                         screenWidth(context, dividedBy: 300),
  //                                     height:
  //                                         screenHeight(context, dividedBy: 20),
  //                                     decoration: const BoxDecoration(
  //                                         color: Colors.black12,
  //                                         boxShadow: [
  //                                           BoxShadow(
  //                                               color: Colors.black38,
  //                                               blurRadius: 5)
  //                                         ]),
  //                                   ),
  //                                   InkWell(
  //                                     onTap: () async {
  //                                       deletePreEventsCubit.Delete_frdss(
  //                                               context,
  //                                               c_id: Eid)
  //                                           .then((value) {
  //                                         setState(() {
  //                                           viewSettingCubit.getviewSetting();
  //                                           viewSettingCubit.viewSetting?.data;
  //                                           // preRimendCubit.getpreRimend();
  //                                           showEventss.remove(Eid);
  //                                         });
  //                                         Navigator.pop(context);
  //                                         setState(() {
  //                                           viewSettingCubit.getviewSetting();
  //                                           // preRimendCubit.getpreRimend();
  //                                           showEventss.remove(Eid);
  //                                         });
  //                                       });
  //                                     },
  //                                     child: Container(
  //                                         margin: const EdgeInsets.only(top: 5),
  //                                         height: 20,
  //                                         width: 100,
  //                                         alignment: Alignment.center,
  //                                         child: Padding(
  //                                             padding: const EdgeInsets.only(
  //                                                 left: 8.0),
  //                                             child: customText(
  //                                                 "Yes",
  //                                                 ColorCodes.greyText,
  //                                                 14,
  //                                                 FontWeight.w400,
  //                                                 poppins))),
  //                                   )
  //                                 ],
  //                               )
  //                             ],
  //                           );
  //                         },
  //                       );
  //                     },
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(top: 2.0, left: 2),
  //                       child: Icon(
  //                         Icons.close,
  //                         size: 15,
  //                       ),
  //                     ))
  //               ],
  //             )),
  //   );
  // }

  // Widget giftingDays(String text, String date, String Eid) {
  //   return GestureDetector(
  //     onTap: () {
  //       if (showEventss.contains(Eid)) {
  //         // Deselect the event
  //         showEventss.remove(Eid);
  //         prefsService.setStringlistData("Eventss", showEventss);
  //       } else {
  //         // Select the event
  //         Eventss.add(Eid);
  //         showEventss.add(Eid);
  //         prefsService.setStringlistData("Eventss", showEventss);
  //         settingCubit
  //             .getSetting(context: context, checkholidaystatus: Eventss)
  //             .then((_) {
  //           Eventss.clear();
  //         });
  //       }
  //       selectEvent = showEventss.contains(Eid) ? text : '';
  //       setState(() {});
  //     },
  //     child: Container(
  //       constraints: BoxConstraints(
  //         minWidth: screenWidth(context, dividedBy: 3) -
  //             20, // Ensure consistent width
  //         maxWidth: screenWidth(context, dividedBy: 3) - 20,
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10),
  //         color: showEventss.contains(Eid) ? null : Colors.white,
  //         gradient: showEventss.contains(Eid) ? coralTealColor : null,
  //         boxShadow: showEventss.contains(Eid)
  //             ? null
  //             : [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.3),
  //                   spreadRadius: 1,
  //                   blurRadius: 3,
  //                   offset: const Offset(0, 2),
  //                 )
  //               ],
  //       ),
  //       child: Stack(
  //         alignment: Alignment.center,
  //         children: [
  //           Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               customText(
  //                   text,
  //                   showEventss.contains(Eid) ? Colors.white : Colors.black,
  //                   13,
  //                   FontWeight.w500,
  //                   poppins),
  //               const SizedBox(height: 4),
  //               customText(
  //                   date,
  //                   showEventss.contains(Eid) ? Colors.white : Colors.black54,
  //                   11,
  //                   FontWeight.w400,
  //                   poppins),
  //             ],
  //           ),
  //           Positioned(
  //             top: 0,
  //             right: 0,
  //             child: InkWell(
  //               onTap: () {
  //                 showDialog(
  //                   context: context,
  //                   builder: (context) => SimpleDialog(
  //                     shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(20)),
  //                     children: [
  //                       Padding(
  //                         padding: const EdgeInsets.symmetric(
  //                             horizontal: 20, vertical: 20),
  //                         child: Center(
  //                             child: Text("Are you sure to delete $text")),
  //                       ),
  //                       Container(
  //                         width: 200,
  //                         height: 1,
  //                         decoration: const BoxDecoration(
  //                             color: Colors.black12,
  //                             boxShadow: [
  //                               BoxShadow(color: Colors.black38, blurRadius: 5)
  //                             ]),
  //                       ),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                         children: [
  //                           _buildDialogButton(
  //                               text: "No",
  //                               onTap: () => Navigator.pop(context)),
  //                           Container(
  //                             width: screenWidth(context, dividedBy: 300),
  //                             height: screenHeight(context, dividedBy: 20),
  //                             decoration: const BoxDecoration(
  //                                 color: Colors.black12,
  //                                 boxShadow: [
  //                                   BoxShadow(
  //                                       color: Colors.black38, blurRadius: 5)
  //                                 ]),
  //                           ),
  //                           _buildDialogButton(
  //                               text: "Yes",
  //                               onTap: () {
  //                                 deletePreEventsCubit.Delete_frdss(context,
  //                                         c_id: Eid)
  //                                     .then((_) {
  //                                   viewSettingCubit.getviewSetting();
  //                                   showEventss.remove(Eid);
  //                                   Navigator.pop(context);
  //                                   setState(() {});
  //                                 });
  //                               }),
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 );
  //               },
  //               child: Padding(
  //                 padding: const EdgeInsets.all(4.0),
  //                 child: Icon(
  //                   Icons.close,
  //                   size: 15,
  //                   color: showEventss.contains(Eid)
  //                       ? Colors.white
  //                       : Colors.black54,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget giftingDays(String text, String date, String Eid) {
    return GestureDetector(
      onTap: () {
        if (showEventss.contains(Eid)) {
          // Deselect the event
          showEventss.remove(Eid);
          prefsService.setStringlistData("Eventss", showEventss);
        } else {
          // Select the event
          Eventss.add(Eid);
          showEventss.add(Eid);
          prefsService.setStringlistData("Eventss", showEventss);
          settingCubit
              .getSetting(context: context, checkholidaystatus: Eventss)
              .then((_) {
            Eventss.clear();
          });
        }
        selectEvent = showEventss.contains(Eid) ? text : '';
        setState(() {});
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate dynamic width based on the first word length
          final firstWord = text.split(' ').first;
          double calculatedWidth = screenWidth(context, dividedBy: 3) - 20;
          if (firstWord.length >= 2) {
            calculatedWidth = (firstWord.length * 12.0).clamp(120.0, 300.0);
          }

          return Container(
            constraints: BoxConstraints(
              minWidth: calculatedWidth,
              maxWidth: calculatedWidth,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: showEventss.contains(Eid) ? null : Colors.white,
              gradient: showEventss.contains(Eid) ? coralTealColor : null,
              boxShadow: showEventss.contains(Eid)
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Split text into words
                        final words = text.split(' ');
                        if (words.isNotEmpty && words[0].length >= 6) {
                          // Move second word to next line if first word exceeds 8 characters
                          return Column(
                            children: [
                              Text(
                                words[0],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: showEventss.contains(Eid)
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: poppins,
                                ),
                              ),
                              if (words.length > 1)
                                Text(
                                  words.sublist(1).join(' '),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: showEventss.contains(Eid)
                                        ? Colors.white
                                        : Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: poppins,
                                  ),
                                ),
                            ],
                          );
                        } else {
                          return Text(
                            text,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: showEventss.contains(Eid)
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              fontFamily: poppins,
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 4),
                    if (showEventss.contains(Eid))
                      Text(
                        date,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: showEventss.contains(Eid)
                              ? Colors.white
                              : Colors.black54,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          fontFamily: poppins,
                        ),
                      ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Center(
                                  child: Text(
                                      "Are you sure you want to delete $text")),
                            ),
                            Container(
                              width: 200,
                              height: 1,
                              decoration: const BoxDecoration(
                                  color: Colors.black12,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black38, blurRadius: 5)
                                  ]),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildDialogButton(
                                    text: "No",
                                    onTap: () => Navigator.pop(context)),
                                Container(
                                  width: screenWidth(context, dividedBy: 300),
                                  height: screenHeight(context, dividedBy: 20),
                                  decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black38,
                                            blurRadius: 5)
                                      ]),
                                ),
                                _buildDialogButton(
                                    text: "Yes",
                                    onTap: () {
                                      deletePreEventsCubit.Delete_frdss(context,
                                              c_id: Eid)
                                          .then((_) {
                                        viewSettingCubit.getviewSetting();
                                        showEventss.remove(Eid);
                                        Navigator.pop(context);
                                        setState(() {});
                                      });
                                    }),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(
                        Icons.close,
                        size: 15,
                        color: showEventss.contains(Eid)
                            ? Colors.white
                            : Colors.black54,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

// Helper method to reduce code duplication
  Widget _buildDialogButton(
      {required String text, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(top: 5),
        height: 30,
        width: 100,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: customText(
              text, ColorCodes.greyText, 14, FontWeight.w400, poppins),
        ),
      ),
    );
  }

  Widget privacyOptions(String text, LinearGradient boxColor,
      LinearGradient borderColor, bool checkFlag) {
    return SizedBox(
        height: screenHeight(context, dividedBy: 30),
        child: Row(children: [
          Container(
            height: screenHeight(context, dividedBy: 40),
            width: screenHeight(context, dividedBy: 40),
            decoration: BoxDecoration(
                gradient: boxColor,
                borderRadius: BorderRadius.circular(5),
                border: GradientBoxBorder(gradient: borderColor)),
            alignment: Alignment.center,
            child: Icon(
              Icons.done_sharp,
              color: Colors.white,
              size: screenWidth(context, dividedBy: 30),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          customText(text, Colors.black, 10, FontWeight.w400, poppins)
        ]));
  }

  Widget holidaynotificationPreference(
      String text, List<String> dropDownData, String selectedData) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      customText(text, Colors.black, 14, FontWeight.w500, poppins),
      Container(
        height: screenHeight(context, dividedBy: 30),
        width: screenWidth(context, dividedBy: 3.2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: GradientBoxBorder(gradient: coralTealColor)),
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context, dividedBy: 50)),
        alignment: Alignment.center,
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
            size: 14,
          ),
          underline: Container(),
          isExpanded: true,
          hint: customText(
              selectedData, ColorCodes.greyText, 10, FontWeight.w400, poppins),
          items: dropDownData.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (val) {
            Selecthollymsg = val!;
            prefsService.setStringData('Selecthollymsg', Selecthollymsg);
            settingCubit.getSetting(context: context, holidayRemind: val);
            setState(() {});
          },
        ),
      )
    ]);
  }

  Widget birthdaynotificationPreference(
      String text, List<String> dropDownData, String selectedData) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      customText(text, Colors.black, 14, FontWeight.w500, poppins),
      Container(
        height: screenHeight(context, dividedBy: 30),
        width: screenWidth(context, dividedBy: 3.2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: GradientBoxBorder(gradient: coralTealColor)),
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context, dividedBy: 50)),
        alignment: Alignment.center,
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
            size: 14,
          ),
          underline: Container(),
          isExpanded: true,
          hint: customText(
              selectedData, ColorCodes.greyText, 10, FontWeight.w400, poppins),
          items: dropDownData.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (val) {
            Selectbirtmsg = val!;
            prefsService.setStringData('Selectbirtmsg', Selectbirtmsg);
            settingCubit.getSetting(context: context, birthdayRemind: val);
            setState(() {});
          },
        ),
      )
    ]);
  }

  Widget notificationPreference(
      String text, List<String> dropDownData, String selectedData) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      customText(text, Colors.black, 14, FontWeight.w500, poppins),
      Container(
        height: screenHeight(context, dividedBy: 30),
        width: screenWidth(context, dividedBy: 3.2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: GradientBoxBorder(gradient: coralTealColor)),
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth(context, dividedBy: 50)),
        alignment: Alignment.center,
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(10),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
            size: 14,
          ),
          underline: Container(),
          isExpanded: true,
          hint: customText(
              selectedData, ColorCodes.greyText, 10, FontWeight.w400, poppins),
          items: dropDownData.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (val) {
            selectEmailOrTextData = val!;
            text_or_msg = selectEmailOrTextData;
            prefsService.setStringData('text_or_msg', text_or_msg);
            settingCubit.getSetting(
                context: context, preferThrough: selectEmailOrTextData);
            setState(() {});
            print(selectEmailOrTextData);
          },
        ),
      )
    ]);
  }

  List<BoxShadow> shadow = [
    const BoxShadow(color: Colors.grey, offset: Offset(0.0, 1.0), blurRadius: 2)
  ];
  getpref() async {
    showEventss = (await prefsService.getStringlistData("Eventss"))!;
    phoneNumberPre = (await prefsService.getStringData("phoneNumberPre"))!;
    emailPre = (await prefsService.getStringData("emailPre"))!;
    setState(() {});
    street = (await prefsService.getStringData("street"))!;
    unit = (await prefsService.getStringData("unit"))!;
    zipcode = (await prefsService.getStringData("zipcode"))!;
    contry = (await prefsService.getStringData("contry"))!;
    state = (await prefsService.getStringData("state"))!;
    city = (await prefsService.getStringData("city"))!;
    birthDayPre = (await prefsService.getStringData("birthDayPre"))!;
    //get that choice here
    only_or_any = (await prefsService.getBoolData("only_or_any"))!;

    setState(() {});
    print("hello==========" + only_or_any.toString());
  }

  SettingCubit settingCubit = SettingCubit();
  ViewSettingCubit viewSettingCubit = ViewSettingCubit();
  birth_holiday_email() async {
    Selectbirtmsg = (await prefsService.getStringData("Selectbirtmsg"))!;
    //  print("Selectivizr : $Selectbirtmsg");
    if (Selectbirtmsg.length < 1) {
      Selectbirtmsg = selectBirthDayReminders;
    }
    Selecthollymsg = (await prefsService.getStringData("Selecthollymsg"))!;
    if (Selecthollymsg.length < 1) {
      Selecthollymsg = selectHolidayRemindersData;
    }
    text_or_msg = (await prefsService.getStringData("text_or_msg"))!;
    if (text_or_msg.length < 1) {
      text_or_msg = selectEmailOrTextData;
    }
    only_or_any = (await prefsService.getBoolData("only_or_any"))!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    viewSettingCubit = BlocProvider.of<ViewSettingCubit>(context);
    viewSettingCubit.getviewSetting();
    getpref();
    setState(() {});
    birth_holiday_email();
    setState(() {});

    // Set default to GFTR Group Only (private)
    fetchAccountPrivacyStatus().then((isPrivate) {
      setState(() {
        only_or_any = false; // false means GFTR Group Only
      });
    });
  }

  Future<bool?> fetchAccountPrivacyStatus() async {
    bool? isPrivate = await prefsService.getBoolData('isPrivate');
    // If no preference is set yet, default to private (GFTR Group Only)
    if (isPrivate == null) {
      await prefsService.setBoolData('isPrivate', true);
      await settingCubit.getSetting(
        context: context,
        isPrivate: "true",
      );
      return true;
    }
    return isPrivate;
  }

  void _updatePrivacyOption(bool isPrivate) async {
    setState(() {
      only_or_any = !isPrivate; // Update the UI
    });

    await prefsService.setBoolData('isPrivate', isPrivate);
    await settingCubit.getSetting(
      context: context,
      isPrivate: isPrivate.toString(),
    );
  }

  Widget privacyOptions2(String text, LinearGradient boxColor,
      LinearGradient borderColor, bool checkFlag) {
    return SizedBox(
        height: screenHeight(context, dividedBy: 30),
        child: Row(children: [
          GestureDetector(
            onTap: () {
              if (text == "GFTR Group Only") {
                _updatePrivacyOption(true);
              }
              // else if (text == "Any GFTR") {
              //   _updatePrivacyOption(false); // Set account to public
              // }
            },
            child: Container(
              height: screenHeight(context, dividedBy: 40),
              width: screenHeight(context, dividedBy: 40),
              decoration: BoxDecoration(
                  gradient: boxColor,
                  borderRadius: BorderRadius.circular(5),
                  border: GradientBoxBorder(gradient: borderColor)),
              alignment: Alignment.center,
              child: Icon(
                Icons.done_sharp,
                color: Colors.white,
                size: screenWidth(context, dividedBy: 30),
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          customText(text, Colors.black, 10, FontWeight.w400, poppins)
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          isIcon = true;
          setState(() {});
        },
        child: SizedBox(
            height: screenHeight(context),
            width: screenWidth(context),
            child: BlocBuilder<ViewSettingCubit, ViewSettingState>(
              builder: (context, BuildingState) {
                if (BuildingState is ViewSettingLoading) {
                  return Center(child: customLoader(context));
                }
                if (BuildingState is ViewSettingSuccess) {
                  return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth(context, dividedBy: 20)),
                                child: customText("Settings", Colors.black, 16,
                                    FontWeight.w300, madeOuterSans),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 100),
                          ),
                          Container(
                            height: screenHeight(context, dividedBy: 7.5),
                            width: screenWidth(context, dividedBy: 1.1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadow,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    screenWidth(context, dividedBy: 20)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                customText("Privacy", ColorCodes.greyText, 12,
                                    FontWeight.w500, poppins),
                                customText("Who can see your GFTR page?",
                                    Colors.black, 14, FontWeight.w500, poppins),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    privacyOptions2(
                                      "GFTR Group Only",
                                      only_or_any == false
                                          ? coralTealColor
                                          : whiteColor,
                                      only_or_any == false
                                          ? transparentColor
                                          : coralTealColor,
                                      only_or_any!,
                                    ),

                                    // TODO: COMMENTED BY UMAIR DEV

                                    // SizedBox(
                                    //     width: screenWidth(context,
                                    //         dividedBy: 10)),
                                    // privacyOptions2(
                                    //   "Any GFTR",
                                    //   only_or_any == true
                                    //       ? coralTealColor
                                    //       : whiteColor,
                                    //   only_or_any == true
                                    //       ? transparentColor
                                    //       : coralTealColor,
                                    //   !groupOnly,
                                    // ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Text('Public account options coming soon!'),
                                const SizedBox(height: 10),

                                //-----------------Privacy-------------------
                              ],
                            ),
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),
                          Container(
                            height: screenHeight(context, dividedBy: 5),
                            width: screenWidth(context, dividedBy: 1.1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadow,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    screenWidth(context, dividedBy: 20)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  customText(
                                      "Notification Preferences",
                                      ColorCodes.greyText,
                                      13,
                                      FontWeight.w500,
                                      poppins),
                                  customText(
                                      "How many weeks’ warning would you like?",
                                      ColorCodes.greyText,
                                      10,
                                      FontWeight.w100,
                                      poppins),
                                  SizedBox(
                                    height:
                                        screenHeight(context, dividedBy: 90),
                                  ),
                                  birthdaynotificationPreference(
                                      "Birthday Reminders",
                                      birthDayRemindersData,
                                      Selectbirtmsg),
                                  SizedBox(
                                    height:
                                        screenHeight(context, dividedBy: 150),
                                  ),
                                  holidaynotificationPreference(
                                      "Holiday Reminders",
                                      holidayRemindersData,
                                      Selecthollymsg),
                                  SizedBox(
                                    height:
                                        screenHeight(context, dividedBy: 150),
                                  ),
                                  notificationPreference("Email or Text",
                                      emailOrTextData, text_or_msg)
                                ]),
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),

                          //------------DATE OF BIRTH----------------

                          Container(
                            height: screenHeight(context, dividedBy: 10),
                            width: screenWidth(context, dividedBy: 1.1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadow,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    screenWidth(context, dividedBy: 20)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customText(
                                          "Birthday",
                                          ColorCodes.greyText,
                                          12,
                                          FontWeight.w500,
                                          poppins),
                                      customText(
                                          formatDate(birthDayPre),
                                          Colors.black,
                                          14,
                                          FontWeight.w500,
                                          poppins),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await DatePicker.showSimpleDatePicker(
                                              context,
                                              titleText: 'Months/Days/Years',
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1900),
                                              lastDate: DateTime(2100),
                                              dateFormat: "MM-dd-yyyy",
                                              looping: true,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white);
                                      // DateTime? pickedDate = await showDatePicker(
                                      //     context: context,
                                      //     initialDate: DateTime.now(),
                                      //     firstDate: DateTime(1950),
                                      //     lastDate: DateTime.now(),
                                      //     builder: (context, child) {
                                      //       return Theme(
                                      //         data: Theme.of(context).copyWith(
                                      //           colorScheme: const ColorScheme.light(
                                      //             primary: Colors.black,
                                      //             onPrimary: Colors.white,
                                      //             onSurface: Colors.black,
                                      //           ),
                                      //           textButtonTheme: TextButtonThemeData(
                                      //             style: TextButton.styleFrom(
                                      //               primary: Colors.black,
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         child: child!,
                                      //       );
                                      //     });
                                      if (pickedDate != null) {
                                        formattedBirthDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);

                                        String formattedBirthDateHalf =
                                            halfformatDate(formattedBirthDate!);
                                        print(
                                            '---------------------------------formattedBirthDate: $formattedBirthDate');
                                        setState(() {
                                          birthDayController.text =
                                              formattedBirthDate.toString();
                                          // birthDayPre = birthDayController.text;
                                          birthDayPre = formattedBirthDateHalf;
                                          settingCubit.getSetting(
                                              context: context,
                                              birthday:
                                                  birthDayController.text);
                                        });
                                      } else {
                                        log("Date is not selected");
                                      }
                                    },
                                    child: Image.asset(
                                      ImageConstants.calender,
                                      color: Colors.black,
                                      height:
                                          screenHeight(context, dividedBy: 50),
                                      width:
                                          screenHeight(context, dividedBy: 50),
                                    ),
                                  )
                                ]),
                          ),

                          //------------DATE OF BIRTH----------------

                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),
                          Container(
                            height: screenHeight(context, dividedBy: 10),
                            width: screenWidth(context, dividedBy: 1.1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadow,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    screenWidth(context, dividedBy: 20)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customText(
                                          "Phone Number",
                                          ColorCodes.greyText,
                                          12,
                                          FontWeight.w500,
                                          poppins),
                                      customText(
                                          '+${phoneNumberPre}',
                                          Colors.black,
                                          14,
                                          FontWeight.w500,
                                          poppins),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return updateNumber(
                                              controller: phoneNumberController,
                                              hintText: 'Phone Number');
                                        }, // renameData// controller: phoneNumberController,// hintText: "Phone Number")
                                      );
                                    },
                                    child: Image.asset(
                                      ImageConstants.edit,
                                      color: Colors.black,
                                      height:
                                          screenHeight(context, dividedBy: 45),
                                      width:
                                          screenHeight(context, dividedBy: 45),
                                    ),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),
                          Container(
                            height: screenHeight(context, dividedBy: 10),
                            width: screenWidth(context, dividedBy: 1.1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadow,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    screenWidth(context, dividedBy: 20)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customText("Email", ColorCodes.greyText,
                                          12, FontWeight.w500, poppins),
                                      customText(emailPre, Colors.black, 14,
                                          FontWeight.w500, poppins),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (_) => renameData(
                                              controller: emailController,
                                              hintText: "Email"));
                                    },
                                    child: Image.asset(
                                      ImageConstants.edit,
                                      color: Colors.black,
                                      height:
                                          screenHeight(context, dividedBy: 45),
                                      width:
                                          screenHeight(context, dividedBy: 45),
                                    ),
                                  )
                                ]),
                          ),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),

                          //-----------------ADDRESS-------------------
                          Container(
                            height: screenHeight(context, dividedBy: 10),
                            width: screenWidth(context, dividedBy: 1.1),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: shadow,
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    screenWidth(context, dividedBy: 20)),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      customText("Address", ColorCodes.greyText,
                                          12, FontWeight.w500, poppins),
                                      SizedBox(
                                          width: screenWidth(context,
                                              dividedBy: 1.5),
                                          child: unit.isEmpty
                                              ? customText(
                                                  "$street, $city, $state, $contry, $zipcode",
                                                  Colors.black,
                                                  13,
                                                  FontWeight.w500,
                                                  poppins,
                                                  overflowText: true)
                                              : customText(
                                                  "$street, $unit, $city, $state, $contry, $zipcode",
                                                  Colors.black,
                                                  13,
                                                  FontWeight.w500,
                                                  poppins,
                                                  overflowText: true)),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => update_Address(),
                                      );
                                    },
                                    child: Image.asset(
                                      ImageConstants.edit,
                                      color: Colors.black,
                                      height:
                                          screenHeight(context, dividedBy: 45),
                                      width:
                                          screenHeight(context, dividedBy: 45),
                                    ),
                                  )
                                ]),
                          ),

                          //-----------------ADDRESS-------------------

                          //-----------------REBUILD ISSUE-------------------

                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),
                          Center(
                              child: customText(
                                  "Please Remind Me:",
                                  Colors.black,
                                  16,
                                  FontWeight.w300,
                                  madeOuterSans)),
                          SizedBox(
                            height: screenHeight(context, dividedBy: 50),
                          ),
                          // SizedBox(
                          //   height: screenHeight(context, dividedBy: 90),
                          // ),
                          Container(
                            // height: screenHeight(context, dividedBy: 20),
                            width: screenWidth(context, dividedBy: 1.15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: GradientBoxBorder(
                                    gradient: coralTealColor)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                    width:
                                        screenWidth(context, dividedBy: 2.71),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth(context,
                                              dividedBy: 40)),
                                      child: getCustomTextFild(
                                          onTap: () {
                                            isIcon = false;
                                            addRemaind.clear();
                                            setState(() {});
                                          },
                                          onSubmitted: (dd) {
                                            isIcon = true;
                                            setState(() {});
                                          },
                                          hintText: 'add a gifting day',
                                          controller: giftingController),
                                    )),
                                DropdownButton(
                                  value: dropdownMonthvalue,
                                  iconSize: 15,
                                  iconEnabledColor: Colors.black,
                                  hint: customText("Month", Colors.grey, 15,
                                      FontWeight.w100, poppins),
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: const [
                                    DropdownMenuItem(
                                      value: "1",
                                      child: Text("1"),
                                    ),
                                    DropdownMenuItem(
                                      value: "2",
                                      child: Text("2"),
                                    ),
                                    DropdownMenuItem(
                                      value: "3",
                                      child: Text("3"),
                                    ),
                                    DropdownMenuItem(
                                      value: "4",
                                      child: Text("4"),
                                    ),
                                    DropdownMenuItem(
                                      value: "5",
                                      child: Text("5"),
                                    ),
                                    DropdownMenuItem(
                                      value: "6",
                                      child: Text("6"),
                                    ),
                                    DropdownMenuItem(
                                      value: "7",
                                      child: Text("7"),
                                    ),
                                    DropdownMenuItem(
                                      value: "8",
                                      child: Text("8"),
                                    ),
                                    DropdownMenuItem(
                                      value: "9",
                                      child: Text("9"),
                                    ),
                                    DropdownMenuItem(
                                      value: "10",
                                      child: Text("10"),
                                    ),
                                    DropdownMenuItem(
                                      value: "11",
                                      child: Text("11"),
                                    ),
                                    DropdownMenuItem(
                                      value: "12",
                                      child: Text("12"),
                                    ),
                                    // DropdownMenuItem(
                                    //   value: "Clear",
                                    //   child: Text("Clear"),
                                    // ),
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      if (value == "Clear") {
                                        dropdownMonthvalue =
                                            null; // Clear the value
                                      } else {
                                        dropdownMonthvalue =
                                            value; // Set the selected value
                                      }
                                    });
                                  },
                                ),
                                DropdownButton(
                                  value: dropdownDayvalue,
                                  iconSize: 15,
                                  isExpanded: false,
                                  iconEnabledColor: Colors.black,
                                  hint: customText("Day", Colors.grey, 15,
                                      FontWeight.w100, poppins),
                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),
                                  items: const [
                                    DropdownMenuItem(
                                      value: "1",
                                      child: Text("1"),
                                    ),
                                    DropdownMenuItem(
                                      value: "2",
                                      child: Text("2"),
                                    ),
                                    DropdownMenuItem(
                                      value: "3",
                                      child: Text("3"),
                                    ),
                                    DropdownMenuItem(
                                      value: "4",
                                      child: Text("4"),
                                    ),
                                    DropdownMenuItem(
                                      value: "5",
                                      child: Text("5"),
                                    ),
                                    DropdownMenuItem(
                                      value: "6",
                                      child: Text("6"),
                                    ),
                                    DropdownMenuItem(
                                      value: "7",
                                      child: Text("7"),
                                    ),
                                    DropdownMenuItem(
                                      value: "8",
                                      child: Text("8"),
                                    ),
                                    DropdownMenuItem(
                                      value: "9",
                                      child: Text("9"),
                                    ),
                                    DropdownMenuItem(
                                      value: "10",
                                      child: Text("10"),
                                    ),
                                    DropdownMenuItem(
                                      value: "11",
                                      child: Text("11"),
                                    ),
                                    DropdownMenuItem(
                                      value: "12",
                                      child: Text("12"),
                                    ),
                                    DropdownMenuItem(
                                      value: "13",
                                      child: Text("13"),
                                    ),
                                    DropdownMenuItem(
                                      value: "14",
                                      child: Text("14"),
                                    ),
                                    DropdownMenuItem(
                                      value: "15",
                                      child: Text("15"),
                                    ),
                                    DropdownMenuItem(
                                      value: "16",
                                      child: Text("16"),
                                    ),
                                    DropdownMenuItem(
                                      value: "17",
                                      child: Text("17"),
                                    ),
                                    DropdownMenuItem(
                                      value: "18",
                                      child: Text("18"),
                                    ),
                                    DropdownMenuItem(
                                      value: "19",
                                      child: Text("19"),
                                    ),
                                    DropdownMenuItem(
                                      value: "20",
                                      child: Text("20"),
                                    ),
                                    DropdownMenuItem(
                                      value: "21",
                                      child: Text("21"),
                                    ),
                                    DropdownMenuItem(
                                      value: "22",
                                      child: Text("22"),
                                    ),
                                    DropdownMenuItem(
                                      value: "23",
                                      child: Text("23"),
                                    ),
                                    DropdownMenuItem(
                                      value: "24",
                                      child: Text("24"),
                                    ),
                                    DropdownMenuItem(
                                      value: "25",
                                      child: Text("25"),
                                    ),
                                    DropdownMenuItem(
                                      value: "26",
                                      child: Text("26"),
                                    ),
                                    DropdownMenuItem(
                                      value: "27",
                                      child: Text("27"),
                                    ),
                                    DropdownMenuItem(
                                      value: "28",
                                      child: Text("28"),
                                    ),
                                    DropdownMenuItem(
                                      value: "29",
                                      child: Text("29"),
                                    ),
                                    DropdownMenuItem(
                                      value: "30",
                                      child: Text("30"),
                                    ),
                                    DropdownMenuItem(
                                      value: "31",
                                      child: Text("31"),
                                    ),
                                    // DropdownMenuItem(
                                    //   value: "Clear",
                                    //   child: Text("Clear"),
                                    // ),
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      if (value == "Clear") {
                                        dropdownDayvalue =
                                            null; // Clear the value
                                      } else {
                                        dropdownDayvalue =
                                            value; // Set the selected value
                                      }
                                    });
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: InkWell(
                                    onTap: () async {
                                      // Initialize the reminders list
                                      List remindMe = [];

                                      // Validation checks
                                      if (giftingController.text.isEmpty) {
                                        flutterToast(
                                            "Please Enter Gifting Day ", false);
                                        isIcon = true;
                                        return; // Exit early if validation fails
                                      }
                                      if (dropdownDayvalue == null) {
                                        flutterToast(
                                            "Please Select a Date ", false);
                                        isIcon = true;
                                        return;
                                      }
                                      if (dropdownMonthvalue == null) {
                                        flutterToast(
                                            "Please Select a Month ", false);
                                        isIcon = true;
                                        return;
                                      }

                                      // Add new reminder
                                      print(giftingController.text);
                                      print(
                                          "time is ${dropdownMonthvalue}/${dropdownDayvalue}");

                                      addRemaind.add(Reminde(
                                        giftName: giftingController.text,
                                        giftdate:
                                            "${dropdownMonthvalue}/${dropdownDayvalue}",
                                      ));

                                      // Update state
                                      setState(() {
                                        // Check if the date already exists in `_events`
                                        if (_events[
                                                "${dropdownMonthvalue}-${dropdownDayvalue}"] !=
                                            null) {
                                          _events["${dropdownMonthvalue}-${dropdownDayvalue}"]
                                              ?.add({
                                            "eventTitle":
                                                giftingController.text,
                                          });
                                        } else {
                                          _events[
                                              "${dropdownMonthvalue}-${dropdownDayvalue}"] = [
                                            {
                                              "eventTitle":
                                                  giftingController.text
                                            }
                                          ];
                                        }
                                      });

                                      // Save the events map to SharedPreferences
                                      SharedPreferences prefs =
                                          await SharedPreferences.getInstance();
                                      String encodedMap = json.encode(_events);
                                      prefs.setString("events", encodedMap);

                                      // Populate remindMe list
                                      addRemaind.forEach((element) {
                                        remindMe.add({
                                          "dayName": element.giftName,
                                          "dayDate": element.giftdate,
                                        });
                                      });

                                      // Unfocus the keyboard
                                      FocusScope.of(context).unfocus();

                                      // Log and trigger additional settings updates
                                      log('Reminders: ${remindMe.toString()}');
                                      await settingCubit.getSetting(
                                          context: context, remindMe: remindMe);

                                      // Reset form fields
                                      giftingController.clear();
                                      dateController.clear();
                                      dropdownDayvalue = null;
                                      dropdownMonthvalue = null;
                                      dropdownYearvalue = null;

                                      // Fetch updated settings
                                      setState(() {
                                        viewSettingCubit.getviewSetting();
                                      });
                                    },
                                    child: Image.asset(
                                      ImageConstants.addDate,
                                      height:
                                          screenHeight(context, dividedBy: 20),
                                      width:
                                          screenWidth(context, dividedBy: 20),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //-----------------REBUILD ISSUE-------------------

                          SizedBox(
                              height: screenHeight(context, dividedBy: 50)),

                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal:
                          //           screenWidth(context, dividedBy: 10)),
                          //   child: Wrap(
                          //     spacing: 8,
                          //     runSpacing: 8,
                          //     children: addRemaind
                          //         .map((e) => giftingDays(
                          //             e.giftName, e.giftdate, 'First'))
                          //         .toList(),
                          //   ),
                          // ),

                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal:
                          //           screenWidth(context, dividedBy: 10)),
                          //   child: Wrap(
                          //     spacing: 8,
                          //     runSpacing: 8,
                          //     children: viewSettingCubit
                          //             .viewSetting?.data?.remindMe
                          //             .map((e) => giftingDays(
                          //                 e.dayName ?? '',
                          //                 "${e.dayDate.month.toString().padLeft(2, '0')}/${e.dayDate.day.toString().padLeft(2, '0')}/${e.dayDate.year.toString()}",
                          //                 e.id))
                          //             .toList() ??
                          //         [],
                          //   ),
                          // ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(context, dividedBy: 10),
                            ),
                            child: Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  viewSettingCubit.viewSetting?.data?.remindMe
                                          .map(
                                            (event) => giftingDays(
                                              event.dayName ?? '',
                                              "${event.dayDate.month.toString().padLeft(2, '0')}/"
                                              "${event.dayDate.day.toString().padLeft(2, '0')}",
                                              event.id,
                                            ),
                                          )
                                          .toList() ??
                                      [],
                            ),
                          ),

                          SizedBox(
                              height: screenHeight(context, dividedBy: 10)),
                        ],
                      ));
                }
                return SizedBox();
              },
            )));
  }
}

class Reminde {
  String giftName;
  String giftdate;
  Reminde({required this.giftName, required this.giftdate});
}
