import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EditHotelRoomScreen extends StatefulWidget {
  const EditHotelRoomScreen({Key? key}) : super(key: key);

  @override
  _EditHotelRoomScreenState createState() => _EditHotelRoomScreenState();
}

class _EditHotelRoomScreenState extends State<EditHotelRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () =>
              Navigator.pop(context)
          ,
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Edit hotel room',
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
                FontAwesomeIcons.check,
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
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Hotel Name',
                      style: GoogleFonts.raleway(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: Colors.black.withOpacity(0.5),
                      ),),
                    const SizedBox(height: 5,),
                    Text(
                      'Khách sạn 1',
                      style: GoogleFonts.raleway(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.2,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10,),
                //TODO: Add list of room if we added to hotel
                const SizedBox(height: 10,),
                Text('Room number',
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.black.withOpacity(0.5),
                  ),),
                const SizedBox(height: 5,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Room number',
                    hintStyle: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter room number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                Text('Adult capacity',
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.black.withOpacity(0.5),
                  ),),
                const SizedBox(height: 5,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Adult capacity',
                    hintStyle: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter adult capacity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                Text('Children capacity',
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.black.withOpacity(0.5),
                  ),),
                const SizedBox(height: 5,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Children capacity',
                    hintStyle: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter children capacity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                Text('Price',
                  style: GoogleFonts.raleway(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.black.withOpacity(0.5),
                  ),),
                const SizedBox(height: 5,),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Price',
                    hintStyle: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter price';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 110,
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text('Check in hour',
                                  style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                    color: Colors.black.withOpacity(0.5),
                                  ),),
                              ),
                              const SizedBox(height: 5,),
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'exp: 14',
                                    hintStyle: GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter check in hour';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text('Check in minute',
                                  style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                    color: Colors.black.withOpacity(0.5),
                                  ),),
                              ),
                              const SizedBox(height: 5,),
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'exp: 14',
                                    hintStyle: GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter check in minute';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ]
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text('Check in hour',
                                  style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                    color: Colors.black.withOpacity(0.5),
                                  ),),
                              ),
                              const SizedBox(height: 5,),
                              Flexible(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'exp: 14',
                                    hintStyle: GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter check in hour';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text('Check in minute',
                                  style: GoogleFonts.raleway(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.2,
                                    color: Colors.black.withOpacity(0.5),
                                  ),),
                              ),
                              const SizedBox(height: 5,),
                              Flexible(
                                flex: 1,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'exp: 14',
                                    hintStyle: GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.2,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter check in minute';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}