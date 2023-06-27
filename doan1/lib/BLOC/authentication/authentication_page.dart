import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/BLOC/screen/all_screen/article/article_bloc.dart';
import 'package:doan1/BLOC/screen/all_screen/all_hotel/all_hotel_bloc.dart';
import 'package:doan1/BLOC/screen/all_screen/all_vehicle/all_vehicle_bloc.dart';
import 'package:doan1/BLOC/screen/book_history/book_history_bloc.dart';
import 'package:doan1/BLOC/screen/home/home_bloc.dart';
import 'package:doan1/BLOC/screen/search/search_bloc.dart';
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
              BlocProvider<AuthenticationBloc>(create: (context) => AuthenticationBloc()),
              BlocProvider<ProfileBloc>(create: (context)=> ProfileBloc(context)),
            ],
            child: BlocListener<AuthenticationBloc, AuthenticationInfoState>(
              listenWhen: (previous, current) => previous.isloggedin != current.isloggedin,
              listener: (context,state){
                if(state.isloggedin == authenticateStatus.Activate) {

                  SmartDialog.dismiss();
                  print("listener triggered "+state.isloggedin.toString());
                }
                if (state.isloggedin == authenticateStatus.unAuthorized) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Wrong username or password.",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                  SmartDialog.dismiss();
                  print("listener triggered "+state.isloggedin.toString());
                }
                if (state.isloggedin == authenticateStatus.Authorizing) {
                  SmartDialog.showLoading(msg: "Logging in...");
                  print("listener triggered "+state.isloggedin.toString());
                }
                if (state.isloggedin == authenticateStatus.Authorized) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Login success.",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );
                  SmartDialog.dismiss();
                  print("listener triggered "+state.isloggedin.toString());
                }
              },
              child: BlocSelector<AuthenticationBloc,AuthenticationInfoState,authenticateStatus>(
                selector: (state)=>state.isloggedin,
                builder: (context,state)=> state == authenticateStatus.Activate || state == authenticateStatus.unAuthorized ?
                const AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                    switchInCurve: Curves.easeIn,
                    child: LoginScreen())
                    :
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
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