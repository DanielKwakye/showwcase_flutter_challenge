import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:showwcase_flutter_challenge/core/utils/colors.dart';

class AppListTileShimmer extends StatelessWidget {

  final int count;

  const AppListTileShimmer({this.count = 3, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {

    return Shimmer.fromColors(
      baseColor: ash,
      highlightColor: lightGray,
      child: Column(
        children: <Widget>[

          for(int i = 0; i < count; i++)
          const ListTile(
              leading: CircleAvatar(backgroundColor: ash,),
              title: Text("Loading ...", style: TextStyle(color:  ash, fontWeight: FontWeight.bold, fontSize: 18),),
              subtitle: Text("Loading ... ", style: TextStyle(color: ash, fontSize: 14),)
          ),

        ],
      ),
    );

  }
}
