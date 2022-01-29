import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showwcase_flutter_challenge/app/routing/route.gr.dart';
import 'package:showwcase_flutter_challenge/core/mixin/form_mixin.dart';
import 'package:showwcase_flutter_challenge/core/utils/bloc_state.dart';
import 'package:showwcase_flutter_challenge/core/utils/colors.dart';
import 'package:showwcase_flutter_challenge/core/utils/enums.dart';
import 'package:showwcase_flutter_challenge/core/utils/helpers.dart';
import 'package:showwcase_flutter_challenge/core/utils/injector.dart';
import 'package:showwcase_flutter_challenge/core/utils/widget_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:showwcase_flutter_challenge/features/auth/presentation/manager/auth_user_bloc.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/manager/pokemon_bloc.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/widgets/animated_column_widget.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/widgets/app_rounded_button.dart';
import 'package:showwcase_flutter_challenge/features/shared/presentation/widgets/app_text_field.dart';
import 'package:auto_route/auto_route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageController createState() => _LoginPageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _LoginPageView extends WidgetView<LoginPage, _LoginPageController> {

  const _LoginPageView(_LoginPageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: backgroundGray,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),),
          body: Container(
            color: backgroundGray,
            child: Center(
              child: Wrap(
                children: [
                  Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: BlocBuilder(
                      bloc: context.read<AuthUserBloc>(),
                      builder: (ctx, bloc) {
                        return Form(child: Container(
                          padding: const EdgeInsets.all(20),
                          child: AnimatedColumnWidget(
                            children: <Widget>[
                              const Text('Login as a dummy user', style: TextStyle(fontSize: 22),),
                              const SizedBox(height: 20,),
                              const Text('email: user@showwcase.com \n password: 123456 ', textAlign: TextAlign.center,),
                              const Divider(),
                              const SizedBox(height: 20,),
                              if (bloc is ErrorState<String>)
                                 Text(bloc.failure, style: const TextStyle(color: Colors.red), textAlign: TextAlign.center),
                              if (bloc is ErrorState)
                              const SizedBox(height: 20,),
                              AppTextField('Enter email',
                                onSave: (value) => state.email = value,
                                validator: (value) => state.required(value),
                              ),
                              const SizedBox(height: 20,),
                              AppTextField(
                                'Enter password',
                                textFieldType: AppTextFieldType.password,
                                onSave: (value) => state.password = value,
                                validator: (value) => state.required(value),
                              ),
                              const SizedBox(height: 20,),
                              // if(bloc is LoadingState)
                              if (bloc is LoadingState)
                                const SizedBox(width: 30, height: 30, child: CircularProgressIndicator(),),
                              if(bloc is !LoadingState)
                                Builder(
                                    builder: (c) {
                                      return  AppRoundedButton(text: 'Login', onTap: () => state.loginButtonTapped(c),);
                                    }
                                ),

                            ],
                          ),
                        )
                        );
                      }),
                )
                ],
              ),
            ),
          ),
        );
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class _LoginPageController extends State<LoginPage> with FormMixin {

  String? email, password;


  @override
  Widget build(BuildContext context) => _LoginPageView(this);

  void loginButtonTapped(BuildContext ctx) async{
    // Check if all fields are valid
    if(!validateAndSaveOnSubmit(ctx)){
      return;
    }
    Form.of(ctx)?.save();

    final either = await context.read<AuthUserBloc>().login(email: email!, password: password!);
    // check if usr has successfully logged in, then navigate user to home screen
    if(either != null && either.isRight()){
      showSnackBar(context, "Login successful");
      context.router.replace(const HomePageRoute());
    }

  }
}