import 'dart:async';

import 'package:flutter/material.dart';
import 'package:showwcase_flutter_challenge/core/utils/constants.dart';
import 'package:showwcase_flutter_challenge/features/auth/presentation/manager/auth_user_bloc.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/manager/pokemon_bloc.dart';

import 'injector.dart';

/// this method ensures that widgets have been rendered before taking action that requires context
onWidgetBindingComplete({required Function() onComplete}) {
  WidgetsBinding.instance
      ?.addPostFrameCallback((_) => Timer(const Duration(seconds: 1), onComplete));
}

String generatePokemonImageUrl(String id) => '$kImageUrl/$id.png';

/// this is a handy method for showing an alert dialog
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

/// this is a handy method for showing the snackbar
void showSnackBar(BuildContext ctx, message){
  ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text(message, textAlign: TextAlign.center, style: const TextStyle(fontSize: 18),)));
}

/// This is a handy method for showing a confirm dialog
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

/// handy get method to quickly get a pokemon bloc
PokemonBloc get getPokemonBloc =>
    PokemonBloc(
      getPokemonListUseCase: sl(),
      addNewPokemonUseCase: sl(),
      addPokemonToFavoriteUseCase: sl(),
      removePokemonFromFavoriteUseCase: sl(),
      searchPokemonListUseCase: sl(),
      getPokemonLDetailUseCase: sl(),
      getFavoriteListUseCase: sl()
    );

/// handy get method to quickly get an authuser bloc
AuthUserBloc get getAuthBloc =>
    AuthUserBloc(
        logoutDummyUserUseCase: sl(),
        loginWithDummyUserUseCase: sl(),
        isUserAuthenticatedUseCase: sl()
    );