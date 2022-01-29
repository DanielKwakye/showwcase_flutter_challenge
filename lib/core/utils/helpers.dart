import 'dart:async';

import 'package:flutter/material.dart';
import 'package:showwcase_flutter_challenge/core/utils/constants.dart';

onWidgetBindingComplete({required Function() onComplete}) {
  WidgetsBinding.instance
      ?.addPostFrameCallback((_) => Timer(const Duration(seconds: 1), onComplete));
}

String generatePokemonImageUrl(String id) => '$kImageUrl/$id.png';

void showHandyAlertDialog(BuildContext context, {String title = "Please note", String content = "", void Function()? okTapped}){
  showDialog(context: context, builder: (ctx) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
      content: Text(content),
      actions: [

        TextButton(onPressed: (){
          Navigator.of(context).pop();
          if(okTapped != null){
            okTapped();
          }
        }, child: const Text("OK"))
      ],
    );

  });

}

void showSnackBar(BuildContext ctx, message){
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18),)));
}


void showHandyConfirmDialog(BuildContext context, {String title: "Confirm", String content : "", void Function()? okTapped, void Function()? onCancelTapped}){
  showDialog(context: context, builder: (ctx) {
    return AlertDialog(
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold),),
      content: Text(content),
      actions: [

        // cancel button
        TextButton(onPressed: (){
          Navigator.of(context).pop();
          if(onCancelTapped != null){
            onCancelTapped();
          }
        }, child: const Text("Cancel")),

        // okay button
        TextButton(onPressed: (){
          Navigator.of(context).pop();
          if(okTapped != null){
            okTapped();
          }
        }, child: const Text("OK"))

      ],
    );
  });

}