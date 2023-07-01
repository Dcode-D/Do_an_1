import 'package:doan1/Utils/image_pick_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../BLOC/profile/edit_hotel/edit_hotel_item_bloc.dart';
import '../../create_hotel_room_screen.dart';
import 'edit_hotel_room_screen.dart';

class EditHotelScreen extends StatefulWidget {
  @override
  _EditHotelScreenState createState() => _EditHotelScreenState();
}

class _EditHotelScreenState extends State<EditHotelScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final editHotelItemBloc = BlocProvider.of<EditHotelItemBloc>(context);
    final nameController = TextEditingController();
    final addressController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final provinceController = TextEditingController();
    final cityController = TextEditingController();
    final facilitiesController = TextEditingController();
    final formatCurrency = NumberFormat("#,###");

    NavigateToCreateHotelRoom(){
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CreateHotelRoomScreen(hotelId: editHotelItemBloc.hotel!.id!),
        ),
      );
    };

    return BlocListener<EditHotelItemBloc, EditHotelItemState>(
          listenWhen: (previous, current) {
            if (current is EditHotelResult || current is DeleteHotelRoomState) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if((state as EditHotelResult).success){
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.green,
                      content: Text('Edit hotel success!'),
                    ));
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Edit hotel failed!'),
                  ));
            }
            if((state as DeleteHotelItemState).deleteSuccess == true){
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text('Delete hotel room success!'),
                  ));
            }
            else if((state as DeleteHotelItemState).deleteSuccess == false){
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text('Delete hotel room failed!'),
                  ));
            }
          },
          child: SafeArea(
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
                  'Edit hotel',
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.black,
                  ),
                ),
                //save changes to hotel info
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: IconButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          editHotelItemBloc.add(SaveHotelInfoEvent(
                              name: nameController.text,
                              address: addressController.text,
                              description: descriptionController.text,
                              facilities: facilitiesController.text));
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
              body: BlocBuilder<EditHotelItemBloc, EditHotelItemState>(
                buildWhen: (previous, current) {
                  if (current is EditHotelItemLoaded) {
                    return true;
                  }
                  return false;
                },
                builder: (context, state) {
                  nameController.text = editHotelItemBloc.hotel!.name ?? '';
                  addressController.text = editHotelItemBloc.hotel!.address ?? '';
                  descriptionController.text =
                      editHotelItemBloc.hotel!.description ?? '';
                  priceController.text = (editHotelItemBloc.hotel!.maxPrice != null &&
                          editHotelItemBloc.hotel!.minPrice != null)
                      ? '${editHotelItemBloc.hotel!.minPrice} - ${editHotelItemBloc.hotel!.maxPrice}'
                      : '';
                  provinceController.text = editHotelItemBloc.hotel!.province ?? '';
                  cityController.text = editHotelItemBloc.hotel!.city ?? '';
                  facilitiesController.text = '';
                  for(var facility in editHotelItemBloc.hotel!.facilities!){
                    if(facility.isNotEmpty) {
                      facilitiesController.text += '$facility, ';
                    }
                  }
                  return !(state as EditHotelItemLoaded).loading
                      ? Form(
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Type of Service',
                                              style: GoogleFonts.raleway(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.2,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.44,
                                                height: 30,
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color:
                                                        Colors.black.withOpacity(0.2),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Hotel',
                                                  style: GoogleFonts.raleway(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: 1.2,
                                                    color: Colors.black,
                                                  ),
                                                )),
                                          ],
                                        ),
                                        //add photos to hotel
                                        const Spacer(),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                showGeneralDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    barrierLabel:
                                                    MaterialLocalizations.of(context)
                                                        .modalBarrierDismissLabel,
                                                    barrierColor: Colors.black54,
                                                    transitionDuration:
                                                    const Duration(milliseconds: 400),
                                                    transitionBuilder:
                                                        (context, anim1, anim2, child) {
                                                      return SlideTransition(
                                                        position: Tween(
                                                            begin: const Offset(0, 1),
                                                            end: const Offset(0, 0.2))
                                                            .animate(anim1),
                                                        child: child,
                                                      );
                                                    },
                                                    pageBuilder: (context, _, __) {
                                                      return
                                                      BlocProvider<
                                                          EditHotelItemBloc>.value(
                                                        value: editHotelItemBloc,
                                                        child: BlocBuilder<
                                                            EditHotelItemBloc,
                                                            EditHotelItemState>(
                                                          buildWhen: (
                                                              previous,
                                                              current) {
                                                            return current is EditHotelItemLoaded;
                                                          },
                                                          builder:
                                                              (context,
                                                              state) {
                                                            return
                                                              state is EditHotelItemLoaded
                                                                  ?
                                                              Container(
                                                                decoration: const BoxDecoration(
                                                                  borderRadius: BorderRadius
                                                                      .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                        10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                        10),
                                                                  ),
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                                child: Column(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal: 15.0),
                                                                      child: Row(
                                                                        children: [
                                                                          Text(
                                                                            'List of rooms',
                                                                            style: GoogleFonts
                                                                                .raleway(
                                                                              fontSize: 18,
                                                                              fontWeight: FontWeight
                                                                                  .w400,
                                                                              letterSpacing: 1.2,
                                                                              color: Colors
                                                                                  .black,
                                                                            ),
                                                                          ),
                                                                          const Spacer(),
                                                                          IconButton(
                                                                            onPressed: () {
                                                                              SmartDialog
                                                                                  .dismiss();
                                                                              NavigateToCreateHotelRoom();
                                                                            },
                                                                            icon: const Icon(
                                                                              Icons
                                                                                  .add,
                                                                              color: Colors
                                                                                  .orange,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Expanded(
                                                                      child: ListView
                                                                          .builder(
                                                                        padding: EdgeInsets.zero,
                                                                        shrinkWrap: true,
                                                                        itemCount:
                                                                        editHotelItemBloc
                                                                            .listHotelRoom!
                                                                            .length,
                                                                        itemBuilder:
                                                                            (
                                                                            context,
                                                                            index) {
                                                                          return ListTile(
                                                                            leading:
                                                                            Column(
                                                                                mainAxisAlignment: MainAxisAlignment
                                                                                    .center,
                                                                                children: [
                                                                                  Text(
                                                                                      "Room ${editHotelItemBloc
                                                                                          .listHotelRoom![index]
                                                                                          .number}")
                                                                                ]),
                                                                            title: Text(
                                                                                "Price: ${formatCurrency.format(editHotelItemBloc
                                                                                    .listHotelRoom![index]
                                                                                    .price)} vnđ"),
                                                                            subtitle:
                                                                            Text(
                                                                                "Adults: ${editHotelItemBloc
                                                                                    .listHotelRoom![index]
                                                                                    .adultCapacity} Children: ${editHotelItemBloc
                                                                                    .listHotelRoom![index]
                                                                                    .childrenCapacity}"),
                                                                            trailing: Wrap(
                                                                              spacing: 10,
                                                                              children: [

                                                                                IconButton(onPressed: (){
                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                                                                      BlocProvider.value(
                                                                                        value: editHotelItemBloc,
                                                                                          child: EditHotelRoomScreen(index: index,))));
                                                                                }, icon: const Icon(FontAwesomeIcons.edit,
                                                                                  color: Colors.orange,)),

                                                                                IconButton(
                                                                                  onPressed: () {
                                                                                    editHotelItemBloc.add(
                                                                                      DeleteHotelRoomEvent(index),
                                                                                    );
                                                                                    editHotelItemBloc.add(
                                                                                        RefreshHotelItemEvent()
                                                                                    );
                                                                                  },
                                                                                  icon: const Icon(
                                                                                    Icons
                                                                                        .delete,
                                                                                    color: Colors
                                                                                        .red,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                                  : Padding(
                                                                    padding: const EdgeInsets.only(top:25),
                                                                    child: Container(
                                                                    height:
                                                                    MediaQuery
                                                                        .of(
                                                                        context)
                                                                        .size
                                                                        .height *
                                                                        0.8,
                                                                    decoration: const BoxDecoration(
                                                                      borderRadius: BorderRadius
                                                                          .only(
                                                                          topLeft: Radius
                                                                              .circular(
                                                                              10),
                                                                          topRight: Radius
                                                                              .circular(
                                                                              10)),
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    child: const Center(
                                                                      child: Text(
                                                                          "No hotel room added!"),)),
                                                                  );
                                                          },
                                                        ),
                                                      );
                                                    });
                                                },
                                              icon: const Icon(
                                                FontAwesomeIcons.listCheck,
                                                color: Colors.orange,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                showDialog(context: context, builder:
                                                (context)=>
                                                    AlertDialog(
                                                      title: const Text('Select Image Source'),
                                                      content: SingleChildScrollView(
                                                        child: ListBody(
                                                          children: [
                                                            GestureDetector(
                                                              child: const Text('Take a photo'),
                                                              onTap: () async {
                                                                Navigator.pop(context);
                                                                editHotelItemBloc.add(AddImageEvent(ImagePickMethod.CAMERA));
                                                              },
                                                            ),
                                                            const Padding(padding: EdgeInsets.all(8.0)),
                                                            GestureDetector(
                                                              child: const Text('Choose from gallery'),
                                                              onTap: () async {
                                                                Navigator.pop(context);
                                                                editHotelItemBloc.add(AddImageEvent(ImagePickMethod.GALLERY));
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.add_a_photo,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Hotel Name',
                                          style: GoogleFonts.raleway(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: nameController,
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Images of your hotel',
                                          style: GoogleFonts.raleway(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.italic,
                                            letterSpacing: 1.2,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SingleChildScrollView(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Colors.black.withOpacity(0.2),
                                              ),
                                            ),
                                            child: SizedBox(
                                              height: 250,
                                              child: editHotelItemBloc.hotel != null
                                                  ? GridView.builder(
                                                    padding: const EdgeInsets.all(10),
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 8.0,
                                                        mainAxisSpacing: 8.0,
                                                      ),
                                                      itemCount: editHotelItemBloc
                                                          .hotel!.images!.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Stack(children: [
                                                          SizedBox(
                                                            width: 100,
                                                            height: 100,
                                                            child: Image.network(
                                                              editHotelItemBloc
                                                                  .images![index],
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (context,
                                                                  error, stackTrace) {
                                                                return Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                                  5),
                                                                      border:
                                                                          Border.all(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.2),
                                                                      ),
                                                                    ),
                                                                    child: const Icon(
                                                                        Icons.error));
                                                              },
                                                            ),
                                                          ),
                                                          Positioned(
                                                            top: -15,
                                                            right: -10,
                                                            child: IconButton(
                                                              onPressed: () {
                                                                //Show delete dialog
                                                                showDialog(
                                                                    context: context,
                                                                    builder:
                                                                        (context) =>
                                                                            AlertDialog(
                                                                              title: Text(
                                                                                  'Delete Picture'),
                                                                              content: Text(
                                                                                  'Are you sure you to delete this picture?'),
                                                                              actions: [
                                                                                TextButton(
                                                                                  child:
                                                                                      Text('Cancel'),
                                                                                  onPressed:
                                                                                      () {
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                ),
                                                                                ElevatedButton(
                                                                                  style:
                                                                                      ButtonStyle(
                                                                                    backgroundColor:
                                                                                        MaterialStateProperty.all(Colors.orange),
                                                                                  ),
                                                                                  child:
                                                                                      Text('Delete'),
                                                                                  onPressed:
                                                                                      () {
                                                                                    editHotelItemBloc.add(DeleteHotelImageEvent(index));
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                ),
                                                                              ],
                                                                            ));
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .highlight_remove_sharp,
                                                                color: Colors.red,
                                                              ),
                                                            ),
                                                          )
                                                        ]);
                                                      },
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(5),
                                                        border: Border.all(
                                                          color: Colors.black
                                                              .withOpacity(0.2),
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                        //TODO: add list of hotel Room to manege and edit

                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Address',
                                          style: GoogleFonts.raleway(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: addressController,
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Province',
                                          style: GoogleFonts.raleway(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextField(
                                          controller: provinceController,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              FontAwesomeIcons.mapMarkerAlt,
                                              color: Colors.black45,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'City',
                                          style: GoogleFonts.raleway(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: cityController,
                                          enabled: false,
                                          decoration: InputDecoration(
                                            prefixIcon: const Icon(
                                              FontAwesomeIcons.mapMarkerAlt,
                                              color: Colors.black45,
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Facilities',
                                          style: GoogleFonts.raleway(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: facilitiesController,
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Description',
                                          style: GoogleFonts.raleway(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color: Colors.black,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        TextFormField(
                                          controller: descriptionController,
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
                                        const SizedBox(
                                          height: 10,
                                        ),
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ),
          ),
        );
  }
}
