import 'dart:developer';
import 'package:country_picker/country_picker.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/View/Widgets/customLoader.dart';

import 'package:gftr/View/Widgets/customText.dart';

import 'package:gftr/View/Widgets/flutterToast.dart';

import 'package:gftr/ViewModel/Cubits/getGifting.dart';
import 'package:gftr/ViewModel/prefsService.dart';
import 'package:intl/intl.dart';

import '../../Helper/appConfig.dart';
import '../../Helper/imageConstants.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  TextEditingController dateController = TextEditingController();
  SharedPrefsService prefsService = SharedPrefsService();
  String? formattedDate;
  bool isPrivate = false;
  bool isPublic = false;
  GetgifingCubit getgifingCubit = GetgifingCubit();
  TextEditingController _streetNumber_name = TextEditingController();
  TextEditingController _apt_unitNumber = TextEditingController();
  TextEditingController _city = TextEditingController();
  TextEditingController _state = TextEditingController();
  TextEditingController _zipcode = TextEditingController();
  var selectedState;
  List<String> states = [
    'Alabama',
    'Alaska',
    'Arizona',
    'Arkansas',
    'California',
    'Colorado',
    'Connecticut',
    'Delaware',
    'Florida',
    'Georgia',
    'Hawaii',
    'Idaho',
    'Illinois',
    'Indiana',
    'Iowa',
    'Kansas',
    'Kentucky',
    'Louisiana',
    'Maine',
    'Maryland',
    'Massachusetts',
    'Michigan',
    'Minnesota',
    'Mississippi',
    'Missouri',
    'Montana',
    'Nebraska',
    'Nevada',
    'New Hampshire',
    'New Jersey',
    'New Mexico',
    'New York',
    'North Carolina',
    'North Dakota',
    'Ohio',
    'Oklahoma',
    'Oregon',
    'Pennsylvania',
    'Rhode Island',
    'South Carolina',
    'South Dakota',
    'Tennessee',
    'Texas',
    'Utah',
    'Vermont',
    'Virginia',
    'Washington',
    'West Virginia',
    'Wisconsin',
    'Wyoming'
  ];
  var _contry = "USA";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getgifingCubit = BlocProvider.of<GetgifingCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        setState(() {});
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: screenHeight(context, dividedBy: 10),
                ),
                customText("To help with the Gifting...", Colors.black, 19,
                    FontWeight.w300, madeOuterSans),
                SizedBox(
                  height: screenHeight(context, dividedBy: 20),
                ),
                customText("when's your birthday?", ColorCodes.greyText, 20,
                    FontWeight.w600, poppins),
                SizedBox(
                  height: screenHeight(context, dividedBy: 50),
                ),
                Container(
                  // height: screenHeight(context, dividedBy: 20),
                  // width: screenWidth(context, dividedBy: 1.6),
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth(context, dividedBy: 15)),
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
                      child: getCustomTextFild(
                          onTap: () async {
                            DateTime? pickedDate =
                                await DatePicker.showSimpleDatePicker(context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                    dateFormat: "MM-dd-yyyy",
                                    looping: true,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white);
                            final snackBar = SnackBar(
                                content: Text("Date Picked $pickedDate"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
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
                              log(pickedDate.toString());
                              formattedDate =
                                  DateFormat('MM-dd-yyyy').format(pickedDate);
                              log(formattedDate.toString());
                              setState(() {
                                dateController.text = formattedDate.toString();
                              });
                            } else {
                              log("Date is not selected");
                            }
                          },
                          hintText: 'Birthday',
                          controller: dateController,
                          sufixIcon: Padding(
                            padding: EdgeInsets.all(10),
                            child: Image.asset(
                              ImageConstants.calenderGradient,
                              height: 10,
                              width: 10,
                            ),
                          ))),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 28),
                ),
                customText("what's your address?", ColorCodes.greyText, 20,
                    FontWeight.w600, poppins),
                SizedBox(
                  height: screenHeight(context, dividedBy: 80),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 4),
                  width: screenWidth(context),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth(context, dividedBy: 15),
                      // vertical: screenHeight(context,dividedBy: 50)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            customText(
                                "Street Number/Name :",
                                ColorCodes.greyText,
                                13,
                                FontWeight.w600,
                                poppins),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
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
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Center(
                                    child: TextField(
                                      textInputAction: TextInputAction.next,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      scrollPhysics: BouncingScrollPhysics(),
                                      maxLines: 1,
                                      focusNode: FocusNode(),
                                      controller: _streetNumber_name,
                                      cursorColor: Colors.grey.shade600,
                                      cursorHeight: 13,
                                      decoration: InputDecoration(
                                          //contentPadding: EdgeInsets.symmetric(horizontal: 5),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth(context, dividedBy: 13),
                            ),
                            customText("Apt/Unit Number :", ColorCodes.greyText,
                                13, FontWeight.w600, poppins),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: screenHeight(context, dividedBy: 25),
                                width: screenWidth(context, dividedBy: 5),
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
                                      decoration: InputDecoration(
                                          hintStyle: TextStyle(fontSize: 13),
                                          hintText: "(optional)",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth(context, dividedBy: 3.25),
                            ),
                            customText("City :", ColorCodes.greyText, 13,
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
                                      controller: _city,
                                      cursorColor: Colors.grey.shade600,
                                      cursorHeight: 13,
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: screenWidth(context, dividedBy: 12),
                            ),
                            customText(
                                "Zip / Postal Code :",
                                ColorCodes.greyText,
                                13,
                                FontWeight.w600,
                                poppins),
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
                                      decoration: InputDecoration(
                                          border: InputBorder.none),
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
                            Container(
                              height: screenHeight(context, dividedBy: 25),
                              width: screenWidth(context, dividedBy: 2.5),
                              child: Row(
                                children: [
                                  customText("Country :", ColorCodes.greyText,
                                      13, FontWeight.w600, poppins),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      height:
                                          screenHeight(context, dividedBy: 25),
                                      width:
                                          screenWidth(context, dividedBy: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 5,
                                            )
                                          ]),
                                      child: Center(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: TextField(
                                            readOnly: true,
                                            onTap: () {
                                              showCountryPicker(
                                                  context: context,
                                                  exclude: <String>['KN', 'MF'],
                                                  //It takes a list of country code(iso2).
                                                  onSelect: (Country country) {
                                                    _contry = country.name;
                                                    print("country = $_contry");
                                                    setState(() {});
                                                  });
                                            },
                                            cursorColor: Colors.grey.shade600,
                                            textAlign: TextAlign.center,
                                            cursorHeight: 13,
                                            decoration: InputDecoration(
                                                hintText: "$_contry",
                                                hintStyle:
                                                    TextStyle(fontSize: 13),
                                                border: UnderlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.zero)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: screenHeight(context, dividedBy: 25),
                              width: screenWidth(context, dividedBy: 2.5),
                              child: Row(
                                children: [
                                  customText("State :", ColorCodes.greyText, 13,
                                      FontWeight.w600, poppins),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height:
                                        screenHeight(context, dividedBy: 25),
                                    width: screenWidth(context, dividedBy: 3.9),
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
                                          onTap: () {
                                            // DropDown(
                                            //   items: states.map<DropdownMenuItem<String>>((String value) {
                                            //     return DropdownMenuItem<String>(
                                            //       value: value,
                                            //       child: Text(value),
                                            //     );
                                            //   }).toList(),
                                            //   hint: Text('Select a state'),
                                            //   onChanged: (String value) {
                                            //     setState(() {
                                            //       selectedState = value;
                                            //     });
                                            //   },
                                            //   value: selectedState,
                                            // ),
                                          },
                                          controller: _state,
                                          cursorColor: Colors.grey.shade600,
                                          cursorHeight: 13,
                                          decoration: InputDecoration(
                                              border: InputBorder.none),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 50),
                ),

                //-----------------Private or Public-------------------
                customText("who can see your Gftr page?", ColorCodes.greyText,
                    20, FontWeight.w600, poppins),
                SizedBox(
                  height: screenHeight(context, dividedBy: 60),
                ),
                Container(
                  margin:
                      EdgeInsets.only(left: screenWidth(context, dividedBy: 8)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText("Keep it Private", Colors.black, 12,
                              FontWeight.w500, poppins),
                          SizedBox(
                            width: screenWidth(context, dividedBy: 9),
                          ),
                          GestureDetector(
                            onTap: () async {
                              isPublic = false;
                              isPrivate = true;
                              only_or_any = isPublic;
                              only_or_any = (await prefsService
                                  .getBoolData("only_or_any"))!;
                              setState(() {});
                            },
                            child: Container(
                              height: screenHeight(context, dividedBy: 65),
                              width: screenWidth(context, dividedBy: 28),
                              decoration: BoxDecoration(
                                color: isPrivate
                                    ? ColorCodes.coral
                                    : ColorCodes.greyText,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: screenWidth(context, dividedBy: 6)),
                        child: const Text(
                            "Only visible to members of your Gftr Group",
                            style: TextStyle(
                                fontSize: 9,
                                color: Color(0xff888888),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenHeight(context, dividedBy: 50),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: screenWidth(context, dividedBy: 7.8)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customText("Make it Public", Colors.black, 12,
                              FontWeight.w500, poppins),
                          SizedBox(
                            width: screenWidth(context, dividedBy: 8.5),
                          ),
                          GestureDetector(
                            onTap: () async {
                              isPrivate = false;
                              isPublic = true;
                              only_or_any = isPublic;
                              only_or_any = (await prefsService
                                  .getBoolData("only_or_any"))!;
                              setState(() {});
                            },
                            child: Container(
                              height: screenHeight(context, dividedBy: 65),
                              width: screenWidth(context, dividedBy: 28),
                              decoration: BoxDecoration(
                                color: isPublic
                                    ? ColorCodes.coral
                                    : ColorCodes.greyText,
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right: screenWidth(context, dividedBy: 6)),
                        child: const Text("Visible to anyone on Gftr",
                            style: TextStyle(
                                fontSize: 9,
                                color: Color(0xff888888),
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),

                //-----------------Private or Public-------------------
                SizedBox(
                  height: screenHeight(context, dividedBy: 30),
                ),
                customText("That's everything!", Colors.black, 15,
                    FontWeight.w400, madeOuterSans),
                SizedBox(
                  height: screenHeight(context, dividedBy: 25),
                ),
                GestureDetector(
                  onTap: () {
                    if (dateController.text.isEmpty) {
                      flutterToast("Please Enter BirthDate", false);
                    } else if (isPublic == false && isPrivate == false) {
                      flutterToast(
                          "Please Select Visible Private & Public", false);
                    } else {
                      log("isPublic : $isPublic");
                      getgifingCubit.Get_Gifting(context,
                          birthday: dateController.text,
                          isPrivate: isPublic,
                          street: _streetNumber_name.text,
                          unit: _apt_unitNumber.text,
                          city: _city.text,
                          zipcode: _zipcode.text,
                          state: _state.text,
                          country: _contry);
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: screenHeight(context, dividedBy: 18),
                    width: screenWidth(context, dividedBy: 2.1),
                    decoration: BoxDecoration(
                      color: ColorCodes.coral,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: BlocBuilder<GetgifingCubit, GetgifingState>(
                        builder: (context, state) {
                      if (state is GetgifingLoading) {
                        return spinkitLoader(context, Colors.white);
                      }
                      return customText("Get Gifting!", const Color(0xffFFFFFF),
                          14, FontWeight.w500, poppins);
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
