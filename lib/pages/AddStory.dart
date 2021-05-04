import 'dart:io';
import 'dart:typed_data';

import 'package:flutterapp/Data/Database.dart';
import 'package:flutterapp/Model/Story.dart';
import 'package:flutterapp/Model/User.dart';
import 'package:flutterapp/Pages/Gallery.dart';
import 'package:flutterapp/Pages/ImageViewer.dart';
import 'package:flutterapp/Pages/VideoViewer.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

import '../Common.dart';

class AddStory extends StatefulWidget{
  User user;
  AddStory(this.user);
  @override
  State<StatefulWidget> createState() => _AddStoryState();

}

class _AddStoryState extends State<AddStory>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Gallery(onSelect);
  }

  onSelect(AssetEntity assetEntity){
    Navigator.push(context, MaterialPageRoute(builder: (_){
      return(assetEntity.type==AssetType.image)?
      ImageViewer(saveStory, assetEntity):VideoViewer(saveStory, assetEntity);
    }));
  }

  saveStory(AssetEntity assetEntity)async{
    Common.saveImage(await assetEntity.file).then((value)async{
      if(value!=null)
        await Database.TableStory.push().set(Story(
          url: value,
          type: (assetEntity.type==AssetType.image)?"Image":"Video",
          userId: widget.user.key,
        ).toMap());

    });
  }

}