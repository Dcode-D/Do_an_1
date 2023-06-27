import 'package:doan1/data/model/hotelroom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../BLOC/profile/edit_hotel/edit_hotel_item_bloc.dart';

class EditHotelRoomScreen extends StatefulWidget {
  int index;
  EditHotelRoomScreen({required this.index});

  @override
  _EditHotelRoomScreenState createState() => _EditHotelRoomScreenState();
}

class _EditHotelRoomScreenState extends State<EditHotelRoomScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController roomNumberController = TextEditingController();
  TextEditingController adultCapacityController = TextEditingController();
  TextEditingController childCapacityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController checkInHourController = TextEditingController();
  TextEditingController checkInMinuteController = TextEditingController();
  TextEditingController checkOutHourController = TextEditingController();
  TextEditingController checkOutMinuteController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var editHotelBloc = context.read<EditHotelItemBloc>();
    return SafeArea(
      child: BlocListener<EditHotelItemBloc,EditHotelItemState>(
        listenWhen: (previous, current) => current is UpdateHotelRoomState,
        listener: (context,state){
          if(state is UpdateHotelRoomState){
            if(state.updateSuccess == true){
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Update hotel room success!'),
                  ));
              Navigator.pop(context);
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Update hotel room failed!'),
                  ));
            }
          }
        },
        child: BlocBuilder<EditHotelItemBloc,EditHotelItemState>(
          bloc: editHotelBloc,

          builder: (context,state)
          {
            roomNumberController.text = editHotelBloc.listHotelRoom![widget.index].number.toString() ?? '';
            adultCapacityController.text = editHotelBloc.listHotelRoom![widget.index].adultCapacity.toString() ?? '';
            childCapacityController.text = editHotelBloc.listHotelRoom![widget.index].childrenCapacity.toString() ?? '';
            priceController.text = editHotelBloc.listHotelRoom![widget.index].price.toString();
            checkInHourController.text = editHotelBloc.listHotelRoom![widget.index].checkInHour.toString() ?? '';
            checkInMinuteController.text = editHotelBloc.listHotelRoom![widget.index].checkInMinute.toString() ?? '';
            checkOutHourController.text = editHotelBloc.listHotelRoom![widget.index].checkOutHour.toString() ?? '';
            checkOutMinuteController.text = editHotelBloc.listHotelRoom![widget.index].checkOutMinute.toString() ?? '';

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  onPressed: () => Navigator.pop(context),
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
                          HotelRoom hr = HotelRoom(
                            editHotelBloc.listHotelRoom![widget.index].id!,
                            int.parse(roomNumberController.text),
                            editHotelBloc.hotel!.id!,
                            int.parse(adultCapacityController.text),
                            int.parse(childCapacityController.text),
                            double.parse(priceController.text),
                            int.parse(checkInHourController.text),
                            int.parse(checkInMinuteController.text),
                            int.parse(checkOutHourController.text),
                            int.parse(checkOutMinuteController.text),
                          );
                          editHotelBloc.add(UpdateHotelRoomEvent(
                              index: widget.index, hotelRoom: hr));
                          editHotelBloc.add(RefreshHotelItemEvent());
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
                            Text(
                              'Hotel Name',
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              editHotelBloc.hotel == null
                                  ? ''
                                  : editHotelBloc.hotel!.name as String,
                              style: GoogleFonts.raleway(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Room number',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: roomNumberController,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Adult capacity',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: adultCapacityController,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Children capacity',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: childCapacityController,
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
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Price',
                          style: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        TextFormField(
                          controller: priceController,
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
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 110,
                          width: double.infinity,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Check in hour',
                                          style: GoogleFonts.raleway(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          controller: checkInHourController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'exp: 14',
                                            hintStyle: GoogleFonts.raleway(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Check in minute',
                                          style: GoogleFonts.raleway(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: TextFormField(
                                          controller: checkInMinuteController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'exp: 14',
                                            hintStyle: GoogleFonts.raleway(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                              ]),
                        ),
                        SizedBox(
                          height: 100,
                          width: double.infinity,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Check out hour',
                                          style: GoogleFonts.raleway(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Flexible(
                                        child: TextFormField(
                                          controller: checkOutHourController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'exp: 14',
                                            hintStyle: GoogleFonts.raleway(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter check out hour';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Check out minute',
                                          style: GoogleFonts.raleway(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            letterSpacing: 1.2,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Flexible(
                                        flex: 1,
                                        child: TextFormField(
                                          controller: checkOutMinuteController,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText: 'exp: 14',
                                            hintStyle: GoogleFonts.raleway(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.2,
                                              color:
                                                  Colors.black.withOpacity(0.5),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter check out minute';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}