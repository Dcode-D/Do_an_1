import 'package:doan1/BLOC/services_create/vehicle/vehicle_creation_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../BLOC/components/places/places_bloc.dart';
import '../../../widgets/dialog/add_avatar_image_dialog.dart';

class CreateCarServiceScreen extends StatefulWidget {
  const CreateCarServiceScreen({Key? key}) : super(key: key);

  @override
  _CreateCarServiceScreenState createState() => _CreateCarServiceScreenState();
}

class _CreateCarServiceScreenState extends State<CreateCarServiceScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provinceName = '';
    var districtName = '';
    final brandController = TextEditingController();
    final colorController = TextEditingController();
    final addressController = TextEditingController();
    final descriptionController = TextEditingController();
    final seatsController = TextEditingController();
    final licensePlateController = TextEditingController();
    final priceController = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider<VehicleCreationBloc>(
          create: (BuildContext context) => VehicleCreationBloc(),
        ),
      ],
      child: Builder(builder: (context) {
        return BlocListener<VehicleCreationBloc, VehicleCreationState>(
          listenWhen: (previous, current) {
            if (current is VehicleCreationPostState) {
              return true;
            }
            return false;
          },
          listener: (context, state) {
            if(state is VehicleCreationPostState){
              if(state.success){
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.green,
                    content: Text("Posted successfully!"),
                  ),
                );
                Navigator.pop(context);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("Post failed!"),
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
                          context
                              .read<VehicleCreationBloc>()
                              .add(VehicleCreationPostEvent({
                                'plate': licensePlateController.text,
                                'brand': brandController.text,
                                'color': colorController.text,
                                'address': addressController.text,
                                'province': provinceName,
                                'district': districtName,
                                'description': descriptionController.text,
                                'seats': int.parse(seatsController.text),
                                'price': double.parse(priceController.text),
                              }));
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
                                  width: MediaQuery.of(context).size.width * 0.44,
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
                          IconButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) => Center(
                                        child: ImagePickingDialog(
                                            getImageFromGallery: () {
                                              context
                                                  .read<VehicleCreationBloc>()
                                                  .add(VehicleCreationImageEvent(
                                                      ImageMethod.gallery));
                                            },
                                            getImageFromCamera: () {
                                              context
                                                  .read<VehicleCreationBloc>()
                                                  .add(VehicleCreationImageEvent(
                                                      ImageMethod.camera));
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
                          const SizedBox(height: 10,),
                          Text(
                            'Please add some images of your vehicle',
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
                                child: BlocBuilder<VehicleCreationBloc,
                                    VehicleCreationState>(
                                  buildWhen: (previous, current) {
                                    return current
                                    is VehicleCreationInitial ||
                                        current is VehicleCreationImageState;
                                  },
                                  builder: (context, state) {
                                    return state is VehicleCreationInitial ||
                                        (state is VehicleCreationImageState &&
                                            state.listImages.isEmpty)
                                        ? const Text("No image selected")
                                        : GridView.builder(
                                      gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 8.0,
                                        mainAxisSpacing: 8.0,
                                      ),
                                      itemCount: context.read<VehicleCreationBloc>()
                                          .listImages.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        return Stack(
                                          children: [
                                            Image.file(
                                              context.read<VehicleCreationBloc>()
                                                  .listImages[index],
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: IconButton(
                                                onPressed: () {
                                                  context
                                                      .read<
                                                      VehicleCreationBloc>()
                                                      .add(
                                                      VehicleCreationImgRemoveEvent(index));
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
                          const SizedBox(height: 10,),
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
                                FontAwesomeIcons.paintBrush,
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
                                Icons.event_seat,
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
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                FontAwesomeIcons.driversLicense,
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
                          const SizedBox(height: 10,),
                          BlocProvider<PlacesBloc>(
                            create: (context) => PlacesBloc()..add(GetProvinceEvent()),
                            child:
                            //Province List
                            Column(
                              children: [
                                BlocBuilder<PlacesBloc, PlacesState>(
                                    buildWhen: (previous, current) {
                                      return current is PlaceProvinceState ||
                                          current is PlacesInitial;
                                    }, builder: (context, state) {
                                  return state is PlaceProvinceState ?
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                      const SizedBox(height: 10,),
                                      DropdownButtonFormField<Map>(
                                        decoration: InputDecoration(
                                          hintText: 'Province',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                        ),
                                        items:
                                        (state as PlaceProvinceState).listProvince.map((item) =>
                                            DropdownMenuItem<Map>(
                                              value: item,
                                              child: Text(
                                                item['name'],
                                                style:
                                                const TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )).toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select province';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {context.read<PlacesBloc>().add(
                                            GetDistrictEvent(value?['code']));
                                        provinceName = value?['name'];
                                        },
                                        onSaved: (value) {
                                          context.read<PlacesBloc>().add(
                                              GetDistrictEvent(
                                                  value?['code']));
                                          provinceName = value?['name'];
                                        },
                                      ),
                                    ],
                                  )
                                      :
                                  const CircularProgressIndicator();
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
                                      const SizedBox(height: 10,),
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
                                            BorderRadius.circular(5),
                                          ),
                                        ),
                                        value: state.listDistrict[0],
                                        items: (state as PlaceDistrictState)
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
                                            )).toList(),
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Please select district';
                                          }
                                          return null;
                                        },
                                        onChanged: (value) {
                                          districtName = value?['name'];
                                        },
                                        onSaved: (value) {
                                          districtName = value?['name'];
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
                                      const SizedBox(height: 10,),
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
                                            BorderRadius.circular(5),
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
                          const SizedBox(height: 10,),
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
              ),
            ),
          ),
        );
      }),
    );
  }
}
