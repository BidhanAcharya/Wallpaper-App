import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
class ImageFullScreen extends StatefulWidget {
  final String imageurl;
  ImageFullScreen({super.key,required this.imageurl});

  @override
  State<ImageFullScreen> createState() => _ImageFullScreenState();
}

class _ImageFullScreenState extends State<ImageFullScreen> {
  
  Future<void> setwallpaper()async{
    int location = WallpaperManager.BOTH_SCREEN;

    var file = await DefaultCacheManager().getSingleFile(widget.imageurl);
    await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Expanded(child: Container(
              child: Image.network(widget.imageurl),
            )),
            InkWell(
              onTap: (){
                setwallpaper();
              },
              child: Container(
                height: 60,
                width: double.infinity,
                color: Colors.purpleAccent,
                child: Center(child: Text('Set As Wallpaper',style: TextStyle(fontSize: 20,color: Colors.black87),)),),
            )
          ],
        ),
      ),
    );
  }
}
