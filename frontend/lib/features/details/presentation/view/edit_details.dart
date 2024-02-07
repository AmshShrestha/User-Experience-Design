import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travel_log/features/details/domain/entity/detail_entity.dart';
import 'package:travel_log/features/details/viewmodel/detail_view_model.dart';

class EditDetails extends ConsumerStatefulWidget {
  const EditDetails({Key? key}) : super(key: key);

  @override
  _EditDetailsState createState() => _EditDetailsState();
}

class _EditDetailsState extends ConsumerState<EditDetails> {
  late DetailEntity _editedDetail;

  @override
  void initState() {
    super.initState();
    _titleController.text = _editedDetail.title ?? '';
    _urlController.text = _editedDetail.url ?? '';
    _dateController.text = _editedDetail.date ?? '';
    _selectedEndDate =
        _editedDetail.date != null ? DateTime.parse(_editedDetail.date!) : null;
  }

  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          ref.read(detailViewModelProvider.notifier).uploadCoverPhoto(_img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final _saveKey = GlobalKey<FormState>();

  final gap = const SizedBox(height: 10);
  final TextEditingController _titleController = TextEditingController();
  final _urlController = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedEndDate;

  String _formatRemainingTime(DateTime endDate) {
    final now = DateTime.now();
    final difference = endDate.difference(now);
    final days = difference.inDays;
    final hours = difference.inHours.remainder(24);
    final minutes = difference.inMinutes.remainder(60);

    return '$days days, $hours hours, $minutes minutes remaining';
  }

  Future<void> _selectEndDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.green, // Set primary color
            colorScheme: const ColorScheme.light(
                primary: Colors.green), // Set color scheme
            buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != _selectedEndDate) {
      setState(() {
        _selectedEndDate = pickedDate;
        _dateController.text = _formatRemainingTime(_selectedEndDate!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _saveKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              gap,
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                  icon: Icon(
                    Icons.title,
                    color: Colors.red,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter Trip Name';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  icon: Icon(
                    Icons.link,
                    color: Colors.orange,
                  ),
                  hintText: 'URL',
                ),
              ),
              gap,
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ' Time',
                  icon: Icon(
                    Icons.timer,
                    color: Colors.green,
                  ),
                ),
                readOnly: true,
                onTap: _selectEndDate,
              ),
              gap,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: _img != null
                          ? FileImage(_img!)
                          : const AssetImage('') as ImageProvider,
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(),
                        builder: (context) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton.icon(
                              onPressed: () {
                                checkCameraPermission();
                                _browseImage(
                                  ref,
                                  ImageSource.camera,
                                );
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.camera),
                              label: const Text('Camera'),
                            ),
                            ElevatedButton.icon(
                              onPressed: () {
                                _browseImage(
                                  ref,
                                  ImageSource.gallery,
                                );
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.image),
                              label: const Text('Gallery'),
                            ),
                          ],
                        ),
                      );
                    },
                    child: const Text('Uploads Icon'),
                  ),
                ],
              ),
              gap,
              // Update Button
              ElevatedButton(
                onPressed: () {
                  var updatedDetail = DetailEntity(
                    tripId: _editedDetail.tripId,
                    image: _img?.path,
                    title: _titleController.text,
                    url: _urlController.text.trim(),
                    date: _selectedEndDate != null
                        ? _formatRemainingTime(_selectedEndDate!)
                        : null,
                  );

                  ref
                      .read(detailViewModelProvider.notifier)
                      .updateDetails(context, updatedDetail);

                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
