import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gftr/Helper/apiConstants.dart';
import 'package:gftr/Helper/appConfig.dart';
import 'package:gftr/Helper/colorConstants.dart';
import 'package:gftr/Helper/imageConstants.dart';
import 'package:gftr/View/Screens/ContactPage.dart';
import 'package:gftr/View/Screens/LoginPage.dart';
import 'package:gftr/View/Screens/ManageBottom/articlsviewpage.dart';
import 'package:gftr/View/Screens/ManageBottom/gftrStoryViewPage.dart';
import 'package:gftr/View/Screens/ManageBottom/setingPageView.dart';
import 'package:gftr/View/Screens/aboutpageview.dart';
import 'package:gftr/View/Screens/ManageBottom/getGiftedPublicView.dart';
import 'package:gftr/View/Widgets/customLoader.dart';
import 'package:gftr/View/Widgets/customText.dart';
import 'package:gftr/ViewModel/Cubits/GetGifted/Profiel_img.dart';
import 'package:gftr/ViewModel/Cubits/fcm_token_cubit.dart';
import 'package:gftr/ViewModel/Cubits/viewsetting.dart';
import 'package:gftr/ViewModel/prefsService.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'flutterToast.dart';

Widget drawerCommonListTile(
    BuildContext context, String imagePath, String text) {
  return GestureDetector(
    onTap: () async {
      if ("Gftr Wishlist" == text) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => GetGiftedPublicViewPage(indexdata: 0)),
          (route) => false,
        );
        bottombarblack = false;
        isSearchbar = true;
      } else if ("Gftr Group" == text) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => GetGiftedPublicViewPage(indexdata: 3)),
          (route) => false,
        );
        bottombarblack = false;
        isSearchbar = true;
      } else if ("Gftr Guide" == text) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => GfterStoryViewPage()),
          (route) => false,
        );
        bottombarblack = true;
      } else if ("Settings" == text) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SetingViewPage()),
          (route) => false,
        );
        bottombarblack = false;
        isSearchbar = true;
      } else if ("Messages" == text) {
        bottombarblack = false;
        isSearchbar = true;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => GetGiftedPublicViewPage(indexdata: 1)),
          (route) => false,
        );
      } else if ("About Gftr" == text) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AboutUsPageView()));
        pageViewIndex = 0;
      } else if ("Contact Gftr" == text) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ContactPage()));
      } else if ("Log Out" == text) {
        SharedPrefsService prefsService = SharedPrefsService();
        prefsService.removeData('authToken');
        prefsService.removeData('phoneNumberPre');
        prefsService.removeData('emailPre');
        prefsService.removeData('adressPre');
        prefsService.removeData('birthDayPre');
        prefsService.removeData('profileNamePre');
        var url = Uri.parse(ApiConstants.logout);
        var response = await http.post(url, headers: {
          'Authorization': ' $authorization',
        });
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
        bottombarblack = false;
      }
    
    },
    child: Container(
      height: screenHeight(context, dividedBy: 21),
      width: screenWidth(context, dividedBy: 1.50),
      margin:
          EdgeInsets.symmetric(horizontal: screenWidth(context, dividedBy: 16)),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
                offset: const Offset(1, 2.0),
                spreadRadius: 1,
                color: Colors.grey.shade300,
                blurRadius: 1)
          ]),
      child: Row(
        children: [
          SizedBox(
            width: screenWidth(context, dividedBy: 30),
          ),
          Image.asset(
            imagePath,
            height: screenHeight(context, dividedBy: 50),
            width: screenHeight(context, dividedBy: 50),
          ),
          SizedBox(
            width: screenWidth(context, dividedBy: 30),
          ),
          customText(
              text, const Color(0xff231F20), 14, FontWeight.w500, poppins)
        ],
      ),
    ),
  );
}

Widget spaceBetweenMenu(BuildContext context) {
  return SizedBox(
    height: screenHeight(context, dividedBy: 60),
  );
}

