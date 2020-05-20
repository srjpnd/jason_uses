import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http ;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  Future<List<Users>>  _getusers()async{
   var data=await http.get("https://jsonplaceholder.typicode.com/users"); 

   var jsonData= json.decode(data.body);

   List<Users> users= [];
   for(var u in jsonData ){
      Users user= Users(u["name"],u["username"],u["email"]);

      users.add(user);
    }
    print(users.length);
    return users;
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Container(
      child: FutureBuilder(
        future: _getusers(),
        builder:(BuildContext context,AsyncSnapshot snapshot ){

         if (snapshot.data==null){
           return Container(child: 
           Center(child: 
           Text("Loding.........")),);}
  else{
          return ListView.builder(itemCount:snapshot.data.length,
            itemBuilder: (BuildContext context, int index ){
            return ListTile(
              leading: CircleAvatar(),

              title:Text(snapshot.data[index].name) ,
              subtitle: Text(snapshot.data[index].email,style: TextStyle(color: Colors.grey,fontSize: 10),),
              

            );
          });
  }
        },
    ),
       )// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Users {

String name;
String username;
String email;

Users(this.email,this.name,this.username);

}