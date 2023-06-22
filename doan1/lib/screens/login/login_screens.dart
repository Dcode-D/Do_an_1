import 'package:doan1/BLOC/register/register_bloc.dart';
import 'package:doan1/screens/login/forgot_password_screen.dart';
import 'package:doan1/screens/login/signup_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../BLOC/authentication/authentication_bloc.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key})
      : super(key: key);

  @override
  createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isPasswordHidden = true;
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/login-wallpaper.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0,top: 35),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                blurRadius: 20,
                                offset: const Offset(2, 4),
                              ),
                            ],
                          ),
                          child: const Image(
                            image: AssetImage('assets/icons/icon-logo.jpg'),
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30,left: 5),
                      child: Text(
                        "Let's start\nyour journey",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                          fontSize: 35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  ]
                ),
                const Spacer(flex: 4),
                Flexible(
                  flex: 13,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45)),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15,bottom: 10),
                            child: Text(
                              "Welcome to our App",
                              style: GoogleFonts.roboto(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                          TextField(
                            controller: username,
                            onSubmitted:(value){
                              value.isEmpty || password.text.isEmpty?
                                  (){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please enter username and password",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );}
                                  :
                                  () {
                                context.read<AuthenticationBloc>().add(
                                    AuthenticateEvent(Username: value, Password: password.text));
                              };
                            },
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter username",
                              prefixIcon: Icon(
                                FontAwesomeIcons.userAlt,
                                size: 20,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.orange,
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: password,
                            onSubmitted:(value){
                              username.text.isEmpty || value.isEmpty?
                                  (){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Please enter username and password",
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );}
                                  :
                                  () {
                                context.read<AuthenticationBloc>().add(
                                    AuthenticateEvent(Username: username.text, Password: value));
                              };
                            },
                            textAlignVertical: TextAlignVertical.center,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: isPasswordHidden,
                            cursorColor: Colors.black,
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Enter password",
                              prefixIcon: const Icon(
                                FontAwesomeIcons.key,
                                size: 20,
                                color: Colors.black54,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  isPasswordHidden
                                      ? FontAwesomeIcons.eyeSlash
                                      : FontAwesomeIcons.eye,
                                  size: 20,
                                  color: Colors.black54,
                                ),
                                onPressed: () {
                                  setState(() {
                                    isPasswordHidden = !isPasswordHidden;
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            height: 1,
                            color: Colors.orange,
                          ),
                          const SizedBox(
                            height:10,
                          ),
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: (){
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                              ],
                            ),
                          ),
                          const Spacer(flex: 2),
                          Flexible(
                            flex: 3,
                            child: SizedBox(
                              width: 250,
                              height: 50,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                onPressed:username.text.isEmpty || password.text.isEmpty?
                                      (){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Please enter username and password",
                                            style: TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                          backgroundColor: Colors.red,
                                        ),
                                      );}
                                    :
                                      () {
                                      context.read<AuthenticationBloc>().add(
                                          AuthenticateEvent(Username: username.text, Password: password.text));
                                    },
                                child: const Text(
                                  "Sign in",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(flex: 3),
                          Flexible(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(_CreateRouteToSignUp());
                                  },
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontStyle: FontStyle.italic,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
        ),
          ),
      ),
    );
  }
  Route _CreateRouteToSignUp() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
      MultiBlocProvider(
        providers: [
          BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(),),
        ],
        child: BlocListener<RegisterBloc, RegisterInfoState>(
            listenWhen: (previous, current) => previous.registerStatus != current.registerStatus,
            listener:(context,state){
              if (state.registerStatus == RegisterStatus.Success){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Sign up success.",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.of(context).pop();
                print("listener triggered "+state.registerStatus.toString());
              }
              if (state.registerStatus == RegisterStatus.InvalidInfo){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Invalid information or policy unchecked.",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
                print("listener triggered "+state.registerStatus.toString());
              }
            },
            child: const SignUpScreen(),
        ),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}