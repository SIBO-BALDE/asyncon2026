import 'package:cloud_firestore/cloud_firestore.dart';

class Event{
  final String subject;
  final String speaker;
  final String avatar;
  final String type;
  final Timestamp date;


  Event({
    required this.subject,
    required this.speaker,
    required this.avatar,
    required this.type,
    required this.date
    ,
  });
  factory Event.formData(dynamic data){
    return Event(
        subject: data['subject'],
        speaker: data['speaker'],
        avatar: data['avatar'].toString().toLowerCase(),
        type: data['type'],
        date: data['date']);

  }
}