import 'package:doan1/widgets/salomon_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../../screens/login/login_screens.dart';
import 'authentication_bloc.dart';

class AuthenticationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Builder(builder:
          (context)=>
          MultiBlocProvider(
            providers: [
              BlocProvider<AuthenticationBloc>(create: (context) => AuthenticationBloc(),),
            ],
            child: BlocListener<AuthenticationBloc, AuthenticationInfoState>(
              listener: (context,state){
                if (state.isloggedin == authenticateStatus.unAuthorized) {
                  SmartDialog.dismiss();
                  print("listener triggered "+state.isloggedin.toString());
                }
                if (state.isloggedin == authenticateStatus.Authorizing) {
                  print("listener triggered "+state.isloggedin.toString());
                }
                if (state.isloggedin == authenticateStatus.Authorized) {
                  SmartDialog.dismiss();
                  print("listener triggered "+state.isloggedin.toString());
                }
              },
              child: BlocSelector<AuthenticationBloc,AuthenticationInfoState,authenticateStatus>(
                selector: (state)=>state.isloggedin,
                builder: (context,state)=>state==authenticateStatus.unAuthorized ?
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                    switchInCurve: Curves.easeIn,
                    child: LoginScreen())
                    :
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 250),
                    transitionBuilder: (child, Animation<double> animation){
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.25),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                    switchInCurve: Curves.easeIn,
                    child: NavigationNavBar()),
              ),
            ),
          ),
      );
  }
}