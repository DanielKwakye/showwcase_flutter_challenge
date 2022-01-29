import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showwcase_flutter_challenge/app/routing/route.gr.dart';
import 'package:showwcase_flutter_challenge/core/utils/constants.dart';

// route guard protects pages from being accessed by unauthorized users
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user = preferences.getString(kUser);
    final authenticated = user != null;
    if(authenticated){
      // if user is authenticated we continue
      resolver.next(true);
    }else{
      // we redirect the user to our login page
      router.push(const LoginPageRoute());
    }
  }
}
