import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../services/api_service.dart';

class AddClothingScreen extends StatefulWidget {
  const AddClothingScreen({super.key});

  @override
  State<AddClothingScreen> createState() =>
      _AddClothingScreenState();
}

class _AddClothingScreenState
    extends State<AddClothingScreen> {

  final nameController = TextEditingController();
  final colorController = TextEditingController();

  String category = 'shirt';
  String style = 'casual';
  String season = 'all';

  File? selectedImage;

  Future<void> pickImage() async {

    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  Future<void> uploadClothing() async {

    if (selectedImage == null) return;

    await ApiService.uploadClothing(

      name: nameController.text,

      category: category,

      color: colorController.text,

      style: style,

      season: season,

      image: selectedImage!,
    );

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Clothing uploaded!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Clothing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            GestureDetector(
              onTap: pickImage,
              child: Container(
                height: 200,
                width: double.infinity,
                color: Colors.grey[800],
                child: selectedImage != null
                    ? Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                      )
                    : const Icon(
                        Icons.add_a_photo,
                        size: 50,
                      ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: colorController,
              decoration: const InputDecoration(
                labelText: 'Color',
              ),
            ),

            const SizedBox(height: 10),

            DropdownButton<String>(
              value: category,
              isExpanded: true,
              items: const [
                DropdownMenuItem(
                  value: 'shirt',
                  child: Text('Shirt'),
                ),
                DropdownMenuItem(
                  value: 'pants',
                  child: Text('Pants'),
                ),
                DropdownMenuItem(
                  value: 'shoes',
                  child: Text('Shoes'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  category = value!;
                });
              },
            ),

            const SizedBox(height: 10),

            DropdownButton<String>(

              value: style,

              isExpanded: true,

              items: const [

                DropdownMenuItem(
                  value: 'casual',
                  child: Text('Casual'),
                ),

                DropdownMenuItem(
                  value: 'formal',
                  child: Text('Formal'),
                ),

                DropdownMenuItem(
                  value: 'sport',
                  child: Text('Sport'),
                ),
              ],

              onChanged: (value) {

                setState(() {
                  style = value!;
                });

              },
            ),

            const SizedBox(height: 10),

            DropdownButton<String>(

              value: season,

              isExpanded: true,

              items: const [

                DropdownMenuItem(
                  value: 'summer',
                  child: Text('Summer'),
                ),

                DropdownMenuItem(
                  value: 'winter',
                  child: Text('Winter'),
                ),

                DropdownMenuItem(
                  value: 'all',
                  child: Text('All Season'),
                ),
              ],

              onChanged: (value) {

                setState(() {
                  season = value!;
                });

              },
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: uploadClothing,
              child: const Text('Upload Clothing'),
            ),
          ],
        ),
      ),
    );
  }
}