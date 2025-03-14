import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/flutterToast.dart';
import 'package:gftr/ViewModel/Cubits/Calendar_post.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/RemoveEvents.dart';
import 'package:gftr/ViewModel/Cubits/events_view.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ManageBottom/articlsviewpage.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/prefsService.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:dio/dio.dart';
import '../../Helper/apiConstants.dart';
import '../../Model/decryption.dart';
import '../../ViewModel/apiServices.dart';

class EventCalendarScreen extends StatefulWidget {
  const EventCalendarScreen({Key? key}) : super(key: key);

  @override
  State<EventCalendarScreen> createState() => _EventCalendarScreenState();
}

class _EventCalendarScreenState extends State<EventCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDate;
  String _SelectedDate = '';

  LinearGradient coralTealColor = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ColorCodes.coral, ColorCodes.teal],
  );
  final dio = Dio();
  List Events = [];
  bool _change = false;
  Map _events = {};
  SharedPrefsService sharedPrefsService = SharedPrefsService();
  ViewEventsCubit viewEventsCubit = ViewEventsCubit();
  CalendarPostsCubit calendarPostsCubit = CalendarPostsCubit();
  DeleteEventCubit deleteEventCubit = DeleteEventCubit();
  final titleController = TextEditingController();
  final descpController = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final children = <Widget>[];
  MyDataaaa() async {
    Decryption? data = await DioClient()
        .decryptDataGetMethod("${ApiConstants.view_calendar_events}");
    Map<String, dynamic> body = {"encData": data?.data};
    Response userData = await dio.post(ApiConstants.decryptData, data: body);
    final originalData = userData.data;
    print("originalData ==== > $originalData");

    Map formattedData = {};
    List events = originalData['data'];

    events.forEach((event) {
      String date = event['date'];
      // String formattedDate = formatDateString(date);
      String eventTitle = event['title'];
      String eventDescp = ''; // You can set the event description here

      if (formattedData[date] == null) {
        formattedData[date] = [];
      }

      formattedData[date]
          .add({'eventTitle': eventTitle, 'eventDescp': eventDescp});
    });
    // List<Map<String, dynamic>> events = (originalData['data'] as List)
    //     .map((event) {
    //   String date = event['date'];
    //  // String formattedDate = formatDate(DateFormat().parse(date));
    //   return {'date': date, 'title': event['title'], '_id': event['_id']};
    // })
    //     .toList();

    final newJson = json.encode(formattedData);
    print(" new json ==== > $newJson");
    loadPreviousEvents(jsonDecode(newJson));
  }

  Get_Data() async {
    if (viewEventsCubit.calenderGet?.data?.isEmpty ?? false) {
      sharedPrefsService.removeData("events");
      setState(() {});
    } else {
      final encodedMap = await sharedPrefsService.getStringData("events");
      print("encode map:$encodedMap");
      //  loadPreviousEvents(jsonDecode(encodedMap!));
      loadPreviousEvents(jsonDecode(encodedMap!));
    }

    // Map<String,dynamic> decodedMap = json.decode(encodedMap);
    // print(" decodedMap:$decodedMap");
  }

  loadPreviousEvents(Map data) {
    _events = data;
    print("eventss :$_events");
    setState(() {});
  }

  List _listOfDayEvents(DateTime dateTime) {
    if (_events[formatDate(dateTime)] != null) {
      return _events[formatDate(dateTime)];
    } else {
      return [];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewEventsCubit = BlocProvider.of<ViewEventsCubit>(context);
    calendarPostsCubit = BlocProvider.of<CalendarPostsCubit>(context);
    viewEventsCubit.getcalendarEvents();
    _selectedDate = _focusedDay;
    MyDataaaa();
    //Get_Data();
    // get_highlight ();
  }

  _showAddEventDialog() async {
    // Pre-fill the date field if a date is selected from the calendar
    if (_selectedDate != null) {
      descpController.text =
          DateFormat('dd/MM/yyyy').format(_selectedDate!).toString();
      _SelectedDate = formatDate(_selectedDate!);
    }

    await showDialog(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
            child: AlertDialog(
          shape: UnderlineInputBorder(borderRadius: BorderRadius.circular(30)),
          title: Text(
            "Add New Event",
            style: TextStyle(color: Colors.black, fontFamily: "poppins"),
            textAlign: TextAlign.center,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await DatePicker.showSimpleDatePicker(
                      context,
                      initialDate: _selectedDate ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      titleText: 'Month | Date | Year',
                      lastDate: DateTime(2100),
                      dateFormat: "MM/dd/yyyy",
                      backgroundColor: Colors.black,
                      textColor: Colors.white);

                  if (pickedDate != null) {
                    _SelectedDate = formatDate(pickedDate);
                    descpController.text =
                        DateFormat('dd/MM/yyyy').format(pickedDate).toString();
                    setState(() {});
                  }
                },
                controller: descpController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    labelText: "Choose your date",
                    labelStyle: TextStyle(fontFamily: "poppins")),
              ),
              TextField(
                controller: titleController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    labelText: "Title",
                    labelStyle: TextStyle(fontFamily: "poppins")),
              ),
            ],
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorCodes.coral,
                        borderRadius: BorderRadius.circular(25)),
                    child: customText(
                        "Cancel", Colors.white, 14, FontWeight.w400, poppins),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (titleController.text.isEmpty ||
                        descpController.text.isEmpty) {
                      flutterToast("Please Enter Title & Date", false);
                    } else {
                      print(
                          "New Event for backend developer ${json.encode(_events)}");
                      calendarPostsCubit
                          .events_views(
                        context,
                        Date: descpController.text,
                        Title: titleController.text,
                      )
                          .then(
                        (value) async {
                          setState(() {
                            viewEventsCubit.getcalendarEvents();
                          });
                          setState(() {
                            if (_events[_SelectedDate] != null) {
                              _events[_SelectedDate]?.add({
                                "eventTitle": titleController.text,
                              });
                            } else {
                              _events[_SelectedDate] = [
                                {
                                  "eventTitle": titleController.text,
                                }
                              ];
                            }
                          });
                          String encodedMap = json.encode(_events);
                          sharedPrefsService.setStringData(
                              "events", encodedMap);
                          print(
                              "New Event for backend developer ${json.encode(_events)}");
                          titleController.clear();
                          descpController.clear();
                          Navigator.pop(context);
                        },
                      );
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ColorCodes.coral,
                        borderRadius: BorderRadius.circular(25)),
                    child: BlocBuilder<CalendarPostsCubit, CalendarPostsState>(
                        builder: (context, state) {
                      if (state is CalendarPostsLoading) {
                        return spinkitLoader(context, ColorCodes.greyButton);
                      }
                      return customText("Add Event", Colors.white, 14,
                          FontWeight.w400, poppins);
                    }),
                  ),
                )
              ],
            ),
          ],
        ));
      },
    );

    // Clear the controllers after dialog is closed
    if (!mounted) return;
    setState(() {
      titleController.clear();
      descpController.clear();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _events.clear();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back_rounded),
            onTap: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        toolbarHeight: screenHeight(context, dividedBy: 25),
        backgroundColor: Colors.black,
        actions: [
          GestureDetector(
            child: SizedBox(
                height: screenHeight(context, dividedBy: 40),
                width: screenHeight(context, dividedBy: 40),
                child: Image.asset(ImageConstants.calenderGradient)),
          ),
          SizedBox(
            width: screenWidth(context, dividedBy: 30),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ArticlsViewPage()),
              );
            },
            child: Padding(
              padding:
                  EdgeInsets.only(right: screenWidth(context, dividedBy: 13)),
              child: Container(
                // height: screenHeight(context, dividedBy: 30),
                child: Image.asset(ImageConstants.search,
                    height: screenHeight(context, dividedBy: 30),
                    width: screenWidth(context, dividedBy: 22)),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            height: screenHeight(context, dividedBy: 2.3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30)),
                color: Colors.black),
            child: TableCalendar(
              calendarFormat: _calendarFormat,
              firstDay: DateTime(2023),
              lastDay: DateTime(2025, 12, 31), // Updated to December 31, 2025
              locale: 'en_US',
              focusedDay: _focusedDay,
              daysOfWeekHeight: 50,
              headerStyle: HeaderStyle(
                titleTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    fontSize: 20),
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 20,
                  color: Colors.white,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                  ),
                  weekdayStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Poppins",
                  )),
              calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      ColorCodes.teal,
                      ColorCodes.coral,
                    ]),
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //     colors: [
                      //       Color(0xff4BADB8),
                      //       Color(0xffF37A5B)
                      //     ]),
                      // border: Border.all(color: ColorCodes.coral)
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white)),
                  holidayTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),

                  // todayTextStyle: TextStyle(
                  //   fontWeight: FontWeight.bold,
                  //   color: Colors.white,
                  //   decoration: TextDecoration.underline,
                  //   decorationColor: ColorCodes.coral,
                  // ),
                  selectedTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                  defaultTextStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  markerDecoration: BoxDecoration(
                    color: ColorCodes.teal,
                    //border: Border.all(color: ColorCodes.teal, width: 1),
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white)),
              // calendarBuilders: CalendarBuilders(
              //   selectedBuilder: (context, date, _) {
              //     return highlight.contains(date) ? Container(
              //       margin: const EdgeInsets.all(4.0),
              //       alignment: Alignment.center,
              //       decoration: BoxDecoration(
              //         color: Colors.blue,
              //         borderRadius: BorderRadius.circular(8.0),
              //       ),
              //       child: Text(
              //         '${date.day}',
              //         style: TextStyle(color: Colors.white),
              //       ),
              //     ) : null ;
              //   },
              // ),
              shouldFillViewport: true,
              onDaySelected: (selectedDay, focusedDay) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(
                        '${DateFormat('dd MMMM').format(_selectedDate!).toString()}',
                        style: TextStyle(fontFamily: 'poppins')),
                    actions: <Widget>[
                      ..._listOfDayEvents(_selectedDate!).map(
                        (myEvents) => ListTile(
                          leading: const Icon(
                            Icons.done,
                            color: ColorCodes.teal,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                                'Event Title:   ${myEvents['eventTitle']}',
                                style: TextStyle(
                                    fontFamily: 'poppins',
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
                if (!isSameDay(_selectedDate, selectedDay)) {
                  setState(() {
                    _selectedDate = selectedDay;
                    _focusedDay = focusedDay;
                  });
                }
              },
              selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              eventLoader: _listOfDayEvents,
            ),
          ),
          SizedBox(height: screenHeight(context, dividedBy: 35)),
          Padding(
            padding:
                EdgeInsets.only(left: screenWidth(context, dividedBy: 17.5)),
            child: Container(
                alignment: Alignment.topLeft,
                child: customText("Upcoming Events", Colors.black, 20,
                    FontWeight.w100, madeOuterSans)),
          ),
          // ..._listOfDayEvents(_selectedDate!).map(
          //       (myEvents) => ListTile(
          //     leading: const Icon(
          //       Icons.done,
          //       color: Colors.teal,
          //     ),
          //     title: Padding(
          //       padding: const EdgeInsets.only(bottom: 8.0),
          //       child: Text('Event Title:   ${myEvents['eventTitle']}'),
          //     ),
          //     subtitle: Text('Description:   ${myEvents['eventDescp']}'),
          //   ),
          // ),
          BlocBuilder<ViewEventsCubit, ViewEventsState>(
            builder: (context, state) {
              log("ViewEventsCubit $state");
              if (state is ViewEventsLoading) {
                return Center(
                  child: spinkitLoader(context, ColorCodes.coral),
                );
              } else if (state is ViewEventsError) {
                return Center(
                  child: SizedBox(),
                );
              } else if (state is ViewEventsSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: viewEventsCubit.calenderGet?.data?.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            setState(() {
                              _change = true;
                            });
                            deleteEventCubit.Delete_Events(context,
                                    Numbers:
                                        "${viewEventsCubit.calenderGet?.data?[index].id}")
                                .then(
                              (value) {
                                setState(() {
                                  // sharedPrefsService.removeData("events");
                                  viewEventsCubit.getcalendarEvents();
                                  _change = false;
                                });
                              },
                            );
                          },
                          background: Container(
                            padding: EdgeInsets.only(
                                right: screenWidth(context, dividedBy: 10)),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 1,
                                  )
                                ]),
                            alignment: Alignment.centerRight,
                            child: customText("Delete", Colors.white, 18,
                                FontWeight.w700, poppins),
                          ),
                          child: Container(
                            height: screenHeight(context, dividedBy: 12.3),
                            width: screenWidth(context, dividedBy: 1.05),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(1.0, 1.0),
                                      spreadRadius: 1,
                                      color: Colors.grey.shade300,
                                      blurRadius: 3)
                                ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("BirthDay"))
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 12.3),
                                    width: screenWidth(context, dividedBy: 40),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        gradient: coralTealColor),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("birthday"))
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 12.3),
                                    width: screenWidth(context, dividedBy: 40),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        gradient: coralTealColor),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Birthday"))
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 12.3),
                                    width: screenWidth(context, dividedBy: 40),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        gradient: coralTealColor),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Birth Day"))
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 12.3),
                                    width: screenWidth(context, dividedBy: 40),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        gradient: coralTealColor),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("birth day"))
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 12.3),
                                    width: screenWidth(context, dividedBy: 40),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        gradient: coralTealColor),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Valentine's Day"))
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 12.3),
                                    width: screenWidth(context, dividedBy: 40),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        color: ColorCodes.teal),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Mother's Day"))
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 12.3),
                                    width: screenWidth(context, dividedBy: 40),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        color: ColorCodes.teal),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Christmas"))
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 12.3),
                                    width: screenWidth(context, dividedBy: 40),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        color: ColorCodes.teal),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Father's Day"))
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 12.3),
                                    width: screenWidth(context, dividedBy: 40),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        color: ColorCodes.teal),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Hanukkah"))
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 12.3),
                                    width: screenWidth(context, dividedBy: 40),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(8),
                                            bottomLeft: Radius.circular(8)),
                                        color: ColorCodes.teal),
                                  )
                                else
                                  Container(
                                    height:
                                        screenHeight(context, dividedBy: 12.3),
                                    width: screenWidth(context, dividedBy: 40),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8)),
                                      color: ColorCodes.coral,
                                    ),
                                  ),
                                if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("BirthDay"))
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth(context, dividedBy: 20),
                                        top: screenHeight(context,
                                            dividedBy: 86)),
                                    child: CircleAvatar(
                                      radius: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: coralTealColor),
                                      ),
                                    ),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("birthday"))
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth(context, dividedBy: 20),
                                        top: screenHeight(context,
                                            dividedBy: 86)),
                                    child: CircleAvatar(
                                      radius: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: coralTealColor),
                                      ),
                                    ),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Birthday"))
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth(context, dividedBy: 20),
                                        top: screenHeight(context,
                                            dividedBy: 86)),
                                    child: CircleAvatar(
                                      radius: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: coralTealColor),
                                      ),
                                    ),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Birth Day"))
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth(context, dividedBy: 20),
                                        top: screenHeight(context,
                                            dividedBy: 86)),
                                    child: CircleAvatar(
                                      radius: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: coralTealColor),
                                      ),
                                    ),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("birth day"))
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth(context, dividedBy: 20),
                                        top: screenHeight(context,
                                            dividedBy: 86)),
                                    child: CircleAvatar(
                                      radius: 5,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: coralTealColor),
                                      ),
                                    ),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Valentine's Day"))
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth(context, dividedBy: 20),
                                        top: screenHeight(context,
                                            dividedBy: 86)),
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: ColorCodes.teal,
                                    ),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Mother's Day"))
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth(context, dividedBy: 20),
                                        top: screenHeight(context,
                                            dividedBy: 86)),
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: ColorCodes.teal,
                                    ),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Christmas"))
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth(context, dividedBy: 20),
                                        top: screenHeight(context,
                                            dividedBy: 86)),
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: ColorCodes.teal,
                                    ),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Father's Day"))
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth(context, dividedBy: 20),
                                        top: screenHeight(context,
                                            dividedBy: 86)),
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: ColorCodes.teal,
                                    ),
                                  )
                                else if (viewEventsCubit
                                    .calenderGet!.data![index].title
                                    .contains("Hanukkah"))
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth(context, dividedBy: 20),
                                        top: screenHeight(context,
                                            dividedBy: 86)),
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: ColorCodes.teal,
                                    ),
                                  )
                                else
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            screenWidth(context, dividedBy: 20),
                                        top: screenHeight(context,
                                            dividedBy: 86)),
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: ColorCodes.coral,
                                    ),
                                  ),
                                SizedBox(
                                    width: screenWidth(context, dividedBy: 30)),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight(context,
                                          dividedBy: 120)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${viewEventsCubit.calenderGet?.data?[index].date ?? ''}",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Poppins"),
                                      ),
                                      Text(
                                        "${viewEventsCubit.calenderGet?.data?[index].title ?? ''}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Poppins"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
              return SizedBox();
            },
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showAddEventDialog();
          },
          label: Text("Add Event", style: TextStyle(fontFamily: "poppins")),
          backgroundColor: ColorCodes.coral),
    );
  }

  String formatDate(DateTime date) {
    String day = DateFormat('d').format(date);
    String month = DateFormat('MMMM').format(date);

    String suffix = getDaySuffix(int.parse(day));

    return '$day$suffix $month';
  }

  String getDaySuffix(int day) {
    if (day >= 11 && day <= 13) {
      return 'th';
    }
    switch (day % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
