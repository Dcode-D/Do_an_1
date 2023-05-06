import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class RoomAndQuantity extends StatefulWidget {
  const RoomAndQuantity({Key? key}) : super(key: key);

  @override
  _RoomAndQuantityState createState() => _RoomAndQuantityState();
}

class _RoomAndQuantityState extends State<RoomAndQuantity> {
  int _adultsCounter = 0;
  int _childrenCounter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: const Color(0xffF9F9F9),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen()));
            },
            icon: const Icon(
              Icons.check,
              color: Colors.green,
            ),
          ),
        ],
        title: const Text("Room and Quantity",
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            )
          ),
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Room Type',
                style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
            ),
            const SizedBox(height: 10),
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Text(
                  'Select room type',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: _addDividersAfterItems(items),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
                  });
                },
                buttonStyleData: const ButtonStyleData(height: 40, width: 350),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                menuItemStyleData: MenuItemStyleData(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  customHeights: _getCustomItemsHeights(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Adults',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        if(_adultsCounter>0){
                          _adultsCounter--;
                        }
                      });
                    },
                    child:const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.remove))
                ),
                const SizedBox(width: 20),
                Text(
                  '$_adultsCounter',
                  style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _adultsCounter++;
                      });
                    },
                    child:const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.add))
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Children',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        if(_childrenCounter>0){
                          _childrenCounter--;
                        }
                      });
                    },
                    child:const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.remove))
                ),
                const SizedBox(width: 20),
                Text(
                  '$_childrenCounter',
                  style: const TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                    onPressed: (){
                      setState(() {
                        _childrenCounter++;
                      });
                    },
                    child:const SizedBox(
                        width: 40,
                        height: 40,
                        child: Icon(Icons.add))
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    List<DropdownMenuItem<String>> _menuItems = [];
    for (var item in items) {
      _menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                item,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          //If it's last item, we will not add Divider after it.
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(),
            ),
        ],
      );
    }
    return _menuItems;
  }

  List<double> _getCustomItemsHeights() {
    List<double> _itemsHeights = [];
    for (var i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        _itemsHeights.add(40);
      }
      //Dividers indexes will be the odd indexes
      if (i.isOdd) {
        _itemsHeights.add(4);
      }
    }
    return _itemsHeights;
  }
}