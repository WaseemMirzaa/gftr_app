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
import 'package:gftr/ViewModel/Cubits/viewsetting.dart';
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
  Map _events = {};
  SharedPrefsService sharedPrefsService = SharedPrefsService();
  ViewEventsCubit viewEventsCubit = ViewEventsCubit();
  ViewSettingCubit viewSettingCubit = ViewSettingCubit();
  CalendarPostsCubit calendarPostsCubit = CalendarPostsCubit();
  DeleteEventCubit deleteEventCubit = DeleteEventCubit();
  final titleController = TextEditingController();

  // Track loading state and last loaded remind me IDs to prevent duplicates
  List<String> _lastLoadedRemindMeIds = [];
  final descpController = TextEditingController();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final children = <Widget>[];
  bool _isLoadingRemindMeEvents =
      false; // Flag to prevent multiple simultaneous loads
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
      if (encodedMap != null && encodedMap.isNotEmpty) {
        print("encode map:$encodedMap");
        try {
          loadPreviousEvents(jsonDecode(encodedMap));
        } catch (e) {
          print("Error parsing events from SharedPreferences: $e");
          // If there's an error parsing, clear the corrupted data
          sharedPrefsService.removeData("events");
        }
      }
    }
  }

  loadPreviousEvents(Map data) {
    // Instead of replacing _events, merge the data to preserve local events
    if (_events.isEmpty) {
      _events = data;
    } else {
      // Merge backend events with local events, checking for duplicates
      data.forEach((key, value) {
        if (_events[key] != null) {
          // If events exist for this date, check for duplicates before adding
          for (var newEvent in value) {
            bool isDuplicate = (_events[key] as List).any((existingEvent) {
              if (existingEvent is Map && newEvent is Map) {
                // Check if same event by ID or title+date combination
                return existingEvent['_id'] == newEvent['_id'] ||
                    (existingEvent['eventTitle'] == newEvent['eventTitle'] &&
                        existingEvent['source'] == newEvent['source']);
              }
              return false;
            });

            if (!isDuplicate) {
              _events[key].add(newEvent);
            }
          }
        } else {
          // If no events exist for this date, create them
          _events[key] = value;
        }
      });
    }
    setState(() {});
  }

  // Method to refresh events from SharedPreferences
  void refreshEventsFromSharedPrefs() async {
    final encodedMap = await sharedPrefsService.getStringData("events");
    if (encodedMap != null && encodedMap.isNotEmpty) {
      try {
        Map<String, dynamic> newEvents = jsonDecode(encodedMap);
        setState(() {
          // Merge new events with existing events, avoiding duplicates
          newEvents.forEach((key, value) {
            if (_events[key] != null) {
              // Check for duplicates before merging
              for (var newEvent in value) {
                bool isDuplicate = (_events[key] as List).any((existingEvent) {
                  if (existingEvent is Map && newEvent is Map) {
                    return existingEvent['_id'] == newEvent['_id'] ||
                        (existingEvent['eventTitle'] ==
                                newEvent['eventTitle'] &&
                            existingEvent['source'] == newEvent['source']);
                  }
                  return false;
                });

                if (!isDuplicate) {
                  _events[key].add(newEvent);
                }
              }
            } else {
              _events[key] = value;
            }
          });
        });
      } catch (e) {
        print("Error refreshing events from SharedPreferences: $e");
      }
    }
  }

  // Method to load remind me events from ViewSettingCubit based on local storage selection
  void loadRemindMeEvents() async {
    // Prevent multiple simultaneous loads
    if (_isLoadingRemindMeEvents) {
      print("loadRemindMeEvents: Already loading, skipping...");
      return;
    }

    if (viewSettingCubit.viewSetting?.data?.remindMe != null) {
      _isLoadingRemindMeEvents = true;

      try {
        // Get selected remind me event IDs from local storage
        List<String>? selectedRemindMeIds =
            await sharedPrefsService.getStringlistData("Eventss");
        selectedRemindMeIds ??= []; // Default to empty list if null

        // Check if remind me IDs have changed since last load
        selectedRemindMeIds.sort(); // Sort for comparison
        _lastLoadedRemindMeIds.sort();

        if (selectedRemindMeIds.join(',') == _lastLoadedRemindMeIds.join(',')) {
          print("loadRemindMeEvents: No changes in remind me IDs, skipping...");
          _isLoadingRemindMeEvents = false;
          return;
        }

        // Update tracking
        _lastLoadedRemindMeIds = List.from(selectedRemindMeIds);

        Map<String, dynamic> remindMeEvents = {};
        int enabledCount = 0;

        // First, completely clear all remind me events from _events
        Map<String, dynamic> cleanedEvents = {};
        _events.forEach((key, eventsList) {
          if (eventsList != null && eventsList.isNotEmpty) {
            // Keep only non-remind-me events
            List<dynamic> nonRemindMeEvents =
                (eventsList as List).where((event) {
              return !(event is Map && event['source'] == 'remindMe');
            }).toList();

            // Only keep the date key if there are non-remind-me events
            if (nonRemindMeEvents.isNotEmpty) {
              cleanedEvents[key] = nonRemindMeEvents;
            }
          }
        });

        // Build new remind me events map
        for (var remindMe in viewSettingCubit.viewSetting!.data!.remindMe) {
          // Only include remind me events that are selected in local storage
          if (selectedRemindMeIds.contains(remindMe.id)) {
            try {
              DateTime eventDate = remindMe.dayDate;
              String dateKey =
                  "${eventDate.month}-${eventDate.day}"; // Format: "8-10"

              if (remindMeEvents[dateKey] == null) {
                remindMeEvents[dateKey] = [];
              }

              // Check if this exact event already exists to prevent duplicates
              bool alreadyExists = remindMeEvents[dateKey].any((event) =>
                  event['id'] == remindMe.id && event['source'] == 'remindMe');

              if (!alreadyExists) {
                remindMeEvents[dateKey].add({
                  'eventTitle': remindMe.dayName,
                  'eventDescp': 'From remind me settings',
                  'source': 'remindMe',
                  'id': remindMe.id
                });
                enabledCount++;
              }
            } catch (e) {
              print("Error parsing remind me event date: $e");
            }
          }
        }

        // Update _events in setState to ensure UI refresh
        if (mounted) {
          setState(() {
            // Replace _events with cleaned version
            _events = cleanedEvents;

            // Add new remind me events
            remindMeEvents.forEach((key, value) {
              if (_events[key] == null) {
                _events[key] = [];
              }
              (_events[key] as List).addAll(value);
            });
          });
        }

        print(
            "Loaded $enabledCount selected remind me events based on local storage");
      } finally {
        _isLoadingRemindMeEvents = false;
      }
    }
  }

  List _listOfDayEvents(DateTime dateTime) {
    String formattedDateKey = formatDate(dateTime); // e.g., "25th December"
    String numericDateKey =
        "${dateTime.month}-${dateTime.day}"; // e.g., "12-25"

    List events = [];

    // Check both possible date formats in local _events
    // This will include remind me events that were loaded via loadRemindMeEvents()
    if (_events[formattedDateKey] != null) {
      events.addAll(_events[formattedDateKey]);
    }
    if (_events[numericDateKey] != null) {
      events.addAll(_events[numericDateKey]);
    }

    // Note: Remind me events are already included in _events via loadRemindMeEvents()
    // so we don't need to add them again here to avoid duplicates

    return events;
  }

  // Helper method to get all upcoming events (both from cubit and local events)
  Future<List<Map<String, dynamic>>> _getAllUpcomingEvents() async {
    List<Map<String, dynamic>> allEvents = [];
    DateTime now = DateTime.now();
    DateTime today = DateTime(
        now.year, now.month, now.day); // Today at midnight for comparison

    // Add events from ViewEventsCubit
    if (viewEventsCubit.calenderGet?.data != null) {
      for (var event in viewEventsCubit.calenderGet!.data!) {
        try {
          // Parse the event date and check if it's today or in the future
          DateTime eventDateTime = _parseEventDate(event.date);
          if (eventDateTime.isAfter(today) ||
              eventDateTime.isAtSameMomentAs(today)) {
            allEvents.add({
              'type': 'cubit',
              'data': event,
              'date': event.date,
              'title': event.title,
              'id': event.id,
              'sortDate': eventDateTime, // For sorting purposes
            });
          }
        } catch (e) {
          print("Error parsing cubit event date: ${event.date} - $e");
          // If we can't parse the date, include the event to be safe
          allEvents.add({
            'type': 'cubit',
            'data': event,
            'date': event.date,
            'title': event.title,
            'id': event.id,
            'sortDate': DateTime.now().add(
                Duration(days: 365)), // Put unparseable events far in future
          });
        }
      }
    }

    // Note: Remind me events are now handled through the _events map
    // We skip adding them separately here to avoid duplicates since
    // loadRemindMeEvents() already adds them to _events with 'source': 'remindMe'

    // Add events from local _events map (this includes both manually added calendar events and remind me events)
    _events.forEach((dateKey, eventsList) {
      if (eventsList != null && eventsList.isNotEmpty) {
        for (var event in eventsList) {
          try {
            // Parse the date key to determine if it's a future event
            DateTime eventDateTime = _parseDateKey(dateKey);
            DateTime eventDateOnly = DateTime(
                eventDateTime.year, eventDateTime.month, eventDateTime.day);

            // Only include future or today's events
            if (eventDateOnly.isAfter(today) ||
                eventDateOnly.isAtSameMomentAs(today)) {
              String displayDate = _convertDateKeyToDisplayFormat(dateKey);

              // Check if this is a remind me event or a regular local event
              bool isRemindMeEvent = event['source'] == 'remindMe';
              if (event['source'] == 'remindMe')
                allEvents.add({
                  'type': !isRemindMeEvent ? 'remindMe' : 'local',
                  'data': event,
                  'date': displayDate,
                  'title': event['eventTitle'] ?? '',
                  'id': isRemindMeEvent ? event['id'] : null,
                  'sortDate': eventDateOnly,
                });
            }
          } catch (e) {
            print("Error parsing local event date key: $dateKey - $e");
            // If we can't parse the date, include the event to be safe
            String displayDate = _convertDateKeyToDisplayFormat(dateKey);
            bool isRemindMeEvent = event['source'] == 'remindMe';

            allEvents.add({
              'type': isRemindMeEvent ? 'remindMe' : 'local',
              'data': event,
              'date': displayDate,
              'title': event['eventTitle'] ?? '',
              'id': isRemindMeEvent ? event['id'] : null,
              'sortDate': DateTime.now().add(
                  Duration(days: 365)), // Put unparseable events far in future
            });
          }
        }
      }
    });

    // Sort events by date (earliest first)
    allEvents.sort((a, b) => a['sortDate'].compareTo(b['sortDate']));

    // Debug: Print event summary to help track duplicates
    print(
        "🔍 _getAllUpcomingEvents: Found ${allEvents.length} total upcoming events");
    Map<String, int> eventTypeCounts = {};
    Map<String, int> titleCounts = {};

    for (var event in allEvents) {
      String type = event['type'];
      String title = event['title'] ?? '';

      eventTypeCounts[type] = (eventTypeCounts[type] ?? 0) + 1;
      titleCounts[title] = (titleCounts[title] ?? 0) + 1;
    }

    print("🔍 Event types: $eventTypeCounts");
    print("🔍 Titles with counts: $titleCounts");

    // Check for potential duplicates (same title appearing more than once)
    titleCounts.forEach((title, count) {
      if (count > 1) {
        print("⚠️  Potential duplicate: '$title' appears $count times");
      }
    });

    return allEvents;
  }

  // Helper method to convert date keys to display format
  String _convertDateKeyToDisplayFormat(String dateKey) {
    try {
      // If it's already in the formatted style (e.g., "25th December"), return as is
      if (dateKey.contains('st ') ||
          dateKey.contains('nd ') ||
          dateKey.contains('rd ') ||
          dateKey.contains('th ')) {
        return dateKey;
      }

      // If it's in numeric format (e.g., "12-25"), convert it
      if (dateKey.contains('-')) {
        List<String> parts = dateKey.split('-');
        if (parts.length == 2) {
          int month = int.parse(parts[0]);
          int day = int.parse(parts[1]);

          // Create a DateTime object for the current year (or any year for formatting)
          DateTime date = DateTime(DateTime.now().year, month, day);
          return formatDate(date);
        }
      }

      return dateKey; // Fallback to original if parsing fails
    } catch (e) {
      print("Error converting date key: $e");
      return dateKey;
    }
  }

  // Helper method to parse event date from cubit (handles various formats like "18th August")
  DateTime _parseEventDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      throw Exception("Empty date string");
    }

    try {
      // Try to parse common date formats
      // Format: "18th August" or "25th December"
      RegExp datePattern = RegExp(r'(\d+)(st|nd|rd|th)\s+(\w+)');
      Match? match = datePattern.firstMatch(dateString);

      if (match != null) {
        int day = int.parse(match.group(1)!);
        String monthName = match.group(3)!;

        // Convert month name to number
        Map<String, int> monthMap = {
          'January': 1,
          'February': 2,
          'March': 3,
          'April': 4,
          'May': 5,
          'June': 6,
          'July': 7,
          'August': 8,
          'September': 9,
          'October': 10,
          'November': 11,
          'December': 12
        };

        int? monthNumber = monthMap[monthName];
        if (monthNumber == null) {
          throw Exception("Invalid month: $monthName");
        }
        int month = monthNumber;
        int year = DateTime.now().year;

        return DateTime(year, month, day);
      }

      // If the above doesn't work, try other parsing methods
      throw Exception("Unable to parse date format: $dateString");
    } catch (e) {
      print("Error parsing event date: $dateString - $e");
      rethrow;
    }
  }

  // Helper method to parse date key from local events (handles formats like "12-25" or "25th December")
  DateTime _parseDateKey(String dateKey) {
    try {
      // If it's already in formatted style (e.g., "25th December")
      if (dateKey.contains('st ') ||
          dateKey.contains('nd ') ||
          dateKey.contains('rd ') ||
          dateKey.contains('th ')) {
        return _parseEventDate(dateKey);
      }

      // If it's in numeric format (e.g., "12-25")
      if (dateKey.contains('-')) {
        List<String> parts = dateKey.split('-');
        if (parts.length == 2) {
          int month = int.parse(parts[0]);
          int day = int.parse(parts[1]);
          int year = DateTime.now().year;

          return DateTime(year, month, day);
        }
      }

      throw Exception("Unable to parse date key format: $dateKey");
    } catch (e) {
      print("Error parsing date key: $dateKey - $e");
      rethrow;
    }
  }

  // Helper method to get the color indicator for an event
  Widget _getEventColorIndicator(String title, bool isCubitEvent) {
    bool isBirthday = title.toLowerCase().contains('birthday') ||
        title.toLowerCase().contains('birth day');

    if (isBirthday) {
      return Container(
        height: screenHeight(context, dividedBy: 12.3),
        width: screenWidth(context, dividedBy: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            gradient: coralTealColor),
      );
    } else if (title.contains("Valentine's Day") ||
        title.contains("Mother's Day") ||
        title.contains("Christmas") ||
        title.contains("Father's Day") ||
        title.contains("Hanukkah")) {
      return Container(
        height: screenHeight(context, dividedBy: 12.3),
        width: screenWidth(context, dividedBy: 40),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            color: ColorCodes.teal),
      );
    } else {
      return Container(
        height: screenHeight(context, dividedBy: 12.3),
        width: screenWidth(context, dividedBy: 40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
          color: ColorCodes.coral,
        ),
      );
    }
  }

  // Helper method to get the dot indicator for an event
  Widget _getEventDotIndicator(String title, bool isCubitEvent) {
    bool isBirthday = title.toLowerCase().contains('birthday') ||
        title.toLowerCase().contains('birth day');

    if (isBirthday) {
      return Padding(
        padding: EdgeInsets.only(
            left: screenWidth(context, dividedBy: 20),
            top: screenHeight(context, dividedBy: 86)),
        child: CircleAvatar(
          radius: 5,
          child: Container(
            decoration:
                BoxDecoration(shape: BoxShape.circle, gradient: coralTealColor),
          ),
        ),
      );
    } else if (title.contains("Valentine's Day") ||
        title.contains("Mother's Day") ||
        title.contains("Christmas") ||
        title.contains("Father's Day") ||
        title.contains("Hanukkah")) {
      return Padding(
        padding: EdgeInsets.only(
            left: screenWidth(context, dividedBy: 20),
            top: screenHeight(context, dividedBy: 86)),
        child: CircleAvatar(
          radius: 5,
          backgroundColor: ColorCodes.teal,
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
            left: screenWidth(context, dividedBy: 20),
            top: screenHeight(context, dividedBy: 86)),
        child: CircleAvatar(
          radius: 5,
          backgroundColor: ColorCodes.coral,
        ),
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies called - refreshing events");
    // Refresh events when the screen becomes active (useful when coming back from settings)
    refreshEventsFromSharedPrefs();
    // Also reload remind me events based on current local storage selections
    loadRemindMeEvents();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewEventsCubit = BlocProvider.of<ViewEventsCubit>(context);
    calendarPostsCubit = BlocProvider.of<CalendarPostsCubit>(context);

    // Try to get ViewSettingCubit from BlocProvider, fall back to instance if not available
    try {
      viewSettingCubit = BlocProvider.of<ViewSettingCubit>(context);
    } catch (e) {
      // Use the instance created if BlocProvider is not available
      print("ViewSettingCubit BlocProvider not found, using instance");
    }

    viewEventsCubit.getcalendarEvents();
    print("initState: About to load ViewSetting data and remind me events");
    viewSettingCubit.getviewSetting().then((_) {
      print("initState: ViewSetting data loaded, now loading remind me events");
      // Load remind me events after ViewSetting data is loaded
      loadRemindMeEvents();
    });

    _selectedDate = _focusedDay;
    MyDataaaa();
    Get_Data(); // Enable loading events from SharedPreferences
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
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            ),
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
              firstDay: DateTime(1900), // Set to a far past date
              lastDay: DateTime(2100), // Set to a far future date
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
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                              '${DateFormat('dd MMMM').format(_selectedDate!).toString()}',
                              style: TextStyle(fontFamily: 'poppins')),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                            onPressed: () {
                              _showAddEventDialog();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorCodes.coral,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: Text(
                              "Add Event",
                              style: TextStyle(fontFamily: "poppins"),
                            ))
                      ],
                    ),
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
              } else {
                // Get all events (both from cubit and local events) using FutureBuilder
                return FutureBuilder<List<Map<String, dynamic>>>(
                  future: _getAllUpcomingEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: spinkitLoader(context, ColorCodes.coral),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: customText("Error loading events", Colors.grey,
                            16, FontWeight.w300, poppins),
                      );
                    }

                    List<Map<String, dynamic>> allEvents = snapshot.data ?? [];

                    if (allEvents.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: customText("No upcoming events", Colors.grey,
                              16, FontWeight.w300, poppins),
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                        itemCount: allEvents.length,
                        itemBuilder: (context, index) {
                          var eventItem = allEvents[index];
                          bool isCubitEvent = eventItem['type'] == 'cubit';
                          bool isRemindMeEvent =
                              eventItem['type'] == 'remindMe';

                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection
                                  .endToStart, // Allow deletion of all events
                              onDismissed: (direction) {
                                if (isCubitEvent) {
                                  // Delete from backend via DeleteEventCubit
                                  deleteEventCubit.Delete_Events(context,
                                          Numbers: "${eventItem['id']}")
                                      .then(
                                    (value) {
                                      setState(() {
                                        viewEventsCubit.getcalendarEvents();
                                      });
                                    },
                                  );
                                } else if (isRemindMeEvent) {
                                  // For remind me events, we need to update the ViewSetting
                                  // This would typically involve calling an API to update the remind me status
                                  // For now, let's show a message that these should be managed from settings
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "To remove '${eventItem['title']}', please go to Settings > Remind Me")));

                                  // Optionally refresh the data to restore the dismissed item
                                  Future.delayed(Duration(seconds: 1), () {
                                    setState(() {
                                      // This will restore the item since we didn't actually delete it
                                    });
                                  });
                                } else {
                                  // Delete from local storage
                                  setState(() {
                                    String originalDateKey = "";
                                    // Find the original date key in _events
                                    _events.forEach((key, value) {
                                      if (value != null && value.isNotEmpty) {
                                        for (var event in value) {
                                          if (event['eventTitle'] ==
                                              eventItem['title']) {
                                            originalDateKey = key;
                                            break;
                                          }
                                        }
                                      }
                                    });

                                    if (originalDateKey.isNotEmpty) {
                                      _events[originalDateKey]?.removeWhere(
                                          (event) =>
                                              event['eventTitle'] ==
                                              eventItem['title']);

                                      // If no events left for this date, remove the date key
                                      if (_events[originalDateKey]?.isEmpty ??
                                          true) {
                                        _events.remove(originalDateKey);
                                      }

                                      // Save updated events to SharedPreferences
                                      String encodedMap = json.encode(_events);
                                      sharedPrefsService.setStringData(
                                          "events", encodedMap);
                                      print(
                                          "Deleted local event: ${eventItem['title']}");
                                    }
                                  });
                                }
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
                                    // Color indicator based on event type or title
                                    _getEventColorIndicator(
                                        eventItem['title'], isCubitEvent),
                                    // Dot indicator
                                    _getEventDotIndicator(
                                        eventItem['title'], isCubitEvent),
                                    SizedBox(
                                        width: screenWidth(context,
                                            dividedBy: 30)),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: screenHeight(context,
                                              dividedBy: 120)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${eventItem['date'] ?? ''}",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Poppins"),
                                              ),
                                              if (!isCubitEvent)
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 8),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2),
                                                  decoration: BoxDecoration(
                                                    color: ColorCodes.coral
                                                        .withValues(alpha: 0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  child: Text(
                                                    "Reminder",
                                                    style: TextStyle(
                                                        color: ColorCodes.coral,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily: "Poppins"),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Text(
                                            "${eventItem['title'] ?? ''}",
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
                  },
                );
              }
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
