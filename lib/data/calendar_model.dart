import 'package:flutter/animation.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<MeetingEvent> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  MeetingEvent _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final MeetingEvent meetingData;
    if (meeting is MeetingEvent) {
      meetingData = meeting;
    }

    return meetingData;
  }
}

class MeetingEvent {
  MeetingEvent(this.eventName, this.from, this.to, this.background,
      this.isAllDay, this.description, this.avatar, this.userName);

  String eventName;
  DateTime from;
  DateTime to;
  String description;
  String avatar;
  String userName;
  Color background;
  bool isAllDay;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['eventName'] = eventName;
    data['from'] = from;
    data['to'] = to;
    data['avatar'] = avatar;
    data['userName'] = userName;
    return data;
  }
}
