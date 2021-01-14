import 'package:flutter/material.dart';
import 'package:flutter_quiz_maker_app/services/database.dart';
import 'package:flutter_quiz_maker_app/views/edit_quiz.dart';
import 'package:flutter_quiz_maker_app/widgets/widgets.dart';

class QuizList extends StatefulWidget {
  @override
  _QuizListState createState() => _QuizListState();
}

class _QuizListState extends State<QuizList> {

  Stream quizStream;

  DatabaseService _databaseService = new DatabaseService();

  bool _isLoading = true;

  Widget quizList(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot){
          return snapshot == null ?
          Container(
            child: Center(child: Text("No Quiz Available", style: TextStyle(fontSize: 18, color: Colors.red),)),
          ) :
          ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index){
                return QuizEditTile(
                    imageUrl: snapshot.data.docs[index].data()["quizImgUrl"],
                    title: snapshot.data.docs[index].data()["quizTitle"],
                    description: snapshot.data.docs[index].data()["quizDescription"],
                    quizId: snapshot.data.docs[index].data()["quizId"]
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
        _isLoading = false;
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
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: _isLoading
          ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : quizList(),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: (){
      //     Navigator.push(context, MaterialPageRoute(builder: (context) => CreateQuiz()));
      //   },
      // ),
    );
  }
}

class QuizEditTile extends StatelessWidget {

  final String imageUrl;
  final String title;
  final String description;
  final String quizId;

  QuizEditTile({@required this.imageUrl, @required this.title, @required this.description, @required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return EditQuiz(quizId);
        }));
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

