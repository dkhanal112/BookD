 import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 
 class CustomFunctions{
   static Future<bool> dialogOpen(
      { BuildContext ?context,
       String? title,
       String? content}) async {
    if (Platform.isIOS) {
      bool status = await showDialog(
        context: (context!),
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(content!),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child:const Text(
                  'No',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          );
        },
      );
      return status;
    } else {
      bool status = await showDialog(
        context: (context!),
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              title!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(content!),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child:const Text(
                  'Yes',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              )
            ],
          );
        },
      );
      return status;
    }
  }


// Progress bottom sheet
static showProgressBottomSheet(BuildContext context, String text) async {
    await showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      isDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          decoration:const  BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          height: 150,
          child: Column(
            children: [
           const    SizedBox(height: 20),
              Text(
                text,
                style:const  TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontFamily: "WorkSansBold",
                ),
              ),
            const  SizedBox(height: 20),
           
              const CircularProgressIndicator()
            ],
          ),
        );
      },
    );
  }


 }
 
 