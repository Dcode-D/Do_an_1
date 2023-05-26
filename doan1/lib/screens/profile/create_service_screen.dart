import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/destination_model.dart';

class CreateServiceScreen extends StatefulWidget {
  const CreateServiceScreen({Key? key}) : super(key: key);

  @override
  _CreateServiceScreenState createState() => _CreateServiceScreenState();
}

class _CreateServiceScreenState extends State<CreateServiceScreen> {
  final List<String> ServiceTypes = [
    'Hotel',
    'Vehicle',
  ];

  String? selectedValue;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
            'Create Service',
            style: GoogleFonts.raleway(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: Colors.black,
            ),
          ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }
              },
              icon: const Icon(
                FontAwesomeIcons.add,
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Type of Service',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.44,
                          height: 48,
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            isExpanded: true,
                            hint: const Text(
                              'Select type of post',
                              style: TextStyle(fontSize: 14),
                            ),
                            items: ServiceTypes
                                .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Please select type of post';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedValue = value.toString();
                              });
                            },
                            onSaved: (value) {
                              selectedValue = value.toString();
                            },
                            buttonStyleData: const ButtonStyleData(
                              height: 30,
                            ),
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down,
                                color: Colors.black45,
                              ),
                              iconSize: 30,
                            ),
                            dropdownStyleData: DropdownStyleData(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                        ),
                    ],),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.add_a_photo,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                selectedValue == 'Hotel' ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Hotel Name',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.hotel,
                              color: Colors.black45,
                            ),
                            hintText: 'Enter hotel name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter hotel name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        Text('Please add some images of your hotel',
                          style: GoogleFonts.raleway(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1.2,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: destinationList[0].images.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.asset(
                                destinationList[0].images[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          'Hotel price',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          initialValue:' / Night',
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.dollarSign,
                              color: Colors.black45,
                            ),
                            hintText: 'Enter hotel price',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter hotel price';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        Text('Hotel Address',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.black45,
                            ),
                            hintText: 'Enter hotel address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter hotel address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        Text('Hotel Facilities',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.hotel,
                              color: Colors.black45,
                            ),
                            hintText: 'Enter hotel facilities',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter hotel facilities';
                            }
                            return null;
                          },
                        ),
                        Text(
                          'Each facility should be separated by a comma',
                          style: GoogleFonts.raleway(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1.2,
                            color: Colors.orange,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text('Hotel Description',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Enter hotel description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter hotel description';
                            }
                            return null;
                          },
                        ),
                      ],
                    ) : const SizedBox(),
                selectedValue == 'Vehicle' ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Vehicle name',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.car,
                              color: Colors.black45,
                            ),
                            hintText: 'Enter vehicle name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter vehicle name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        Text('Please add some images of your vehicle',
                          style: GoogleFonts.raleway(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1.2,
                            color: Colors.orange,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 8.0,
                            ),
                            itemCount: destinationList[0].images.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.asset(
                                destinationList[0].images[index],
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Text(
                          'Vehicle price',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          initialValue:' / Day',
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.dollarSign,
                              color: Colors.black45,
                            ),
                            hintText: 'Enter vehicle price',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter vehicle price';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        Text('Vehicle Address',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              FontAwesomeIcons.mapMarkerAlt,
                              color: Colors.black45,
                            ),
                            hintText: 'Enter vehicle address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter vehicle address';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10,),
                        Text('Vehicle Description',
                          style: GoogleFonts.raleway(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        TextFormField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Enter vehicle description',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter vehicle description';
                            }
                            return null;
                          },
                        ),
                      ],
                    ) : const SizedBox(),
              ]),
          ),
        ),
      )
    );
  }
}