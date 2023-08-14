import 'dart:io';

import 'package:appcommerce/models/User.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../custom_progress_dialog.dart';
import '../../../size_config.dart';
class ProfilePic extends StatefulWidget {


  @override
  _pic createState() => _pic();
}

class _pic extends State<ProfilePic> {


  ProgressDialog _progressDialog=new ProgressDialog();
  PickedFile imageFile;
  File ff;
  final FirebaseAuth  firebaseAuth = FirebaseAuth.instance;
  String uid;



  Future<String> getUID() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
   uid=user.uid;

  }
  Userr data;
  dynamic image = new List<String>();
  dynamic _fimage = new List<String>();
   String imgprofile='';
  List<Userr> datalist=[];
  Future<String> _handleGetUserData() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
    DatabaseReference ref = FirebaseDatabase.instance.reference().child(
        "Users/${uid}");

    ref.once().then((DataSnapshot datasnapshot) {
      datalist.clear();
      var keys = datasnapshot.value.keys;
      var values = datasnapshot.value;
      image=datasnapshot.value['imgprofile'];
      print("llllllllllllllllll${image}");
    });
  }
  Future<String> getData() async {
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
    DatabaseReference ref = FirebaseDatabase.instance.reference().child(
        "Users/${uid}");

    ref.once().then((DataSnapshot datasnapshot) {
      //datalist.clear();
      var keys = datasnapshot.value.keys;
      var values = datasnapshot.value;
      _fimage=datasnapshot.value['imgprofile'];
        print(_fimage);
    });
  }
  @override
  void initState(){
    getData();
    getUID();
   _handleGetUserData();
    super.initState();
  }
  Future<void>_showChoiceDialog(BuildContext context)
  {
    return showDialog(context: context,builder: (BuildContext context){

      return AlertDialog(
        title: Text("Choose option",style: TextStyle(color: Color(0xFFFF0036)),),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Divider(height: 1,color: Color(0x33FF0036)),
              ListTile(
                onTap: (){
                  _openGallery(context);
                },
                title: Text("Gallery"),
                leading: Icon(Icons.account_box,color: Color(0xFFFF0036)),
              ),

              Divider(height: 1,color:Color(0x33FF0036)),
              ListTile(
                onTap: (){
                  _openCamera(context);
                },
                title: Text("Camera"),
                leading: Icon(Icons.camera,color: Color(0xFFFF0036)),
              ),
            ],
          ),
        ),);
    });
  }
  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 1),
        () => 'Data Loaded',
  );
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return FutureBuilder(
        future:FirebaseDatabase.instance.reference().child(
            "Users/").once(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SizedBox(
              height: 115,
              width: 115,

              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [


                  CircleAvatar(


                    // backgroundImage: AssetImage("assets/images/Profile Image.png"),


                    child: ClipOval(

                      child: new SizedBox(

                        width: 180.0,
                        // height: 180.0,
                        child:(ff != null)?Image.file(ff,fit: BoxFit.fill,):(image ==null)?Image.asset("assets/images/Profile Image.png"):
                            Image.network("${image}",fit:BoxFit.fill)
                       /* child: (ff!=null)?Image.file(
                          ff,
                          fit: BoxFit.fill,
                        ):Image.network(
                          "${image}",
                          fit: BoxFit.fill,
                        ),*/
                        //child: widget.ss == null ? Image.asset('assets/images/glap.png', height: 110.0,):Image.network('${widget.ss}',fit: BoxFit.fill,)
                        //child:Image.network(hh,fit: BoxFit.fill,)
                      ),
                    ),
                  ),
                  Positioned(
                    right: -16,
                    bottom: 0,
                    child: SizedBox(
                      height: 46,
                      width: 46,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: BorderSide(color: Colors.white),
                          ),
                          primary: Colors.white,
                          backgroundColor: Color(0xFFF5F6F9),
                        ),
                        onPressed: () {
                          _showChoiceDialog(context);
                        },
                        child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          else {
            return CircularProgressIndicator(color: Color(0xFFFF0036));
          }
        }
    );

  }
  void _openGallery(BuildContext context) async{
    /*var pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery ,
    );*/
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      ff = image;
      print("Profile Picture uploaded");
      addImageToFirebase(ff);
    });

    Navigator.pop(context);
   // uploadImageToFirebase(context);

  }

  void _openCamera(BuildContext context)  async{
    /*var pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera ,
    );*/
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      ff = image;

      print("Profile Picture uploaded");
      addImageToFirebase(ff);
    });
    Navigator.pop(context);

   // uploadImageToFirebase(context);
  }
  /*Future uploadImageToFirebase(BuildContext context) async {
    String fileName = basename(ff.path);
    final FirebaseUser user = await firebaseAuth.currentUser();
    String uuid = user.uid;
    StorageReference firebaseStorageRef =FirebaseStorage.instance.ref().child('Profile/');
    StorageUploadTask uploadTask = firebaseStorageRef.child("${uuid}.png").putFile(ff);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
    );

    String downloadUrl1 = await taskSnapshot.ref.getDownloadURL();


    final ref = FirebaseDatabase.instance.reference().child('Users');
    //final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;
    ref.child(uid).update({
      'imgprofile':downloadUrl1.toString(),


    });
  }*/
  void addImageToFirebase(File ff) async{
    final FirebaseUser user = await firebaseAuth.currentUser();
    uid = user.uid;

    StorageReference storageReference = FirebaseStorage.instance.ref();
    StorageReference ref = storageReference.child("Profile/");
    StorageUploadTask storageUploadTask = ref.child("${uid}.png").putFile(ff);
    if (storageUploadTask.isSuccessful || storageUploadTask.isComplete) {
      final String url = await ref.getDownloadURL();
      print("The download URL is " + url);
    } else if (storageUploadTask.isInProgress) {

      storageUploadTask.events.listen((event) {
        double percentage = 100 *(event.snapshot.bytesTransferred.toDouble()
            / event.snapshot.totalByteCount.toDouble());
        print("THe percentage " + percentage.toString());
      });

      StorageTaskSnapshot storageTaskSnapshot =await storageUploadTask.onComplete;
      String downloadUrl1 = await storageTaskSnapshot.ref.getDownloadURL();

      //Here you can get the download URL when the task has been completed.
      print("Download URL " + downloadUrl1.toString());
      final ref = FirebaseDatabase.instance.reference().child('Users');
      ref.child(uid).update({
        'imgprofile':downloadUrl1.toString(),
      });

    } else{
      //Catch any cases here that might come up like canceled, interrupted
    }

  }



}
