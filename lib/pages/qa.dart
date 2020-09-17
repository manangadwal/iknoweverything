import 'dart:convert';
import 'dart:html';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iknoweverything/models/answers.dart';



class Qapge extends StatefulWidget {
  @override
  _QapgeState createState() => _QapgeState();
}

class _QapgeState extends State<Qapge> {
///text editing controler
TextEditingController _quesfieldcontroler =TextEditingController();

Answer _currentAnswer;

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

///Handle Yes & No
_handleGetAnswer() async {
  String questionText = _quesfieldcontroler.text?.trim();

  if(questionText == null  || questionText.length == 0 || questionText[questionText.length-1] !='?'){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('Please Ask A Valid Question.'),
      duration: Duration(seconds: 3),
    ));
    return;
  }
  try{
    http.Response response = await http.get('https://yesno.wtf/api');
    if(response.statusCode== 200 && response.body != null){
      Map<String, dynamic> responseBody = json.decode(response.body);
     Answer answer = Answer.fromMap(responseBody);
     setState(() {
        _currentAnswer = answer;
     });
    }
  }catch(err , stacktrace) {
    print(err);
    print(stacktrace);

  }
  

}
//reset
_handleResetOperation() {
  _quesfieldcontroler.text ='';
  setState(() {
    _currentAnswer = null;
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Image.network('https://www.desktopbackground.org/p/2012/03/28/365984_question-mark-hd-wallpapers_2000x1000_h.jpg').color,
      key: _scaffoldKey,
            appBar: AppBar(
        centerTitle: true,
        title :
         Text('I Know Everything',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.amber,
        elevation: 0,  
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Container
          (width:0.5*MediaQuery.of(context).size.width,
          child: TextField(
            controller: _quesfieldcontroler,
            decoration: InputDecoration(
              labelText:'Ask A Question',
              border: OutlineInputBorder()
            ),
          ))),
          SizedBox(
            height: 20,
          ),
          if(_currentAnswer != null)
          Container(
            height: 250,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(image: NetworkImage(_currentAnswer.image),
             /// fit: BoxFit.cover
              )
            ),
          ),
           SizedBox(
            height: 20,
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            RaisedButton(onPressed: _handleGetAnswer, child: Text('Get Answer',style: TextStyle(color: Colors.white)),
            shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(18.0),
  side: BorderSide(color: Colors.amber)
),
color: Theme.of(context).primaryColor, ),
            SizedBox(
              width: 20,
            ),
            RaisedButton(onPressed: _handleResetOperation, child: Text('Reset',style: TextStyle(color: Colors.white)),
            shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(18.0),
  side: BorderSide(color: Colors.amber),
  
),color: Theme.of(context).primaryColor
             ),
          ],  
          )
        ],
      )
      ,

    );
      
  
  }
}