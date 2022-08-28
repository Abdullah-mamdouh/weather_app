
import 'package:flutter/material.dart';


class TextFieldClass extends StatelessWidget {
  TextFieldClass({Key? key,@required this.controller,
    @required this.hintText,
  }) : super(key: key);
  final TextEditingController ? controller;
  String ? hintText ;
  //int textSize;
  //ConstantColors constantColors = new ConstantColors();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: TextDirection.rtl,
      //maxLength: textSize,
      //scrollPadding: EdgeInsets.only(left: 20.0,right: 20.0),
      //textAlign: TextAlign.right,
      controller: controller,
        style: TextStyle(fontSize: 15.0,
            //color: constantColors.whiteColor
        ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(
            top: 10, bottom: 10, left: 15, right: 15),
        filled: true,
        //fillColor: constantColors.blackLight2,
        hintText: '${hintText}',
        //focusColor: constantColors.whiteColor,
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        //fillColor: Colors.white,
        //label: Text('sbxcn jm',style: TextStyle(color: Colors.white),),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(width: 1.5, color: Colors.black),
        ),
      ),
    ) ;
  }
}

  passwordTextFeild(){
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: TextFormField(
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              top: 10, bottom: 10,  right: 15),
          filled: true,
          fillColor: Color(0xff29313C),
          hintText: 'كلمة المرور',
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Image.asset('assets/eye.png'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide:
            BorderSide(width: 1.5, color: Colors.black),
          ),
          // focusedBorder:  OutlineInputBorder(borderRadius: BorderRadius.circular(8),
          //   borderSide: BorderSide(width: 3,color: Colors.white),
          // ),
        ),
      ),
    );
  }
  normalTextFiled(String hintText){
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: TextFormField(
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.right,
        //   style:
        // new TextStyle(fontSize: 15.0, color: Colors.red),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
              top: 10, bottom: 10, left: 15, right: 15),
          filled: true,
          fillColor: Color(0xff29313C),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          //fillColor: Colors.white,
          //label: Text('sbxcn jm',style: TextStyle(color: Colors.white),),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide:
            BorderSide(width: 1.5, color: Colors.black),
          ),
        ),
      ),
    );
  }

