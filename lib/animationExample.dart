import 'package:flutter/material.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/imageConstants.dart';

class AnimationExample extends StatefulWidget {
  const AnimationExample({Key? key}) : super(key: key);

  @override
  State<AnimationExample> createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Center(
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage()));
            },
            child: Container(
              height: screenHeight(context,dividedBy: 10),
              width: screenHeight(context,dividedBy: 10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red
              ),
              child: Hero(
                tag: "avatar-1",
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(ImageConstants.dummyProfile,fit: BoxFit.fill,)
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Hero(
          tag: "avatar-1",
          child: Image.asset(
            ImageConstants.dummyProfile,
            fit: BoxFit.cover,
          )
        )
      ),
      // body: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       expandedHeight: 300,
      //       flexibleSpace: FlexibleSpaceBar(
      //         title: const Text("Item #1"),
      //         background: Hero(
      //           tag: "avatar-1",
      //           child: Image.asset(
      //             ImageConstants.dummyProfile,
      //             fit: BoxFit.cover,
      //           )
      //         )
      //       )
      //     )
      //   ]
      // )
    );
  }
}


class FolderData{
  late String folderName;
  late String folderId;
  FolderData(this.folderName,this.folderId);

  data(){
    List<FolderData> folderData = [];
    folderData.add(FolderData("",""));
  }

}



