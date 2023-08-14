import 'package:appcommerce/screens/complete_profile/components/complete_profile_form.dart';
import 'package:appcommerce/screens/sign_up/components/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:appcommerce/size_config.dart';

import 'components/body.dart';

class OtpScreen extends  StatefulWidget {
CompleteProfileForm ss;
  String rr;
 Inform todo;
  OtpScreen(this.rr,{this.todo});

  @override
  _dd createState() => _dd();

}
  bool _isInit = true;
  var _contact = '';

 //OtpScreen(String s, {Key key, @required this.aa}) : super(key: key);

class _dd extends State<OtpScreen> {

  static String routeName = "/otp";
  @override
  Widget build(BuildContext context) {
    String nn=widget.rr;

   // widget._contact = '${ModalRoute.of(context).settings.arguments as String}';
   // final args = ModalRoute.of(context).settings.arguments as CompleteProfileForm;
    //nn=args.a as String;
    //var one = int.parse(nn);
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
       // title: Text("OTP Verification"),
        title: Text("OTP Verification"),
      ),
      body: Body(widget.rr,widget.todo),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('ooooooooooooooooo :${widget.rr}');
    print('rrrrrrrrrrrrrrrrrrrr :${widget.todo.name}');
  }
}