// Helper method to build image picker button with loading state
Widget _buildImagePickerButton(BuildContext context, ImageSource source,
    String text, bool isLoading, VoidCallback onTap) {
  return InkWell(
    onTap: isLoading ? null : onTap,
    child: Container(
      margin: const EdgeInsets.only(top: 5),
      height: 20,
      width: 100,
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: isLoading
            ? customLoader(context)
            : customText(
                text, ColorCodes.greyText, 14, FontWeight.w400, poppins),
      ),
    ),
  );
}

Future<void> _handleImagePick(
    BuildContext context,
    ImageSource source,
    ViewSettingCubit viewSettingCubit,
    Function(bool, ImageSource?) setState) async {
  try {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    // Reset state if no image is picked
    if (pickedFile == null) {
      setState(false, null);
      return;
    }

    // Compress image
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      pickedFile.path,
      pickedFile.path + '_compressed.jpg',
      quality: 50,
    );

    if (compressedFile != null) {
      // Upload image
      Dio dio = Dio();
      FormData formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(compressedFile.path,
            filename: 'image.jpg'),
      });

      Response response = await dio.post(ApiConstants.User_img,
          options: Options(headers: {
            'Accept': 'application/json',
            'Authorization': ' $authorization',
          }),
          data: formData);

      if (response.statusCode == 200) {
        flutterToast('Image uploaded', true);
        viewSettingCubit.getviewSetting();
        Navigator.pop(context);
      } else {
        flutterToast('Upload failed', false);
        Navigator.pop(context);
      }
    }
  } catch (e) {
    flutterToast('Error uploading image', false);
    Navigator.pop(context);
  } finally {
    // Ensure state is always reset
    setState(false, null);
  }
}

