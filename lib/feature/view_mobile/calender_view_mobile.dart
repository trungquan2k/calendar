import 'dart:math';

import 'package:calendar/data/calendar_model.dart';
import 'package:calendar/utils/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPageViewMobile extends StatefulWidget {
  const CalendarPageViewMobile({Key? key}) : super(key: key);

  @override
  State<CalendarPageViewMobile> createState() => _CalendarPageViewMobileState();
}

class _CalendarPageViewMobileState extends State<CalendarPageViewMobile> {
  final CalendarController _controller = CalendarController();
  MeetingDataSource? dataSource;
  List<MeetingEvent> meetingss = <MeetingEvent>[];
  var outputFormat = DateFormat('hh:mm a');
  String? _subjectText = '',
      _startTimeText = '',
      _endTimeText = '',
      _dateText = '',
      _timeDetails = '';

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {s
      final MeetingEvent appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.description;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.from)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.from).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.to).toString();
      _timeDetails = '$_startTimeText - $_endTimeText';
    } else if (details.targetElement == CalendarElement.calendarCell) {
      _subjectText = "Information detail of event";
      _dateText = DateFormat('MMMM dd, yyyy').format(details.date!).toString();
      _timeDetails = '';
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('$_subjectText'),
            content: SizedBox(
              height: 80,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '$_startTimeText',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Text(_endTimeText!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  String _dayFormat = 'EEE', _dateFormat = 'dd';

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    if (_controller.view == CalendarView.week) {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        if (_dayFormat != 'EEE' || _dateFormat != 'dd') {
          setState(() {
            _dayFormat = 'EEE';
            _dateFormat = 'dd';
          });
        } else {
          return;
        }
      });
    } else {
      SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
        if (_dayFormat != 'EEE' || _dateFormat != 'dd') {
          setState(() {
            _dayFormat = 'EEE';
            _dateFormat = 'dd';
          });
        } else {
          return;
        }
      });
    }
  }

  final List<CalendarView> _allowedViews = <CalendarView>[
    CalendarView.day,
    CalendarView.week,
    CalendarView.workWeek,
    CalendarView.month,
    CalendarView.schedule,
    CalendarView.timelineDay,
    CalendarView.timelineWeek,
    CalendarView.timelineWorkWeek,
    CalendarView.timelineMonth,
  ];

  @override
  void initState() {
    _getDataSource();
    super.initState();
  }

  Random random = Random();

  int index = 0;

  void changeIndex() {
    setState(() => index = random.nextInt(3));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          changeIndex();
          var i = 1;
          final DateTime newTime = DateTime(2022, 12, i++, 10);
          final DateTime endNewTime = DateTime(2022, 12, i++, 22);
          final app = MeetingEvent(
              "New Event",
              newTime,
              endNewTime,
              AppColors.colors[index],
              true,
              "Hhiha",
              "https://i.ibb.co/HpLgFy9/avatar-User.png",
              "");
          setState(() {
            meetingss.add(app);
          });
        },
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.symmetric(
            horizontal: 12.0,
            // vertical: 4.0,
          ),
          child: Column(
            children: [
              SfCalendar(
                view: CalendarView.week,
                dataSource: MeetingDataSource(meetingss),
                todayHighlightColor: const Color(0xff5684AE),
                headerDateFormat: "yMMMM",
                showNavigationArrow: true,
                controller: _controller,
                onViewChanged: viewChanged,
                allowAppointmentResize: true,
                dragAndDropSettings:
                    const DragAndDropSettings(allowNavigation: true),
                scheduleViewSettings: const ScheduleViewSettings(
                  dayHeaderSettings: DayHeaderSettings(
                      dayFormat: 'EEEE',
                      width: 70,
                      dayTextStyle: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: Colors.red,
                      ),
                      dateTextStyle: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.red,
                      )),
                  appointmentTextStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.lime),
                ),
                onTap: calendarTapped,
                headerStyle: const CalendarHeaderStyle(
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff5684AE))),
                timeSlotViewSettings: TimeSlotViewSettings(
                    dateFormat: _dateFormat, dayFormat: _dayFormat),
                monthViewSettings: const MonthViewSettings(
                    navigationDirection: MonthNavigationDirection.horizontal,
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Upcoming Events ",
                    style: TextStyle(
                        color: Color(0xff5684AE),
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "View all ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Today , ${DateFormat("MMM d").format(DateTime.now())}",
                  style: const TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(height: 8.0),
              Expanded(child: StreamBuilder(
                // stream: ,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemCount: meetingss.length,
                    itemBuilder: (context, index) {
                      return Card(
                          color: meetingss[index].background,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  // leading: const Icon(Icons.album),
                                  title: Text(meetingss[index].eventName),
                                  subtitle: Column(
                                    children: [
                                      const SizedBox(height: 10.0),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                            '${outputFormat.format(meetingss[index].from)} - ${outputFormat.format(meetingss[index].to)}'),
                                      ),
                                      const SizedBox(height: 10.0),
                                      Row(
                                        children: [
                                          ImageNetwork(
                                            image: meetingss[index].avatar,
                                            height: 36,
                                            width: 36,
                                            duration: 1000,
                                            curve: Curves.easeIn,
                                            onPointer: true,
                                            debugPrint: false,
                                            fullScreen: false,
                                            fitAndroidIos: BoxFit.cover,
                                            fitWeb: BoxFitWeb.cover,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            onLoading:
                                                const CircularProgressIndicator(
                                              color: Colors.indigoAccent,
                                            ),
                                            onError: const Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                            onTap: () {},
                                          ),
                                          const SizedBox(width: 10.0),
                                          InkWell(
                                            onTap: () {},
                                            child: const Text(
                                              "View Client Profile",
                                              style: TextStyle(
                                                  decoration:
                                                      TextDecoration.underline,
                                                  color: Color(0xFF5684AE)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]));
                    },
                  );
                },
              )),
            ],
          )),
    );
  }

  List<MeetingEvent> _getDataSource() {
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime newTime = DateTime(2022, 11, 29, 10);
    final DateTime endNewTime = DateTime(2022, 11, 29, 12);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    meetingss.add(MeetingEvent(
        'InterView PNV',
        startTime,
        endTime,
        const Color(0xFFFFE4C8),
        false,
        "Meeting with staff",
        "https://i.ibb.co/HpLgFy9/avatar-User.png",
        "Hoang Trung Quan"));
    meetingss.add(MeetingEvent(
        'InterView Master Branch',
        newTime,
        endNewTime,
        const Color(0xFFF9BE81),
        false,
        "Meeting with staff",
        "https://i.ibb.co/HpLgFy9/avatar-User.png",
        "Hoang Trung Quan"));
    return meetingss;
  }
}
