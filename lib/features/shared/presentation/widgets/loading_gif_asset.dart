import 'package:flutter/material.dart';
import 'package:showwcase_flutter_challenge/core/utils/images.dart';


class LoadingGifAsset extends StatelessWidget {
  const LoadingGifAsset({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        children: [
          //Image.asset(loading_gif_2),
          const SizedBox(width: double.infinity, height: double.infinity, child:  CircularProgressIndicator(backgroundColor: Colors.white,),),
          Align(
            alignment: Alignment.center,
            child: Image.asset(appLogo, width: 40, height: 40,),
          )
        ],
      ),
    );
  }
}
