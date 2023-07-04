import 'package:doan1/BLOC/profile/profile_view/profile_bloc.dart';
import 'package:doan1/screens/profile/floating_button/widget/dialog/add_plan_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../BLOC/news_create/tour/create_tour_bloc.dart';
import '../../../BLOC/screen/all_screen/article/article_bloc.dart';

class CreateTourScreen extends StatefulWidget {
  const CreateTourScreen({Key? key}) : super(key: key);

  @override
  _CreateTourScreenState createState() => _CreateTourScreenState();
}

class _CreateTourScreenState extends State<CreateTourScreen> {
  final _formKey = GlobalKey<FormState>();
  final tourName = TextEditingController();
  double rating = 3;
  final priceController = TextEditingController();
  final duration = TextEditingController();
  final description = TextEditingController();
  final maxGroupSize = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var createTourBloc = context.read<CreateTourBloc>();
    return BlocListener<CreateTourBloc, CreateTourState>(
      listenWhen: (previous, current) => current is PostTourState,
      listener: (context, state) {
        if (state is PostTourState) {
          if(state.isSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Create tour success'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Create tour failed'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      },
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) => Scaffold(
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
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Text(
                  'Create Tour',
                  style: GoogleFonts.raleway(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                    color: Colors.black,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: IconButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final intDuration = int.parse(duration.text);
                        final doublePrice = double.parse(priceController.text);
                        final intMaxGroupSize = int.parse(maxGroupSize.text);
                        context.read<CreateTourBloc>().add(PostTour(
                            name: tourName.text,
                            description: description.text,
                            rating: rating,
                            duration: intDuration,
                            price: doublePrice,
                            maxGroupSize: intMaxGroupSize));
                      }
                    },
                    icon: const Icon(
                      FontAwesomeIcons.paperPlane,
                      color: Colors.orange,
                    ),
                  ),
                ),
              ],
            ),
            //heading with avatar and camera icon
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: Colors.orange,
                                  width: 2,
                                ),
                              ),
                              child: context.read<ProfileBloc>().image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        context.read<ProfileBloc>().image!,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const CircleAvatar(
                                      radius: 40,
                                      backgroundImage: AssetImage(
                                          "assets/images/undefine-wallpaper.jpg"),
                                    ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              context.read<ProfileBloc>().user?.firstname != null &&
                                  context.read<ProfileBloc>().user?.lastname != null
                                  ? "${context.read<ProfileBloc>().user!.firstname} ${context.read<ProfileBloc>().user!.lastname}"
                                  : "Firstname Lastname",
                              style: GoogleFonts.raleway(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.2,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tour name',
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
                            controller: tourName,
                            decoration: InputDecoration(
                              hintText: 'Tour name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter tour name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Text(
                                'Plan',
                                style: GoogleFonts.raleway(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.2,
                                  color: Colors.black,
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                  onTap: () {
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
                                                    end: const Offset(0, 0.1))
                                                .animate(anim1),
                                            child: child,
                                          );
                                        },
                                        pageBuilder: (context, _, __) {
                                          return MultiBlocProvider(providers: [
                                            BlocProvider<CreateTourBloc>.value(
                                              value: createTourBloc,
                                            ),
                                            BlocProvider<ArticleBloc>(
                                              create: (context) =>
                                                  ArticleBloc()..add(GetArticleData()),
                                            ),
                                          ], child: AddPlanDialog());
                                        });
                                  },
                                  child: Text(
                                    'Add plan',
                                    style: GoogleFonts.raleway(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.2,
                                      color: Colors.orange,
                                    ),
                                  ))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BlocBuilder<CreateTourBloc, CreateTourState>(
                            buildWhen: (previous, current) =>
                                current is CreateTourInitial ||
                                current is PlanSetState,
                            builder: (context, state) => Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2),
                                      width: 1),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 2),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: state is CreateTourInitial ||
                                        (state is PlanSetState &&
                                            createTourBloc
                                                .listSelectedTourPlan.isEmpty)
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Text(
                                          'No plan added yet',
                                          style: GoogleFonts.raleway(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 1.2,
                                            color:
                                                Colors.black.withOpacity(0.5),
                                          ),
                                        ),
                                      )
                                    :
                                    //plan list here
                                    ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: createTourBloc
                                            .listSelectedTourPlan.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    '${createTourBloc.listSelectedTourPlan[index].title}',
                                                    style: GoogleFonts.raleway(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                      letterSpacing: 1.2,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    context
                                                        .read<CreateTourBloc>()
                                                        .add(RemoveTourPlan(
                                                            article: context
                                                                    .read<
                                                                        CreateTourBloc>()
                                                                    .listSelectedTourPlan[
                                                                index]));
                                                  },
                                                  child: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      )),
                          ),
                          const SizedBox(
                            height: 10,
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
                              hintText: 'Price',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
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
                          Text(
                            'Duration',
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
                            controller: duration,
                            decoration: InputDecoration(
                              hintText: 'Days',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter duration';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Max group size',
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
                            controller: maxGroupSize,
                            decoration: InputDecoration(
                              hintText: 'Ideal group size',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter group size';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Rating',
                            style: GoogleFonts.raleway(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                              color: Colors.black,
                            ),
                          ),
                          RatingBar.builder(
                            initialRating: 3,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (value) {
                              rating = value;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: description,
                        onTapOutside: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: 'Description',
                          hintStyle: GoogleFonts.raleway(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2,
                            color: Colors.black45,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your post';
                          }
                          return null;
                        },
                        maxLines: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
