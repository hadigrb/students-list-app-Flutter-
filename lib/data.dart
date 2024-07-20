import 'dart:async';

import 'package:dio/dio.dart';


//a class for student data
class StudentData {
  final int id;
  final String firstName;
  final String lastName;
  final String course;
  final dynamic score;
  final String createdAt;
  final String updatedAt;

  StudentData(this.id, this.firstName, this.lastName, this.course, this.score,
      this.createdAt, this.updatedAt);

  //parse json objects to the StudentData object
  StudentData.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        course = json['course'],
        score = json['score'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];
}

//http client with base options
class HttpClient {
  static Dio instance =
  Dio(BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'));
}

//function for fetching students data from backend
Future<List<StudentData>> getStudents() async {
  final response = await HttpClient.instance.get('experts/student');
  final List<StudentData> students = [];
  if (response.data is List<dynamic>){
    (response.data as List<dynamic>).forEach((element){
      students.insert(0, StudentData.fromJson(element));
    });
  }
  return students;
}

//function for creating a new student and sending it to the backend
Future<StudentData> savetudent(String firstName, String lastName, String course, int score) async {
  final response = await HttpClient.instance.post('experts/student', data: {
    'first_name': firstName,
    'last_name':lastName,
    'course':course,
    'score':score
  });

  if (response.statusCode == 200){
    return StudentData.fromJson(response.data);
  }else {
    throw Exception();
  }
}
