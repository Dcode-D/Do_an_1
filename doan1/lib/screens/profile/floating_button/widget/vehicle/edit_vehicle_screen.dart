import 'package:doan1/BLOC/profile/edit_vehicle/edit_vehicle_item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Utils/image_pick_method.dart';
import '../../../../../models/destination_model.dart';

class EditVehicleScreen extends StatefulWidget {
  const EditVehicleScreen({Key? key}) : super(key: key);

  @override
  _EditVehicleScreenState createState() => _EditVehicleScreenState();
}

class _EditVehicleScreenState extends State<EditVehicleScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vehicleEditItemBloc = context.read<EditVehicleItemBloc>();
    final brandController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final provinceController = TextEditingController();
    final addressController = TextEditingController();
    final cityController = TextEditingController();
    final colorController = TextEditingController();
    final licensePlateController = TextEditingController();
    final seatsController = TextEditingController();
    return BlocListener<EditVehicleItemBloc, EditVehicleItemState>(
      listenWhen: (previous, current) {
        return current is EditVehicleItemModified;
      },
      listener: (context, state) {
        if (state is EditVehicleItemModified) {
          if (state.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('Edit vehicle successfully!'),
              ),
            );
          }
          else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text('Edit vehicle failed!'),
              ),
            );
          }
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
              'Edit Service',
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
                      vehicleEditItemBloc.add(
                        VehicleItemEditEvent(
                          brandController.text,
                          double.parse(priceController.text),
                          colorController.text,
                          descriptionController.text,
                          addressController.text,
                          int.parse(seatsController.text),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.check,
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          body: BlocBuilder<EditVehicleItemBloc, EditVehicleItemState>(
            buildWhen: (previous, current) {
              if (current is EditVehicleItemLoaded) {
                return true;
              } else {
                return false;
              }
            },
            builder: (context, state) {
              if ((state as EditVehicleItemLoaded).getDataSuccess) {
                brandController.text = vehicleEditItemBloc.vehicle!.brand ?? '';
                priceController.text =
                    vehicleEditItemBloc.vehicle!.pricePerDay.toString() ?? '';
                descriptionController.text =
                    vehicleEditItemBloc.vehicle!.description ?? '';
                provinceController.text =
                    vehicleEditItemBloc.vehicle!.province ?? '';
                addressController.text =
                    vehicleEditItemBloc.vehicle!.address ?? '';
                cityController.text = vehicleEditItemBloc.vehicle!.city ?? '';
                colorController.text = vehicleEditItemBloc.vehicle!.color ?? '';
                licensePlateController.text =
                    vehicleEditItemBloc.vehicle!.licensePlate ?? '';
                seatsController.text =
                    vehicleEditItemBloc.vehicle!.seats.toString() ?? '';
              }
              return !(state as EditVehicleItemLoaded).loading
                  ? (state as EditVehicleItemLoaded).getDataSuccess
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
                                              'Vehicle',
                                              style: GoogleFonts.raleway(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 1.2,
                                                color: Colors.black,
                                              ),
                                            )),
                                      ],
                                    ),
                                    const Spacer(),

                                    //add vehicle pictures
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.orange,
                                              title: Text('Choose an image source',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    // Pick image from gallery
                                                    Navigator.pop(context);
                                                    vehicleEditItemBloc.add(VehicleItemAddImageEvent(ImagePickMethod.GALLERY));
                                                    // Process the image
                                                  },
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.photo_library,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        'Gallery',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    // Pick image from camera
                                                    Navigator.pop(context);
                                                    vehicleEditItemBloc.add(VehicleItemAddImageEvent(ImagePickMethod.CAMERA));
                                                    // Process the image
                                                  },
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.camera_alt,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        'Camera',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
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
                                      'Vehicle brand',
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
                                      controller: brandController,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          FontAwesomeIcons.car,
                                          color: Colors.black45,
                                        ),
                                        hintText: 'Enter vehicle brand',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter vehicle brand';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Images of your vehicle for rent',
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
                                          child: vehicleEditItemBloc.vehicle !=
                                                  null
                                              ? GridView.builder(
                                                  gridDelegate:
                                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3,
                                                    crossAxisSpacing: 8.0,
                                                    mainAxisSpacing: 8.0,
                                                  ),
                                                  itemCount: vehicleEditItemBloc
                                                      .vehicle!.images!.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Stack(children: [
                                                      SizedBox(
                                                        width: 100,
                                                        height: 100,
                                                        child: Image.network(
                                                          vehicleEditItemBloc
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
                                                                          content:
                                                                              Text('Are you sure you to delete this picture?'),
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
                                                                                backgroundColor: MaterialStateProperty.all(Colors.orange),
                                                                              ),
                                                                              child:
                                                                                  Text('Delete'),
                                                                              onPressed:
                                                                                  () {
                                                                                vehicleEditItemBloc.add(VehicleItemDeleteImageEvent(index));
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Price',
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
                                      controller: priceController,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          FontAwesomeIcons.dollarSign,
                                          color: Colors.black45,
                                        ),
                                        hintText: 'Enter vehicle price/day',
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Seats',
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
                                      controller: seatsController,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          FontAwesomeIcons.dollarSign,
                                          color: Colors.black45,
                                        ),
                                        hintText: 'Enter vehicle seats',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter vehicle seats';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Color',
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
                                      controller: colorController,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          FontAwesomeIcons.dollarSign,
                                          color: Colors.black45,
                                        ),
                                        hintText: 'Enter vehicle color',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter vehicle color';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'License plate',
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
                                      controller: licensePlateController,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          FontAwesomeIcons.dollarSign,
                                          color: Colors.black45,
                                        ),
                                        hintText: 'Enter vehicle license plate',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter vehicle license plate';
                                        }
                                        return null;
                                      },
                                    ),
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
                                    TextFormField(
                                      controller: provinceController,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(
                                          FontAwesomeIcons.mapMarkerAlt,
                                          color: Colors.black45,
                                        ),
                                        hintText: 'Enter vehicle\'s province',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      validator: (value) {
                                        return null;
                                      },
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
                                        hintText: 'Enter vehicle\'s city',
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      validator: (value) {
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Vehicle Description',
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
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )),
                        )
                      : const Center(
                          child: Icon(Icons.error),
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
