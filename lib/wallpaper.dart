import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:wallpaper_app/fullscreen.dart';
class Wallpaper extends StatefulWidget {
  const Wallpaper({Key? key}) : super(key: key);

  @override
  _WallpaperState createState() => _WallpaperState();
}

class _WallpaperState extends State<Wallpaper> {
List images=[];
int pages=1;
  fetchapi()async{
    // curl -H "Authorization: 563492ad6f91700001000001541ef7d7fd074c1ab5a0bfacc3dede86" \
    // "https://api.pexels.com/v1/curated?per_page=1"
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
    headers: {'Authorization': '563492ad6f91700001000001541ef7d7fd074c1ab5a0bfacc3dede86'}).then((value){
      print("____________________________");
      Map result=jsonDecode(value.body);
      setState((){
        images=result['photos'];
      });
      print("____________${images.length}________________");
    });

  }
  @override
  void initState() {
   fetchapi();
    super.initState();
  }

  loadmore() async{
    setState((){
      pages=pages+1;
    });
    String url='https://api.pexels.com/v1/curated?per_page=80&page='+pages.toString();
    await http.get(Uri.parse(url),
        headers: {'Authorization': '563492ad6f91700001000001541ef7d7fd074c1ab5a0bfacc3dede86'}).then((value){
      print("____________________________");
      Map result=jsonDecode(value.body);
      setState((){
        images.addAll(result['photos']);
      });
      print("____________${images.length}________________");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallpaper'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 2,childAspectRatio: 2/3,mainAxisSpacing: 2),
                  itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>FullScreen(images[index]['src']['large2x'])));
                    },
                    child: Container(
                    child: Image.network(images[index]['src']['tiny'],fit:BoxFit.cover),),
                  );
                  }),
            ),
          ),
          Center(
            child: InkWell(
              onTap: (){
                loadmore();
              },
              child: Container(
                alignment:Alignment.center,
                height: 60,
                width: double.infinity,
                color: Colors.black,
                child:Text('Load More',style:TextStyle(color: Colors.white,fontSize: 20))
              ),
            ),
          )
        ],
      ),
    );
  }
}
