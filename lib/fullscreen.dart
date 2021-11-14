import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';
import 'package:flutter_cache_manager/file.dart';
class FullScreen extends StatefulWidget {
 final String imageurl;

FullScreen(this.imageurl);
  @override
  _FullScreenState createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {


  setWallpaper()async{
    var location=WallpaperManager.HOME_SCREEN;
    print(location);
    var file=await DefaultCacheManager().getSingleFile(widget.imageurl);
    String result=await WallpaperManager.setWallpaperFromFile(file.path,location);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child:Container(
              child: Image.network(widget.imageurl),
            )),
            InkWell(
              onTap: (){
                setWallpaper();
              },
              child: Container(
                  alignment:Alignment.center,
                  height: 60,
                  width: double.infinity,
                  color: Colors.black,
                  child:Text('Set Wallpaper',style:TextStyle(color: Colors.white,fontSize: 20))
              ),
            ),
          ],
        ),
      ),
    );
  }
}
