import 'package:doan1/BLOC/hotel_rooms/create_hotel_rooms_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../data/model/hotelroom.dart';

class CreateHotelRoomScreen extends StatefulWidget {
  final String hotelId;

  const CreateHotelRoomScreen({Key? key, required this.hotelId})
      : super(key: key);

  @override
  _CreateHotelRoomScreenState createState() => _CreateHotelRoomScreenState();
}

class _CreateHotelRoomScreenState extends State<CreateHotelRoomScreen> {
  final _formKey = GlobalKey<FormState>();
  final roomNumberController = TextEditingController();
  final adultNumberController = TextEditingController();
  final childrenNumberController = TextEditingController();
  final priceController = TextEditingController();
  final checkInHrController = TextEditingController();
  final checkOutHrController = TextEditingController();
  final checkInMinController = TextEditingController();
  final checkOutMinController = TextEditingController();
  final formatCurrency = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CreateHotelRoomsBloc(),
      child: Builder(builder: (context) {
        context
            .read<CreateHotelRoomsBloc>()
            .add(CreateHotelRoomsInitialHotelEvent(widget.hotelId));

        //copy events and post result are handled here
        return BlocListener<CreateHotelRoomsBloc, CreateHotelRoomsState>(
          listenWhen: (previous, current) {
            return current is CreateHotelRoomsSuccessState ||
                current is CreateHotelRoomsCopyState;
          },
          listener: (context, state) {
            if (state is CreateHotelRoomsSuccessState) {
              if(state.isloading){
                SmartDialog.showLoading(msg: "Posting...");
              }
              else{
                SmartDialog.dismiss();
                if (state.isSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Create hotel rooms succeeded!"),
                    ),
                  );
                  Navigator.of(context).popUntil((route) => route.isFirst);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("Failed to create hotel room!"),
                    ),
                  );
                }
              }
            }
            if (state is CreateHotelRoomsCopyState) {
              roomNumberController.text = state.hotelRoom.number.toString();
              adultNumberController.text = state.hotelRoom.adultCapacity.toString();
              childrenNumberController.text = state.hotelRoom.childrenCapacity.toString();
              priceController.text = state.hotelRoom.price.toString();
              checkInHrController.text = state.hotelRoom.checkInHour.toString();
              checkOutHrController.text = state.hotelRoom.checkOutHour.toString();
              checkInMinController.text = state.hotelRoom.checkOutHour.toString();
              checkOutMinController.text = state.hotelRoom.checkOutMinute.toString();
            }
          },

          child: BlocBuilder<CreateHotelRoomsBloc, CreateHotelRoomsState>(
            buildWhen: (previous, current) {
              return current is CreateHotelRoomsReadyState;
            },
            builder: (context, state) {
              return SafeArea(
                child: Scaffold(
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
                        'Create hotel room',
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
                              if(context.read<CreateHotelRoomsBloc>().hotelRooms.isNotEmpty) {
                                context.read<CreateHotelRoomsBloc>().add(
                                    CreateHotelRoomsPostEvent());
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Please add at least 1 room!"),
                                  ),
                                );
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
                    body: (state is! CreateHotelRoomsReadyState)
                        ? const Center(
                            child: Text("No information!"),
                          )
                        : (!state.isloading)
                            ? (state.isready)
                                ? Form(
                                    key: _formKey,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 0, 10, 0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BlocBuilder<CreateHotelRoomsBloc,
                                                CreateHotelRoomsState>(
                                              buildWhen: (previous, current) {
                                                return current
                                                    is CreateHotelRoomsListRoomsChangedState;
                                              },
                                              builder: (context, state) {
                                                final length = context
                                                    .read<
                                                        CreateHotelRoomsBloc>()
                                                    .hotelRooms
                                                    .length
                                                    .toString();
                                                return Row(
                                                  children: [
                                                    Text(
                                                      "Hotel rooms list($length)",
                                                      style:
                                                          GoogleFonts.raleway(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        letterSpacing: 1.2,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    const Spacer(),

                                                    //Show list all hotel rooms
                                                    TextButton(
                                                        onPressed: () {
                                                          final createBloc =
                                                              context.read<CreateHotelRoomsBloc>();
                                                          SmartDialog.show(
                                                            alignment: Alignment.bottomCenter,
                                                              builder: (context) =>
                                                                  BlocProvider<CreateHotelRoomsBloc>.value(
                                                                    value: createBloc,
                                                                    child: Builder(
                                                                      builder: (context) {
                                                                        return BlocBuilder<CreateHotelRoomsBloc, CreateHotelRoomsState>(
                                                                          buildWhen: (previous, current) {
                                                                            return current is CreateHotelRoomsListRoomsChangedState;
                                                                          },
                                                                          builder:
                                                                              (context, state) {
                                                                            return
                                                                            state is CreateHotelRoomsListRoomsChangedState
                                                                                ?
                                                                              Container(
                                                                              decoration: const BoxDecoration(
                                                                                borderRadius: BorderRadius.only(
                                                                                  topLeft: Radius.circular(10),
                                                                                  topRight: Radius.circular(10),
                                                                                ),
                                                                                color: Colors.white,
                                                                              ),
                                                                              child: SingleChildScrollView(
                                                                                child: SizedBox(
                                                                                  height:
                                                                                      MediaQuery.of(context).size.height * 0.8,
                                                                                  child:
                                                                                      ListView.builder(
                                                                                    itemCount:
                                                                                        context.read<CreateHotelRoomsBloc>().hotelRooms.length,
                                                                                    itemBuilder:
                                                                                        (context, index) {
                                                                                      return ListTile(
                                                                                        leading:
                                                                                            Column(
                                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                                children: [Text("Room ${createBloc.hotelRooms[index].number}")])
                                                                                        ,
                                                                                        title: Text("Price: ${formatCurrency.format(context.read<CreateHotelRoomsBloc>().hotelRooms[index].price)} vnđ"),
                                                                                        subtitle:
                                                                                        Text("Adults: ${context.read<CreateHotelRoomsBloc>().hotelRooms[index].adultCapacity} Children: ${context.read<CreateHotelRoomsBloc>().hotelRooms[index].childrenCapacity}"),
                                                                                        trailing: Wrap(
                                                                                          spacing: 10,
                                                                                          children: [

                                                                                            IconButton(onPressed: (){
                                                                                              createBloc.add(CreateHotelRoomsCopyEvent(createBloc.hotelRooms[index]));
                                                                                            }, icon: const Icon(Icons.copy,
                                                                                              color: Colors.orange,)),

                                                                                            IconButton(
                                                                                              onPressed: () {
                                                                                                context.read<CreateHotelRoomsBloc>().add(CreateHotelRoomsRemoveRoomEvent(context.read<CreateHotelRoomsBloc>().hotelRooms[index]));
                                                                                              },
                                                                                              icon: const Icon(
                                                                                                Icons.delete,
                                                                                                color: Colors.red,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ) : Container(
                                                                                height:
                                                                                MediaQuery.of(context).size.height * 0.8,
                                                                                decoration: const BoxDecoration(
                                                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                                                                  color: Colors.white,
                                                                                ),
                                                                                child: const Center(child: Text("No hotel room added!"),));
                                                                          },
                                                                        );
                                                                      }
                                                                    ),
                                                                  ));
                                                        },

                                                        child: const Text(
                                                          "See all",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.orange,
                                                              fontSize: 15),
                                                        ))
                                                  ],
                                                );
                                              },
                                            ),

                                            Row(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Hotel Name',
                                                      style:
                                                          GoogleFonts.raleway(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: 1.2,
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      context
                                                              .read<
                                                                  CreateHotelRoomsBloc>()
                                                              .hotel!
                                                              .name ??
                                                          "",
                                                      style:
                                                          GoogleFonts.raleway(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        letterSpacing: 1.2,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const Spacer(),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                      final intRoomNumber =
                                                          int.parse(
                                                              roomNumberController
                                                                  .text);
                                                      final intAdultNumber =
                                                          int.parse(
                                                              adultNumberController
                                                                  .text);
                                                      final intChildrenNumber =
                                                          int.parse(
                                                              childrenNumberController
                                                                  .text);
                                                      final doublePrice =
                                                          double.parse(
                                                              priceController
                                                                  .text);
                                                      final intCheckInHr =
                                                          int.parse(
                                                              checkInHrController
                                                                  .text);
                                                      final intCheckOutHr =
                                                          int.parse(
                                                              checkOutHrController
                                                                  .text);
                                                      final intCheckInMin =
                                                          int.parse(
                                                              checkInMinController
                                                                  .text);
                                                      final intCheckOutMin =
                                                          int.parse(
                                                              checkOutMinController
                                                                  .text);
                                                      final hotelroom =
                                                          HotelRoom(
                                                        null,
                                                        intRoomNumber,
                                                        widget.hotelId,
                                                        intAdultNumber,
                                                        intChildrenNumber,
                                                        doublePrice,
                                                        intCheckInHr,
                                                        intCheckInMin,
                                                        intCheckOutHr,
                                                        intCheckOutMin,
                                                      );
                                                      context
                                                          .read<
                                                              CreateHotelRoomsBloc>()
                                                          .add(
                                                              CreateHotelRoomsAddRoomEvent(
                                                                  hotelroom));
                                                    }
                                                  },
                                                  child: Text(
                                                    'Add room',
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 1.2,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),

                                            const SizedBox(
                                              height: 10,
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
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller: roomNumberController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: 'Room number',
                                                hintStyle: GoogleFonts.raleway(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.2,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller: adultNumberController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: 'Adult capacity',
                                                hintStyle: GoogleFonts.raleway(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.2,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  childrenNumberController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: 'Children capacity',
                                                hintStyle: GoogleFonts.raleway(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.2,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller: priceController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: 'Price',
                                                hintStyle: GoogleFonts.raleway(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 1.2,
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              'Check in hour',
                                                              style: GoogleFonts
                                                                  .raleway(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                letterSpacing:
                                                                    1.2,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Flexible(
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  checkInHrController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'exp: 14',
                                                                hintStyle:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  letterSpacing:
                                                                      1.2,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Please enter check in hour';
                                                                }
                                                                if (int.parse(
                                                                            value) >
                                                                        23 ||
                                                                    int.parse(
                                                                            value) <
                                                                        0) {
                                                                  return 'Please enter valid check in hour';
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              'Check in minute',
                                                              style: GoogleFonts
                                                                  .raleway(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                letterSpacing:
                                                                    1.2,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Flexible(
                                                            flex: 1,
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  checkInMinController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'exp: 14',
                                                                hintStyle:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  letterSpacing:
                                                                      1.2,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Please enter check in minute';
                                                                }
                                                                if (int.parse(
                                                                            value) >
                                                                        59 ||
                                                                    int.parse(
                                                                            value) <
                                                                        0) {
                                                                  return 'Please enter valid minute';
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Flexible(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              'Check out hour',
                                                              style: GoogleFonts
                                                                  .raleway(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                letterSpacing:
                                                                    1.2,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Flexible(
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  checkOutHrController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'exp: 14',
                                                                hintStyle:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  letterSpacing:
                                                                      1.2,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Please enter check out hour';
                                                                }
                                                                if (int.parse(
                                                                            value) >
                                                                        23 ||
                                                                    int.parse(
                                                                            value) <
                                                                        0) {
                                                                  return 'Please enter valid hour';
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Flexible(
                                                            child: Text(
                                                              'Check out minute',
                                                              style: GoogleFonts
                                                                  .raleway(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                letterSpacing:
                                                                    1.2,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Flexible(
                                                            flex: 1,
                                                            child:
                                                                TextFormField(
                                                              controller:
                                                                  checkOutMinController,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'exp: 14',
                                                                hintStyle:
                                                                    GoogleFonts
                                                                        .raleway(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  letterSpacing:
                                                                      1.2,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5),
                                                                ),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                              ),
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Please enter check out minute';
                                                                }
                                                                if (int.parse(
                                                                            value) >
                                                                        59 ||
                                                                    int.parse(
                                                                            value) <
                                                                        0) {
                                                                  return 'Please enter valid minute';
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
                                  )
                                : const Center(child: Text("No data found"))
                            : const Center(child: CircularProgressIndicator())),
              );
            },
          ),
        );
      }),
    );
  }
}
