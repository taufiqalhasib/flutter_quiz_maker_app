import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService{

  final String uid, email;

  DatabaseService({this.uid, this.email});

  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> addUserData(Map userData) async {
    FirebaseFirestore.instance.collection("User").doc(auth.currentUser.uid).set(userData).catchError((e) {
      print(e.toString());
    });
  }

  getUserData() async {
    return await FirebaseFirestore.instance.collection("User").doc(auth.currentUser.uid).get();
  }

  Future<void> addQuizData(Map quizData, String quizId) async{
    await FirebaseFirestore.instance.collection("Quiz").doc(quizId).set(quizData).catchError((e){
      print(e.toString());
    });
  }

  Future<void> deleteQuizData(String quizId) async{
    await FirebaseFirestore.instance.collection("Quiz").doc(quizId).delete().catchError((e){
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizId, String questionId) async{
    await FirebaseFirestore.instance.collection("Quiz").doc(quizId).collection("QNA").doc(questionId).set(questionData).catchError((e){
      print(e.toString());
    });
  }

  Future<void> updateQuestionData(Map questionData, String quizId, String questionId) async{
    await FirebaseFirestore.instance.collection("Quiz").doc(quizId).collection("QNA").doc(questionId).update(questionData).catchError((e){
      print(e.toString());
    });
  }

  getQuizData() async{
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  getQuestionData(String quizId) async{
    return await FirebaseFirestore.instance.collection("Quiz").doc(quizId).collection("QNA").get();
  }

  Future<void> deleteQuestionData(String quizId, String questionId) async{
    return await FirebaseFirestore.instance.collection("Quiz").doc(quizId).collection("QNA").doc(questionId).delete().catchError((e){
      print(e.toString());
    });
  }
}