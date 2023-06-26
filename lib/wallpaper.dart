import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'imageviewer.dart';
class WallPaper extends StatefulWidget {
  const WallPaper({super.key});

  @override
  State<WallPaper> createState() => _WallPaperState();
}

class _WallPaperState extends State<WallPaper> {
List images=[];
int page=1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchai();

  }
  fetchai()async{
 await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=78'),
   headers: {'Authorization':'uqvAjnlwxpvwQozM7PpqOJWocrMHK5UwzNsKl9Ik6MmW7ki0iC9AK2Df'}
 ).then((value){
   Map result= jsonDecode(value.body);
   setState(() {
    images= result['photos'];
   });

 });

  }
  loadmore()async{
 setState(() {
   page=page+1;
 });
 String url='https://api.pexels.com/v1/curated?per_page=78&page=' + page.toString();
 await http.get(Uri.parse(url),
     headers: {'Authorization':'uqvAjnlwxpvwQozM7PpqOJWocrMHK5UwzNsKl9Ik6MmW7ki0iC9AK2Df'}
 ).then((value) {
   Map result= jsonDecode(value.body);
   setState(() {
     images.addAll(result['photos']);
   });
 });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: GridView.builder(
                itemCount: images.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisSpacing: 2, crossAxisCount: 3,childAspectRatio:2/3 , mainAxisSpacing: 2 ), itemBuilder: (context, index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageFullScreen(imageurl:images[index]['src']['original'] ,)));
                      //options original, large2x, large, medium, small, portrait,landscape, tiny
                    },
                    child: Container(color: Colors.white,
                    child: Image.network(images[index]['src']['tiny'],fit: BoxFit.cover,),


                    ),
                  );
            }),

              )),
          InkWell(
            onTap: (){
              loadmore();
            },
            child: Container(
              height: 60,
              width: double.infinity,
              color: Colors.purpleAccent,
              child: Center(child: Text('Load More',style: TextStyle(fontSize: 20,color: Colors.black87),)),),
          )
        ],
      ),
    );
  }
}
