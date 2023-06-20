import 'package:doan1/Utils/image_pick_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../BLOC/profile/edit_hotel/edit_hotel_item_bloc.dart';
import '../../../../../models/destination_model.dart';

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
    return BlocListener<EditHotelItemBloc, EditHotelItemState>(
      listenWhen: (previous, current) {
        if (current is EditHotelResult) {
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
      },
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
              if(facility.isNotEmpty)
                facilitiesController.text += '$facility, ';
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
                                  IconButton(
                                    onPressed: () {
                                      showDialog(context: context, builder:
                                      (context)=>
                                          AlertDialog(
                                            title: Text('Select Image Source'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  GestureDetector(
                                                    child: Text('Take a photo'),
                                                    onTap: () async {
                                                      Navigator.pop(context);
                                                      editHotelItemBloc.add(AddImageEvent(ImagePickMethod.CAMERA));
                                                    },
                                                  ),
                                                  Padding(padding: EdgeInsets.all(8.0)),
                                                  GestureDetector(
                                                    child: Text('Choose from gallery'),
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
                                  SingleChildScrollView(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.2),
                                        ),
                                      ),
                                      child: SizedBox(
                                        height: 200,
                                        child: editHotelItemBloc.hotel != null
                                            ? GridView.builder(
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
    );
  }
}