Widget drawerHeader(BuildContext context) {
  return StatefulBuilder(builder: (context, StateSetter setState) {
    bool _gallry = false;
    bool _camera = false;
    File? _imageFile;
    ViewSettingCubit viewSettingCubit = ViewSettingCubit();
    viewSettingCubit = BlocProvider.of<ViewSettingCubit>(context);
    return Container(
      alignment: Alignment.center,
      height: screenHeight(context, dividedBy: 6),
      padding: EdgeInsets.only(
          top: screenHeight(context, dividedBy: 40),
          left: screenWidth(context, dividedBy: 20)),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(ImageConstants.gftrBack), fit: BoxFit.cover),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(31),
              bottomRight: Radius.circular(31))),
      child: Row(
        children: [
          //-----------------Profile Image-------------------
          // Container(
          //   height: screenHeight(context, dividedBy: 5.5),
          //   width: screenWidth(context, dividedBy: 5.5),
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.white, width: 1.7),
          //     shape: BoxShape.circle,
          //   ),
          //   child: BlocBuilder<ViewSettingCubit, ViewSettingState>(
          //     builder: (context, state) {
          //       log("ViewSettingCubit $state");
          //       if (state is ViewSettingLoading) {
          //         return Center(
          //           child: spinkitLoader(context, ColorCodes.coral),
          //         );
          //       } else if (state is ViewSettingError) {
          //         return Icon(Icons.person);
          //       } else if (state is ViewSettingSuccess) {
          //         return InkWell(
          //           onTap: () {
          //             showDialog(
          //               context: context,
          //               builder: (context) {
          //                 return SimpleDialog(
          //                   shape: RoundedRectangleBorder(
          //                       borderRadius: BorderRadius.circular(20)),
          //                   children: [
          //                     Padding(
          //                         padding: const EdgeInsets.symmetric(
          //                             horizontal: 20, vertical: 20),
          //                         child: Center(child: Text("PICK A PIC!"))),
          //                     Container(
          //                       width: 200,
          //                       height: 1,
          //                       decoration: const BoxDecoration(
          //                           color: Colors.black12,
          //                           boxShadow: [
          //                             BoxShadow(
          //                                 color: Colors.black38, blurRadius: 5)
          //                           ]),
          //                     ),
          //                     Row(
          //                       mainAxisAlignment:
          //                           MainAxisAlignment.spaceEvenly,
          //                       children: [
          //                         InkWell(
          //                           onTap: () async {
          //                             final picker = ImagePicker();
          //                             final pickedFile = await picker.pickImage(
          //                                 source: ImageSource.camera);
          //                             print(
          //                                 "you are here :${pickedFile?.path}");
          //                             var result = await FlutterImageCompress
          //                                 .compressAndGetFile(
          //                               pickedFile!.path,
          //                               pickedFile.path + '_compressed.jpg',
          //                               quality:
          //                                   50, // Adjust the quality as needed
          //                             );
          //                             print("result :${result!.path}");
          //                             setState(() {
          //                               viewSettingCubit.getviewSetting();
          //                               _camera = true;
          //                             });
          //                             print("you are here 1");
          //                             if (pickedFile != null) {
          //                               Dio dio = Dio();
          //                               print("you are here 2");
          //                               FormData formData = FormData.fromMap({
          //                                 'avatar':
          //                                     await MultipartFile.fromFile(
          //                                         result.path,
          //                                         filename: 'image.jpg'),
          //                               });
          //                               print("you are here 3");
          //                               // dio.options.headers['Authorization'] = '$authorization';
          //                               setState(() {});
          //                               print("you are here 4");
          //                               // dio.options.headers['Authorization'] = '$authorization';
          //                               Response response = await dio.post(
          //                                   ApiConstants.User_img,
          //                                   options: Options(headers: {
          //                                     'Accept': 'application/json',
          //                                     'Authorization':
          //                                         ' $authorization',
          //                                   }),
          //                                   data: formData);
          //                               print("Response = $response");
          //                               print("you are here 5");
          //                               if (response.statusCode == 200) {
          //                                 print('Image uploaded successfully');
          //                                 flutterToast('Image uploaded', true);
          //                                 // viewSettingCubit.getviewSetting();
          //                                 Navigator.pop(context);
          //                                 viewSettingCubit.getviewSetting();
          //                                 _camera = false;
          //                                 setState(() {});
          //                               } else {
          //                                 print(
          //                                     'Failed to upload image. Status code: ${response.statusCode}');
          //                               }
          //                             }
          //                           },
          //                           child: Container(
          //                             margin: const EdgeInsets.only(top: 5),
          //                             height: 20,
          //                             width: 100,
          //                             alignment: Alignment.center,
          //                             child: Padding(
          //                                 padding:
          //                                     const EdgeInsets.only(left: 8.0),
          //                                 child: BlocBuilder<ViewSettingCubit,
          //                                     ViewSettingState>(
          //                                   builder: (context, state) {
          //                                     if (state is ViewSettingLoading &&
          //                                         _camera == true) {
          //                                       return customLoader(context);
          //                                     }
          //                                     return customText(
          //                                         "Camera",
          //                                         ColorCodes.greyText,
          //                                         14,
          //                                         FontWeight.w400,
          //                                         poppins);
          //                                   },
          //                                 )),
          //                           ),
          //                         ),
          //                         Container(
          //                           width: screenWidth(context, dividedBy: 300),
          //                           height:
          //                               screenHeight(context, dividedBy: 20),
          //                           decoration: const BoxDecoration(
          //                               color: Colors.black12,
          //                               boxShadow: [
          //                                 BoxShadow(
          //                                     color: Colors.black38,
          //                                     blurRadius: 5)
          //                               ]),
          //                         ),
          //                         InkWell(
          //                           onTap: () async {
          //                             final picker = ImagePicker();
          //                             final pickedFile = await picker.pickImage(
          //                                 source: ImageSource.gallery);
          //                             setState(() {
          //                               viewSettingCubit.getviewSetting();
          //                               _gallry = true;
          //                             });
          //                             if (pickedFile != null) {
          //                               Dio dio = Dio();
          //                               FormData formData = FormData.fromMap({
          //                                 'avatar':
          //                                     await MultipartFile.fromFile(
          //                                         pickedFile.path),
          //                               });
          //                               Response response = await dio.post(
          //                                   ApiConstants.User_img,
          //                                   options: Options(headers: {
          //                                     'Accept': 'application/json',
          //                                     'Authorization':
          //                                         ' $authorization',
          //                                   }),
          //                                   data: formData);
          //                               if (response.statusCode == 200) {
          //                                 print('Image uploaded successfully');
          //                                 flutterToast('Image uploaded', true);
          //                                 // viewSettingCubit.getviewSetting();
          //                                 Navigator.pop(context);
          //                                 viewSettingCubit.getviewSetting();
          //                                 _gallry = false;
          //                                 setState(() {});
          //                               } else {
          //                                 setState(() {
          //                                   Navigator.pop(context);
          //                                   viewSettingCubit.getviewSetting();
          //                                   _gallry = false;
          //                                 });
          //                                 print(
          //                                     'Failed to upload image. Status code: ${response.statusCode}');
          //                               }
          //                             }
          //                           },
          //                           child: Container(
          //                               margin: const EdgeInsets.only(top: 5),
          //                               height: 20,
          //                               width: 100,
          //                               alignment: Alignment.center,
          //                               child: Padding(
          //                                   padding: const EdgeInsets.only(
          //                                       left: 8.0),
          //                                   child: BlocBuilder<ViewSettingCubit,
          //                                       ViewSettingState>(
          //                                     builder: (context, state) {
          //                                       if (state
          //                                               is ViewSettingLoading &&
          //                                           _gallry == true) {
          //                                         return customLoader(context);
          //                                       }
          //                                       return customText(
          //                                           "Gallery",
          //                                           ColorCodes.greyText,
          //                                           14,
          //                                           FontWeight.w400,
          //                                           poppins);
          //                                     },
          //                                   ))),
          //                         )
          //                       ],
          //                     )
          //                   ],
          //                 );
          //               },
          //             );
          //           },
          //           child: CircleAvatar(
          //             backgroundImage: NetworkImage(
          //                 '${ApiConstants.baseUrlsSocket}${viewSettingCubit.viewSetting?.data?.avatar}'),
          //             // backgroundImage: NetworkImage("https://www.jcrew.com/s7-img-facade/B}Q799_NA6445_m?hei=850&crop=0,0,680,0"),
          //           ),
          //         );
          //       }
          //       return SizedBox();
          //     },
          //   ),
          // ),

          Container(
            height: screenHeight(context, dividedBy: 5.5),
            width: screenWidth(context, dividedBy: 5.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.7),
              shape: BoxShape.circle,
            ),
            child: BlocBuilder<ViewSettingCubit, ViewSettingState>(
              builder: (context, state) {
                if (state is ViewSettingLoading) {
                  return Center(
                    child: spinkitLoader(context, ColorCodes.coral),
                  );
                } else if (state is ViewSettingError) {
                  return Icon(Icons.person);
                } else if (state is ViewSettingSuccess) {
                  return InkWell(
                    onTap: () {
                      bool _isUploading = false;
                      ImageSource? _uploadingSource;

                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setState) {
                            return SimpleDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              children: [
                                Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 20),
                                    child: Center(child: Text("PICK A PIC!"))),
                                Container(
                                  width: 200,
                                  height: 1,
                                  decoration: const BoxDecoration(
                                      color: Colors.black12,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black38,
                                            blurRadius: 5)
                                      ]),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // Camera Option
                                    _buildImagePickerButton(
                                        context,
                                        ImageSource.camera,
                                        'Camera',
                                        _isUploading &&
                                            _uploadingSource ==
                                                ImageSource.camera, () async {
                                      setState(() {
                                        _isUploading = true;
                                        _uploadingSource = ImageSource.camera;
                                      });
                                      await _handleImagePick(context,
                                          ImageSource.camera, viewSettingCubit,
                                          (isUploading, uploadingSource) {
                                        setState(() {
                                          _isUploading = isUploading;
                                          _uploadingSource = uploadingSource;
                                        });
                                      });
                                    }),

                                    // Vertical Divider
                                    Container(
                                      width:
                                          screenWidth(context, dividedBy: 300),
                                      height:
                                          screenHeight(context, dividedBy: 20),
                                      decoration: const BoxDecoration(
                                          color: Colors.black12,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black38,
                                                blurRadius: 5)
                                          ]),
                                    ),

                                    // Gallery Option
                                    _buildImagePickerButton(
                                        context,
                                        ImageSource.gallery,
                                        'Gallery',
                                        _isUploading &&
                                            _uploadingSource ==
                                                ImageSource.gallery, () async {
                                      setState(() {
                                        _isUploading = true;
                                        _uploadingSource = ImageSource.gallery;
                                      });
                                      // await _handleImagePick(
                                      //     context,
                                      //     ImageSource.gallery,
                                      //     viewSettingCubit);
                                      await _handleImagePick(context,
                                          ImageSource.gallery, viewSettingCubit,
                                          (isUploading, uploadingSource) {
                                        setState(() {
                                          _isUploading = isUploading;
                                          _uploadingSource = uploadingSource;
                                        });
                                      });
                                    })
                                  ],
                                )
                              ],
                            );
                          });
                        },
                      );
                    },
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          '${ApiConstants.baseUrlsSocket}${viewSettingCubit.viewSetting?.data?.avatar}'),
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),

          //-----------------Profile Image-------------------

          Padding(
            padding: EdgeInsets.only(left: screenWidth(context, dividedBy: 20)),
            child: Container(
              height: screenHeight(context, dividedBy: 20),
              child: BlocBuilder<ViewSettingCubit, ViewSettingState>(
                builder: (context, state) {
                  log("ViewSettingCubit $state");
                  if (state is ViewSettingLoading) {
                    return Center(
                      child: spinkitLoader(context, ColorCodes.coral),
                    );
                  } else if (state is ViewSettingError) {
                    return customText('Hello friend', Colors.white, 10,
                        FontWeight.bold, poppins);
                  } else if (state is ViewSettingSuccess) {
                    return Row(
                      children: [
                        customText(
                            '${viewSettingCubit.viewSetting?.data?.firstname}\'s ',
                            Colors.white,
                            20,
                            FontWeight.bold,
                            poppins),
                        SizedBox(
                            height: screenHeight(context, dividedBy: 40),
                            // width: screenWidth(context,dividedBy: 20),
                            child: Image.asset(
                              ImageConstants.gftrBlack,
                              color: Colors.white,
                            ))
                      ],
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
          )
        ],
      ),
    );
  });
}

