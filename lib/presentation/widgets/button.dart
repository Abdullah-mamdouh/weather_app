
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Button({Key? key,required this.text,required this.onClick}) : super(key: key);
  String text ;
  Function onClick;
  //ConstantColors constantColors = ConstantColors();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(20.0),
      ),),
      child: Center(
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
      ),),onPressed: ()=> onClick(),);
  }

}

class ImageButton extends StatelessWidget {
  ImageButton({Key? key,required this.imageAsset,required this.color}) : super(key: key);
  String imageAsset ;
  Color color;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      child: Container(
          width: w,
          height: h * 0.06,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15)),
          child: Center(child: Image.asset(imageAsset))),
      onTap: () {},
    );
  }

}
