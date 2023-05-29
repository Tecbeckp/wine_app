import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class Shimmers {
  static PaymentScreen() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 25),

              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Text('Exercises',style: TextStyle(
                          fontWeight:FontWeight.bold,fontFamily: 'Interbold',
                          fontSize: 21,
                          color: Colors.transparent

                        ),),
                      ),
                      Container(
                        height: 32,
                        width: 30,
                      color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    color: Colors.white,
                    child: Text('Latest, feature rich tools from leading brands at the best price.',
                      style: TextStyle(fontSize: 13, color: Colors.transparent,height: 1.7),),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  for(int i=0;i<6;i++)
                    Column(
                      children: [
                        Container(
                          height: 250,
                          width: 90.w,
                          color: Colors.white,
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10,right: 10),
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    child: Text('Treadmills',style: TextStyle(fontWeight: FontWeight.bold,
                                        fontFamily: "Interbold",fontSize: 16
                                        ,color:Colors.transparent),),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    color: Colors.white,
                                    child: Text('₹9,000',style: TextStyle(fontWeight: FontWeight.bold,
                                        fontFamily: "Interbold",fontSize: 17
                                        ,color: Colors.transparent),),
                                  )
                                ],
                              ),
                              Container(
                                height: 41,
                                width: 100,
                             color: Colors.white,
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
