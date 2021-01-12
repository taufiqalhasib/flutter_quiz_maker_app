import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/services/database.dart';
import 'package:flutter_quiz_maker_app/views/create_quiz.dart';
import 'package:flutter_quiz_maker_app/views/play_quiz.dart';
import 'package:flutter_quiz_maker_app/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream quizStream;

  DatabaseService _databaseService = new DatabaseService();

  Widget quizList(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot){
          return snapshot == null ?
              Container() :
              ListView.builder(
                itemCount: snapshot.data.documents.length,
                  itemBuilder: (context, index){
                    return QuizTile(
                        imageUrl: snapshot.data.documents[index].data()["quizImgUrl"],
                        title: snapshot.data.documents[index].data()["quizTitle"],
                        description: snapshot.data.documents[index].data()["quizDescription"],
                        quizId: snapshot.data.documents[index].data()["quizId"]
                    );
                  });
        },
      ),
    );
  }

  @override
  void initState() {
    _databaseService.getQuizData().then((value){
      setState(() {
        quizStream = value;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuiz()));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String description;
  final String quizId;

  QuizTile({@required this.imageUrl, @required this.title, @required this.description, @required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PlayQuiz(
          quizId
        )));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 150,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl, width: MediaQuery.of(context).size.width - 48, fit: BoxFit.cover,)
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.black26
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),),
                  SizedBox(height: 6,),
                  Text(description, style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

