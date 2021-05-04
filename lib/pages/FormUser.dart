import 'dart:io';
import 'dart:typed_data';

import 'package:flutterapp/Data/Database.dart';
import 'package:flutterapp/Model/User.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/Gallery.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:uuid/uuid.dart';

import '../Common.dart';

class FormUser extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _FormUserState();

}

class _FormUserState extends State<FormUser>{
  File _file;
  TextEditingController nameController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: Text("Nuevo Usuario"),),
        body: SingleChildScrollView(
          child: Padding(padding:EdgeInsets.symmetric(horizontal: 30),child:Column(children: [
            TextFormField(
              decoration: InputDecoration(
                  hintText: "Nombre"
              ),
              controller: nameController,
            ),
            RaisedButton(onPressed:openGallery ,child: Text("Selecciona una imagen"),),
            SizedBox(child: showImage()
              ,),
            RaisedButton(onPressed: saveUser,child: Text("Guardar"),),
          ],),
          ),
        ));
  }

  saveUser(){
    Common.saveImage(_file).then((value){
      if(value!=null)
        Database.TableUser.push().set(User(
            image: value!=null?value:"https://i.ibb.co/myHmH0k/Ea-g9q-LXQAEa-Mj-T.jpg",
            name: nameController.text
        ).toMap()).whenComplete((){
          Navigator.pop(context);
        });

    });
  }



  showImage(){
    if(_file!=null)
      return Image.file(_file);
    else
      return Text("Imagen no seleccionada");
  }

  openGallery(){
    Navigator.push(context, MaterialPageRoute(builder: (_)=>Gallery(onSelect,requestType: RequestType.image,)));
  }

  onSelect(AssetEntity assetEntity){
    assetEntity.file.then((value) => setState(() {
      _file=value;
    }));

  }
}