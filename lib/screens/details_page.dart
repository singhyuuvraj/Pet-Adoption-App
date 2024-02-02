import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_adoption_app/models/pet.dart';
import 'package:pet_adoption_app/providers/pet_provider.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../theme/color.dart';

class DetailsPage extends StatelessWidget {
  final Pet pet;

  DetailsPage({required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                _showImageGallery(context, pet.imageUrl);
              },
              child: Hero(
                tag: 'pet_image_${pet.id}',
                child: Container(
                  height: 200,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          pet.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: GlassContainer(
                          borderRadius: BorderRadius.circular(25),
                          blur: 10,
                          opacity: 0.15,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.shadowColor.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${pet.name}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppColor.glassTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Age:${pet.age}',
                                  style: TextStyle(
                                    color: AppColor.glassTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'Price: \$${pet.price.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: AppColor.glassTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            AnimatedButton(
              onPress: () async {
                if (!pet.adopted) {
                  Provider.of<PetProvider>(context, listen: false).adoptPet(pet);
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Adoption Successful'),
                      content: Text('You\'ve now adopted ${pet.name}'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  Navigator.pop(context); //  back to home pge aftr adoption
                }
              },
              height: 50,
              width: 170,
              text: 'Adopt Me',
              isReverse: true,
              selectedTextColor: Colors.black,
              transitionType: TransitionType.BOTTOM_TO_TOP,
              textStyle: TextStyle(
                  fontSize: 20,
                  letterSpacing: 5,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
              backgroundColor: Colors.black,
              borderColor: Colors.white,
              borderWidth: 1,
            ),
          ],
        ),
      ),
    );
  }

  void _showImageGallery(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageGallery(images: [imageUrl]),
      ),
    );
  }
}

class ImageGallery extends StatelessWidget {
  final List<String> images;

  ImageGallery({required this.images});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PhotoViewGallery.builder(
        itemCount: images.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(images[index]),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          color: Colors.black,
        ),
        pageController: PageController(),
      ),
    );
  }
}
