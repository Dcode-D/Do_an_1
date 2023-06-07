import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPostItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 5,
            ),],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.locationArrow, size: 25,
                  ),
                  const SizedBox(width: 10,),
                  Text('Destination',
                    style: GoogleFonts.roboto(
                        fontSize: 20,
                        fontWeight: FontWeight.bold),),
                  const Spacer(),
                  Text('12/12/2021',
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        fontWeight: FontWeight.bold),),
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage('assets/images/hotel0.jpg'),
                    width: MediaQuery.of(context).size.width * 0.325,
                    height: MediaQuery.of(context).size.height * 0.15,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Vehicle name'
                        ,style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5,),
                      Text('Vehicle renting information',
                        style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.w400),),
                    ],)
                ],
              ),
              const SizedBox(height: 10,),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: Colors.black12,
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Text(
                    'Optional Information',
                    style: GoogleFonts.roboto(
                        fontSize: 15,
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: (){
                    },
                    child:
                    Text(
                      'Detail',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                      ),),
                  ),
                  const SizedBox(width: 10,),
                  ElevatedButton(
                    onPressed: (){

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    child:
                    Text(
                      'Delete',
                      style: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                      ),),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}