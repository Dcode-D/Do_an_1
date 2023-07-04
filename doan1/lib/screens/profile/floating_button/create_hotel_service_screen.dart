import 'package:doan1/BLOC/services_create/hotel/hotel_creation_bloc.dart';
import 'package:doan1/screens/profile/floating_button/create_hotel_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../BLOC/components/places/places_bloc.dart';
import '../../../widgets/dialog/add_avatar_image_dialog.dart';

class CreateHotelServiceScreen extends StatefulWidget {
  const CreateHotelServiceScreen({Key? key}) : super(key: key);

  @override
  _CreateHotelServiceScreenState createState() =>
      _CreateHotelServiceScreenState();
}

class _CreateHotelServiceScreenState extends State<CreateHotelServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  var districtCode = 0;
  var provinceCode = 0;
  var districtName = '';
  var provinceName = '';
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final addressController = TextEditingController();
  final facilitiesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HotelCreationBloc>(
          create: (context) => HotelCreationBloc(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return BlocListener<HotelCreationBloc, HotelCreationState>(
              listenWhen: (previous, current) {
                return current is HotelCreationPostState;
              }
              ,
              listener: (context, state) {
                if((state as HotelCreationPostState).success){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CreateHotelRoomScreen(hotelId: state.hotelid,)));
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Create hotel failed !',
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
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
                                    final facilities = facilitiesController.text
                                        .split(',')
                                        .map((e) => e.trim())
                                        .toList();
                                    BlocProvider.of<HotelCreationBloc>(context).add(
                                      HotelCreationPostEvent(
                                        name: nameController.text,
                                        description: descriptionController.text,
                                        address: addressController.text,
                                        province: provinceName,
                                        district: districtName,
                                        facilities: facilities,
                                      ),
                                    );
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
                                                width: MediaQuery.of(context).size.width *
                                                    0.44,
                                                height: 30,
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 15, vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5),
                                                  border: Border.all(
                                                    color: Colors.black.withOpacity(0.2),
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
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) => Center(
                                                      child: ImagePickingDialog(
                                                          getImageFromGallery: () {
                                                            context
                                                                .read<HotelCreationBloc>()
                                                                .add(
                                                                    HotelCreationImageEvent(
                                                                        ImageMethod
                                                                            .gallery));
                                                          },
                                                          getImageFromCamera: () {
                                                            context
                                                                .read<HotelCreationBloc>()
                                                                .add(
                                                                    HotelCreationImageEvent(
                                                                        ImageMethod
                                                                            .camera));
                                                          },
                                                          title: "Add image to the post"),
                                                    ));
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
                                          'Please add some images of your hotel',
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
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              borderRadius: BorderRadius.circular(5),
                                              border: Border.all(
                                                color: Colors.black.withOpacity(0.2),
                                              ),
                                            ),
                                            child: SizedBox(
                                              height: 200,
                                              width: MediaQuery.of(context).size.width,
                                              child: BlocBuilder<HotelCreationBloc,
                                                  HotelCreationState>(
                                                buildWhen: (previous, current) {
                                                  return current
                                                          is HotelCreationInitial ||
                                                      current is HotelCreationImageState;
                                                },
                                                builder: (context, state) {
                                                  return state is HotelCreationInitial ||
                                                          (state is HotelCreationImageState &&
                                                              state.listImages.isEmpty)
                                                      ? const Text("No image selected")
                                                      : GridView.builder(
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 3,
                                                            crossAxisSpacing: 8.0,
                                                            mainAxisSpacing: 8.0,
                                                          ),
                                                          itemCount: context
                                                              .read<HotelCreationBloc>()
                                                              .listImages
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext context,
                                                                  int index) {
                                                            return Stack(
                                                              children: [
                                                                Image.file(context.read<HotelCreationBloc>().listImages[index],
                                                                  fit: BoxFit.cover,
                                                                ),
                                                                Positioned(
                                                                  top: 0,
                                                                  right: 0,
                                                                  child: IconButton(
                                                                    onPressed: () {
                                                                      context.read<HotelCreationBloc>().
                                                                      add(HotelCreationRemoveImgEvent(index));
                                                                    },
                                                                    icon: const Icon(
                                                                      Icons.cancel,
                                                                      color: Colors.red,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                },
                                              ),
                                            ),
                                          ),
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
                                              FontAwesomeIcons.listUl,
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
                                            'Each facility must be separated by a comma (,)',
                                            style: GoogleFonts.raleway(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              fontStyle: FontStyle.italic,
                                              letterSpacing: 1.2,
                                              color: Colors.orange,
                                            )),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        BlocProvider<PlacesBloc>(
                                          create: (context) =>
                                              PlacesBloc()..add(GetProvinceEvent()),
                                          child:
                                              //Province List
                                              Column(
                                            children: [
                                              BlocBuilder<PlacesBloc, PlacesState>(
                                                  buildWhen: (previous, current) {
                                                return current is PlaceProvinceState ||
                                                    current is PlacesInitial;
                                              }, builder: (context, state) {
                                                return state is PlaceProvinceState
                                                    ? Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
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
                                                          DropdownButtonFormField<Map>(
                                                            decoration: InputDecoration(
                                                              hintText: 'Province',
                                                              border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        5),
                                                              ),
                                                            ),
                                                            items: (state
                                                                    as PlaceProvinceState)
                                                                .listProvince
                                                                .map((item) =>
                                                                    DropdownMenuItem<Map>(
                                                                      value: item,
                                                                      child: Text(
                                                                        item['name'],
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize: 14,
                                                                        ),
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                            validator: (value) {
                                                              if (value == null) {
                                                                return 'Please select province';
                                                              }
                                                              return null;
                                                            },
                                                            onChanged: (value) {
                                                              context
                                                                  .read<PlacesBloc>()
                                                                  .add(GetDistrictEvent(
                                                                      value?['code']));
                                                              provinceCode =
                                                                  value?['code'];
                                                              provinceName =
                                                                  value?['name'];
                                                            },
                                                            onSaved: (value) {
                                                              context
                                                                  .read<PlacesBloc>()
                                                                  .add(GetDistrictEvent(
                                                                      value?['code']));
                                                              provinceCode =
                                                                  value?['code'];
                                                              provinceName =
                                                                  value?['name'];
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    : const CircularProgressIndicator();
                                              }),
                                              //District List
                                              BlocBuilder<PlacesBloc, PlacesState>(
                                                  buildWhen: (previous, current) {
                                                return current is PlaceDistrictState ||
                                                    current is PlacesInitial;
                                              }, builder: (context, state) {
                                                return state is PlaceDistrictState
                                                    ?
                                                    //Real district list
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'District',
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
                                                          DropdownButtonFormField<Map>(
                                                            decoration: InputDecoration(
                                                              hintText: 'District',
                                                              border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        5),
                                                              ),
                                                            ),
                                                            value: state.listDistrict[0],
                                                            items: (state
                                                                    as PlaceDistrictState)
                                                                .listDistrict
                                                                .map((item) =>
                                                                    DropdownMenuItem<Map>(
                                                                      value: item,
                                                                      child: Text(
                                                                        item['name'],
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize: 14,
                                                                        ),
                                                                      ),
                                                                    ))
                                                                .toList(),
                                                            validator: (value) {
                                                              if (value == null) {
                                                                return 'Please select district';
                                                              }
                                                              return null;
                                                            },
                                                            onChanged: (value) {
                                                              districtCode =
                                                                  value?['code'];
                                                              districtName =
                                                                  value?['name'];
                                                            },
                                                            onSaved: (value) {
                                                              districtCode =
                                                                  value?['code'];
                                                              districtName =
                                                                  value?['name'];
                                                            },
                                                          ),
                                                        ],
                                                      )
                                                    :
                                                    //Place holder district list
                                                    Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            'District',
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
                                                          DropdownButtonFormField(
                                                            items: const [],
                                                            onChanged: (value) {},
                                                            decoration: InputDecoration(
                                                              hintText: 'District',
                                                              border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        5),
                                                              ),
                                                            ),
                                                            borderRadius:
                                                                BorderRadius.circular(5),
                                                            validator: (value) {
                                                              if (value == null) {
                                                                return 'Please select district';
                                                              }
                                                              return null;
                                                            },
                                                          ),
                                                        ],
                                                      );
                                              }),
                                            ],
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
                ),
              ),
          );
        }
      ),
    );
  }
}
