import 'package:doan1/screens/login/signup_screens.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../app.dart';

class LoginScreen extends StatefulWidget {

  const LoginScreen({Key? key})
      : super(key: key);

  @override
  createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isPasswordHidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
                      child: Image(
                        image: AssetImage('assets/icons/icon-logo.jpg'),
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30,left: 5),
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
            Spacer(flex: 3),
            Flexible(
              flex: 10,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45)),
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
                        padding: const EdgeInsets.only(top: 15,bottom: 5),
                        child: Text(
                          "Welcome to our App",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                      TextField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.text,
                        cursorColor: Colors.black,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter username or email",
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
                      Container(
                        height:5,
                      ),
                      TextField(
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
                      SizedBox(
                        height:10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Colors.black,
                              fontStyle: FontStyle.italic,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(_CreateRouteToApp());
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
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
  Route _CreateRouteToSignUp() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const SignUpScreen(),
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

  Route _CreateRouteToApp(){
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => App(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve,
        );

        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: child,
        );
      },
    );
  }
}