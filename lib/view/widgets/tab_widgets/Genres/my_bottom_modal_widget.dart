import 'dart:ui';

import 'package:flutter/material.dart';

import 'genre_style_widget.dart';

Future<dynamic> myShowModalBottomSheet(BuildContext context, isSelectedList, setState, genre, homePageServices, store) {
    return showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return ClipRRect(
                                      borderRadius:
                                          const BorderRadius.vertical(
                                              top: Radius.circular(12)),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                          sigmaX: 120.0,
                                          sigmaY: 20.0,
                                        ),
                                        child: teste(context, isSelectedList, setState, genre, homePageServices, store),
                                      ),
                                    );
                                  },
                                );
  }
