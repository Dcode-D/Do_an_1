import 'package:doan1/BLOC/register/register_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatefulWidget {

  const SignUpScreen({Key? key})
      : super(key: key);

  @override
  createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var isPasswordHidden = true;
  var isPasswordConfirmHidden = true;
  var isPolicyChecked = false;

  final _emailController = TextEditingController();
  final _firstnameController = TextEditingController();
  final _lastnameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  final _phoneController = TextEditingController();

  final List<String> genders = [
    'Male',
    'Female',
  ];
  final _formKey = GlobalKey<FormState>();
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<RegisterBloc,RegisterInfoState>(
          builder: (context,state) => Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login-wallpaper.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
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
                          padding: EdgeInsets.only(top: 35,left: 5),
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
                    const SizedBox(height: 50,),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(45),topRight: Radius.circular(45)),
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10,left:20, right: 20),
                            child: TextFormField(
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              controller: _emailController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                              decoration: const InputDecoration(
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
                            padding: const EdgeInsets.only(left: 30,right: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    controller: _firstnameController,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Please enter your first name';
                                      }
                                      return null;
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "First Name",
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20,),
                                Flexible(
                                  child: TextFormField(
                                    controller: _lastnameController,
                                    validator: (value){
                                      if(value!.isEmpty){
                                        return 'Please enter your last name';
                                      }
                                      return null;
                                    },
                                    textAlignVertical: TextAlignVertical.center,
                                    keyboardType: TextInputType.text,
                                    cursorColor: Colors.black,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Last Name",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left:20, right: 20),
                            child: Row(
                              children: [
                                Container(
                                  width: 150,
                                  height: 1,
                                  color: Colors.orange,
                                ),
                                const SizedBox(width: 35,),
                                Container(
                                  width: 165,
                                  height: 1,
                                  color: Colors.orange,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height:10,),
                          Padding(
                            padding: const EdgeInsets.only(left:30, right: 20),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2(
                                isExpanded: true,
                                hint: Text(
                                  'Select Gender',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: genders
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ))
                                    .toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value as String;
                                  });
                                },
                                buttonStyleData: const ButtonStyleData(
                                  height: 25,
                                  width: double.infinity,
                                ),
                                menuItemStyleData: const MenuItemStyleData(
                                  height: 40,
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
                          const SizedBox(height:10,),
                          Padding(
                            padding: const EdgeInsets.only(left:20, right: 20),
                            child: TextFormField(
                              controller: _usernameController,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please enter your username';
                                }
                                return null;
                              },
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
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left:20, right: 20),
                            child: TextFormField(
                              controller: _passwordController,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please enter your password';
                                }
                                else if (value.isNotEmpty && value.length < 8){
                                  return 'Password must be at least 8 characters';
                                }
                                return null;
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
                          const SizedBox(height: 10,),
                          Padding(
                            padding: const EdgeInsets.only(left:20, right: 20),
                            child: TextFormField(
                              controller: _passwordConfirmController,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please confirm your password';
                                }
                                else if (value.isNotEmpty && value.length < 8){
                                  return 'Password must be at least 8 characters';
                                }
                                else if (value != _passwordController.text){
                                  return 'Password does not match';
                                }
                                return null;
                              },
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.visiblePassword,
                              obscureText: isPasswordConfirmHidden,
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
                                    isPasswordConfirmHidden
                                        ? FontAwesomeIcons.eyeSlash
                                        : FontAwesomeIcons.eye,
                                    size: 20,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      isPasswordConfirmHidden = !isPasswordConfirmHidden;
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
                            child: TextFormField(
                              controller: _phoneController,
                              validator: (value){
                                if(value!.isEmpty){
                                  return 'Please enter your phone number';
                                }
                                else if (value.isNotEmpty && value.length < 10){
                                  return 'Phone number must be at least 10 characters';
                                }
                                else if (value.isNotEmpty && value.length > 10){
                                  return 'Phone number must be at most 10 characters';
                                }
                                return null;
                              },
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
                          const SizedBox(height: 15,),
                          Row(
                            children: [
                              const SizedBox(width: 20,),
                              Checkbox(
                                value: isPolicyChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isPolicyChecked = value!;
                                  });
                                },
                              ),
                              const Text(
                                "I agree with our terms and policy.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.grey,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.orange,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: () {
                                      isPolicyChecked || (_passwordController.text != _passwordConfirmController.text) || selectedValue == '' ?
                                      {
                                          if (_formKey.currentState!.validate()) {
                                            context.read<RegisterBloc>().add(
                                              RegisterEvent(
                                                  Username: _usernameController.text,
                                                  Password: _passwordController.text,
                                                  Email: _emailController.text,
                                                  FirstName: _firstnameController.text,
                                                  LastName: _lastnameController.text,
                                                  Phone: _phoneController.text,
                                                  Gender: ChangeGenderValue(selectedValue))
                                          ),
                                            _formKey.currentState!.save()
                                          }
                                      }
                                      :null;
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
                              ],
                            ),
                          ),
                          const SizedBox(height: 10,),
                        ],
                      ),
                    ),
                 ]),
              )
      ),
          ),
        )
      ),
    );
  }
  int ChangeGenderValue(String? selectedValue){
    return selectedValue == 'Male' ? 1 : 0;
  }
}

