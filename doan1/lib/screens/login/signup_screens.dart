import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({Key? key})
      : super(key: key);

  @override
  createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var isPasswordHidden = true;
  var isPasswordHidden1 = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: Image(
                          image: AssetImage('assets/icons/icon-logo.jpg'),
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35,left: 5),
                    child: Text(
                      "Let's start\nyour journey",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(flex:3),
              Flexible(
                flex:25,
                child: Container(
                  width: double.infinity,
                  height: 520,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45)),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:20,left: 30),
                        child: Row(
                          children: [
                            const Text(
                              "New\naccount",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Roboto',
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: (){
                                //TODO: Implement add photo for profile
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: const Offset(0, 6)
                                    ),]
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Center(
                                      child: Image(
                                        image: AssetImage('assets/icons/icon-camera.png'),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20,)
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10,left:20, right: 20),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter email",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 30,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20, right: 20),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left:20, right: 20),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter username",
                            prefixIcon: Icon(
                              Icons.person_outline,
                              size: 30,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20, right: 20),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left:20, right: 20),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isPasswordHidden,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20, right: 20),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left:20, right: 20),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isPasswordHidden1,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Confirm password",
                            prefixIcon: const Icon(
                              Icons.library_add_check,
                              size: 20,
                              color: Colors.black54,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                isPasswordHidden1
                                    ? FontAwesomeIcons.eyeSlash
                                    : FontAwesomeIcons.eye,
                                size: 20,
                                color: Colors.black54,
                              ),
                              onPressed: () {
                                setState(() {
                                  isPasswordHidden1 = !isPasswordHidden1;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20, right: 20),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.only(left:20, right: 20),
                        child: TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.phone,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter phone number",
                            prefixIcon: Icon(
                              Icons.phone_android_outlined,
                              size: 30,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:20, right: 20),
                        child: Container(
                          width: double.infinity,
                          height: 1,
                          color: Colors.orange,
                        ),
                      ),
                      const Spacer(flex: 1,),
                      Flexible(
                        flex: 2,
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
                            onPressed: () {
                              
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ])
    ),
      )
    );
  }
}

