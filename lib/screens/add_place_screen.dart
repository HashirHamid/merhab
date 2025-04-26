import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:merhab/controllers/place_controller.dart';
import 'package:merhab/theme/themes.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _priceStartController = TextEditingController();
  final TextEditingController _priceEndController = TextEditingController();

  // FocusNode for RawAutocomplete
  final FocusNode _locationFocusNode = FocusNode();

  // Store latitude and longitude as state variables
  double _latitude = 0.0;
  double _longitude = 0.0;

  final List<XFile> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();

  // Mapbox Search API setup
  late SearchBoxAPI _searchBoxAPI;
  final String _mapboxApiKey =
      'pk.eyJ1IjoiaGFzaGlyMTIiLCJhIjoiY2x3NTg1YWNoMWRxeDJpbXV0dXU3dDMxMiJ9.WrBZRJ6L6AnAGPJmr10leA'; // Replace with your Mapbox API key

  @override
  void initState() {
    super.initState();
    // Initialize Mapbox Search API
    MapBoxSearch.init(_mapboxApiKey);
    _searchBoxAPI = SearchBoxAPI(
      country: "SA",
      apiKey: _mapboxApiKey,
      limit: 5,
    );
  }

  @override
  void dispose() {
    _locationController.dispose();
    _descriptionController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _priceStartController.dispose();
    _priceEndController.dispose();
    _locationFocusNode.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_selectedImages.length >= 3) return;

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null && _selectedImages.length < 3) {
      setState(() {
        _selectedImages.add(image);
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  // Fetch place suggestions from Mapbox Search API
  Future<List<String>> _fetchSuggestions(String query) async {
    if (query.isEmpty) return [];
    final response = await _searchBoxAPI.getSuggestions(query);
    return response.fold(
      (success) => success.suggestions.map((s) => s.name).toList(),
      (failure) => [],
    );
  }

  // Fetch place details from Mapbox Geocoding API
  Future<void> _fetchPlaceDetails(String query) async {
    final url = Uri.parse(
      'https://api.mapbox.com/geocoding/v5/mapbox.places/${Uri.encodeComponent(query)}.json?access_token=$_mapboxApiKey',
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['features']?.isNotEmpty ?? false) {
          final feature = data['features'][0];
          final center = feature['center'] as List<dynamic>?;
          setState(() {
            // _locationController.text = feature['text'] ?? query;
            if (center != null && center.length >= 2) {
              _longitude = center[0] as double; // Longitude
              _latitude = center[1] as double; // Latitude
            } else {
              _latitude = 0.0;
              _longitude = 0.0;
              Get.snackbar(
                'Warning',
                'Coordinates not available for this location',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.orange,
                colorText: Colors.white,
              );
            }
          });
        } else {
          Get.snackbar(
            'Error',
            'No place details found',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          'Error',
          'Failed to fetch place details: ${response.statusCode}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to fetch place details: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Place'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            RawAutocomplete<String>(
              textEditingController: _locationController,
              focusNode: _locationFocusNode,
              optionsBuilder: (TextEditingValue textEditingValue) async {
                return await _fetchSuggestions(textEditingValue.text);
              },
              onSelected: (String selectedSuggestion) async {
                await _fetchPlaceDetails(selectedSuggestion);
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController controller,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    labelText: 'Location Name',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(
                      Icons.location_on,
                      color: AppTheme.primaryGreenColor,
                    ),
                  ),
                  onSubmitted: (value) => onFieldSubmitted(),
                );
              },
              optionsViewBuilder: (BuildContext context,
                  AutocompleteOnSelected<String> onSelected,
                  Iterable<String> options) {
                return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 4.0,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: 200,
                        maxWidth: MediaQuery.of(context).size.width - 32,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String option = options.elementAt(index);
                          return ListTile(
                            title: Text(option),
                            onTap: () => onSelected(option),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(
                  Icons.description,
                  color: AppTheme.primaryGreenColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(children: [
              Expanded(
                child: TextField(
                  controller: _startTimeController,
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      if (value != null) {
                        _startTimeController.text = value.format(context);
                      }
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Start Time',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(
                      Icons.access_time,
                      color: AppTheme.primaryGreenColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: TextField(
                  controller: _endTimeController,
                  onTap: () {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((value) {
                      if (value != null) {
                        _endTimeController.text = value.format(context);
                      }
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'End Time',
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(
                      Icons.access_time,
                      color: AppTheme.primaryGreenColor,
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _priceStartController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price Start',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.attach_money,
                        color: AppTheme.primaryGreenColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _priceEndController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price End',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(
                        Icons.attach_money,
                        color: AppTheme.primaryGreenColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: AppTheme.primaryGreenColor,
                  width: 2.0,
                ),
              ),
              onPressed: _pickImage,
              child: const Text('Add Image'),
            ),
            const SizedBox(height: 12),
            if (_selectedImages.isNotEmpty)
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(_selectedImages[index].path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: const CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.red,
                              child: Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: Get.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreenColor,
                    ),
                    onPressed: () {
                      if (_locationController.text.isEmpty ||
                          _descriptionController.text.isEmpty ||
                          _startTimeController.text.isEmpty ||
                          _endTimeController.text.isEmpty ||
                          _priceStartController.text.isEmpty ||
                          _priceEndController.text.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Please fill all fields',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      if (_selectedImages.isEmpty) {
                        Get.snackbar(
                          'Error',
                          'Please add at least one image',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      if (_latitude == 0.0 && _longitude == 0.0) {
                        Get.snackbar(
                          'Error',
                          'Please select a valid location',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }

                      Get.find<PlaceController>().uploadPlace(
                        name: _locationController.text,
                        description: _descriptionController.text,
                        latitude: _latitude,
                        longitude: _longitude,
                        images:
                            _selectedImages.map((e) => File(e.path)).toList(),
                        startTime: _startTimeController.text,
                        endTime: _endTimeController.text,
                        priceStart:
                            double.tryParse(_priceStartController.text) ?? 0.0,
                        priceEnd:
                            double.tryParse(_priceEndController.text) ?? 0.0,
                      );
                    },
                    child: const Text('Add Place'),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
