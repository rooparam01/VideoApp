import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
class Utils{

  static void flushBarErrorMessage(String message,BuildContext context){
   showFlushbar(context: context,
       flushbar: Flushbar(
         forwardAnimationCurve: Curves.decelerate,
         margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
         padding: EdgeInsets.all(15),
         message: message,
         duration: Duration(seconds: 3),
         backgroundColor: Colors.red,
         reverseAnimationCurve: Curves.easeInOut,
         positionOffset: 20,
         borderRadius: BorderRadius.circular(20),
         flushbarPosition: FlushbarPosition.TOP,
         icon: Icon(Icons.error,size: 28,color: Colors.white,),
       )..show(context)
   );
  }

 static void flushBarSuccessMessage(String message,BuildContext context){
   showFlushbar(context: context,
       flushbar: Flushbar(
         forwardAnimationCurve: Curves.decelerate,
         margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
         padding: EdgeInsets.all(15),
         message: message,
         duration: Duration(seconds: 3),
         backgroundColor: Colors.green,
         reverseAnimationCurve: Curves.easeInOut,
         positionOffset: 20,
         borderRadius: BorderRadius.circular(20),
         flushbarPosition: FlushbarPosition.TOP,
         icon: Icon(Icons.error,size: 28,color: Colors.white,),
       )..show(context)
   );
 }

  static snakBar(String message , BuildContext context){
   return ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(
           backgroundColor: Colors.red,
           content: Text(message))
   );
  }

}