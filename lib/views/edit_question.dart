import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/services/database.dart';
import 'package:flutter_quiz_maker_app/views/edit_quiz.dart';
import 'package:flutter_quiz_maker_app/widgets/widgets.dart';

class EditQuestion extends StatefulWidget {

  final String quizId, questionId;
  EditQuestion(this.quizId, this.questionId);

  @override
  _EditQuestionState createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {

  final _formKey = GlobalKey<FormState>();
  String question, option1, option2, option3, option4, correctAnswer, questionId;

  bool _isLoading = false;

  DatabaseService _databaseService = new DatabaseService();

  _updateQuestionData() async{
    if(_formKey.currentState.validate()){

      setState(() {
        _isLoading = true;
      });

      Map<String, String> questionData = {
        "question" : question,
        "option1" : option1,
        "option2" : option2,
        "option3" : option3,
        "option4" : option4,
        "correctAnswer" : correctAnswer,
        "questionId" : widget.questionId
      };

      await _databaseService.updateQuestionData(questionData, widget.quizId, widget.questionId).then((value) => {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditQuiz(widget.quizId)));
        })
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: appBar(context),
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Question"
                ),
                onChanged: (val){
                  question = val;
                },
                validator: (val){
                  return val.isEmpty ? "Enter question" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Option one"
                ),
                onChanged: (val){
                  option1 = val;
                },
                validator: (val){
                  return val.isEmpty ? "Enter option one" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Option two"
                ),
                onChanged: (val){
                  option2 = val;
                },
                validator: (val){
                  return val.isEmpty ? "Enter option two" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Option three"
                ),
                onChanged: (val){
                  option3 = val;
                },
                validator: (val){
                  return val.isEmpty ? "Enter option three" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Option four"
                ),
                onChanged: (val){
                  option4 = val;
                },
                validator: (val){
                  return val.isEmpty ? "Enter option four" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Correct answer"
                ),
                onChanged: (val){
                  correctAnswer = val;
                },
                validator: (val){
                  return val.isEmpty ? "Enter correct answer" : null;
                },
              ),
              Spacer(),

              Row(
                  children: [
                    GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: orangeButton(context, "Back", MediaQuery.of(context).size.width/2 - 36, Colors.deepOrangeAccent)
                    ),
                    SizedBox(width: 24,),
                    GestureDetector(
                        onTap: (){
                          _updateQuestionData();
                        },
                        child: orangeButton(context, "Update Question", MediaQuery.of(context).size.width/2 - 36, Colors.blueAccent)
                    ),
                  ]
              ),
              SizedBox(height: 40.0)
            ],
          ),
        ),
      ),
    );
  }
}
