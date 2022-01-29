import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showwcase_flutter_challenge/app/routing/route.gr.dart';
import 'package:showwcase_flutter_challenge/core/utils/constants.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/repositories/auth_user_repository.dart';
import 'package:showwcase_flutter_challenge/features/auth/domain/use_cases/is_user_authenticated_use_case.dart';

// route guard protects pages from being accessed by unauthorized users
class AuthGuard extends AutoRouteGuard {

  IsUserAuthenticatedUseCase isUserAuthenticatedUseCase;
  AuthGuard(this.isUserAuthenticatedUseCase);

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    final either = await isUserAuthenticatedUseCase(IsUserAuthParams());
   either?.fold((l) {
     // Send user to login page if there is an error
     router.push(const LoginPageRoute());
   }, (r) {

     if (r == null) {

       // we redirect the user to our login page
       // this should not occur cus it likely to enter here only if its a technical error
       router.push(const LoginPageRoute());

     } else {
       // Notify UI of the pokemon data received from the server

       // if user is authenticated we continue
       resolver.next(true);

     }

   });

  }
}
