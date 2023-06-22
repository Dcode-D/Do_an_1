import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ForgotPasswordScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
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
                Spacer(),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.55,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45)),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 15,bottom: 10),
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
                        const Text(
                          "Please enter your email address. You will receive a link to create a new password via email.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        TextField(
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.black,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter email address",
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 25,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: Colors.orange,
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: (){},
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              "Send",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}