Widget drawerWidget(BuildContext context) {
  return Drawer(
      child: Column(
    children: [
      GestureDetector(child: drawerHeader(context)),
      SizedBox(
        height: screenHeight(context, dividedBy: 28),
      ),
      Column(
        children: [
          drawerCommonListTile(context, ImageConstants.get, "Gftr Wishlist"),
          spaceBetweenMenu(context),
          drawerCommonListTile(context, ImageConstants.group, "Gftr Group"),
          spaceBetweenMenu(context),
          drawerCommonListTile(context, ImageConstants.gftrGuide, "Gftr Guide"),
          spaceBetweenMenu(context),
          drawerCommonListTile(context, ImageConstants.chat, "Messages"),
          spaceBetweenMenu(context),
          drawerCommonListTile(context, ImageConstants.settings, "Settings"),
          spaceBetweenMenu(context),
          drawerCommonListTile(context, ImageConstants.aboutUs, "About Gftr"),
          spaceBetweenMenu(context),
          drawerCommonListTile(
              context, ImageConstants.phoneBlack, "Contact Gftr"),
          SizedBox(
            height: screenHeight(context, dividedBy: 6),
          ),
          drawerCommonListTile(context, ImageConstants.logOut, "Log Out")
        ],
      )
    ],
  ));
}
