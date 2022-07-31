import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: GetBuilder<HomeController>(
        builder: (_) {
          if (_.loading) {
            return const CircularProgressIndicator();
          } else {
            return ColorFiltered(
                colorFilter: ColorFilter.mode(
                    _.currentState.value.isLightOn!
                        ? Colors.transparent
                        : Colors.grey,
                    BlendMode.saturation),
                child: Container(
                  color: _.currentState.value.isLightOn!
                      ? Colors.white
                      : Colors.black,
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                            width: 200,
                            height: 80,
                            child:
                                SvgPicture.asset('assets/icons/logo_full.svg')),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _.currentState.value.forceUpdate ?? true
                                ? Text(
                                    'waiting.. last updated At ${_.currentState.value.lastUpdatedAt!.toDate().month} / ${_.currentState.value.lastUpdatedAt!.toDate().day} ${_.currentState.value.lastUpdatedAt!.toDate().hour} : ${_.currentState.value.lastUpdatedAt!.toDate().minute}',
                                    style: TextStyle(color: _.currentState.value.isLightOn!
                                        ? Colors.black:Colors.white),
                                  )
                                : NeumorphicButton(
                                    padding: EdgeInsets.all(10),
                                    onPressed: _.forceUpdate
                                    ,
                                    style: const NeumorphicStyle(
                                        color: Colors.white),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'updated At ${_.currentState.value.lastUpdatedAt!.toDate().month} / ${_.currentState.value.lastUpdatedAt!.toDate().day} ${_.currentState.value.lastUpdatedAt!.toDate().hour} : ${_.currentState.value.lastUpdatedAt!.toDate().minute}',
                                          style: TextStyle(
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          Icons.refresh,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ));
          }
        },
      )),
    );
  }
}
