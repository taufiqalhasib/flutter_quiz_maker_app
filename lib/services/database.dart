import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService{

  Future<void> addQuizData(Map quizData, String quizId) async{
    await FirebaseFirestore.instance.collection("Quiz").doc(quizId).set(quizData).catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId) async{
    await FirebaseFirestore.instance.collection("Quiz").doc(quizId).collection("QNA").add(questionData).catchError((e){
      print(e.toString());
    });
  }

  getQuizData() async{
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  getQuestionData(String quizId) async{
    return await FirebaseFirestore.instance.collection("Quiz").doc(quizId).collection("QNA").snapshots();
  }
}