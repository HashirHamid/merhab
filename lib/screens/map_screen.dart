import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:merhab/controllers/place_controller.dart';
import 'package:merhab/models/place_model.dart';
import 'package:merhab/theme/themes.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMap? mapboxMap;
  PointAnnotationManager? pointAnnotationManager;
  final PlaceController placeController = Get.find<PlaceController>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await placeController.getPlaces();
    });
    super.initState();
  }

  // final List<Map<String, dynamic>> landmarks = [
  //   {
  //     "title": "Kingdom Centre",
  //     "description": "Iconic skyscraper with shopping and views.",
  //     "location": "Riyadh, Saudi Arabia",
  //     "images": [
  //       "https://cdnassets.hw.net/f1/c0/47fa35164565bb3ea20deb749de1/e3331a06cb92418fac36a8ee3d7dcdfd.jpg",
  //       "https://www.easternengineeringgroup.com/wp-content/uploads/2024/12/Characteristics-of-the-Kingdom-Centre-1024x587.jpg",
  //     ],
  //     "position": Position(46.6334, 24.7117),
  //   },
  //   {
  //     "title": "Al Faisaliyah",
  //     "description": "Pyramid shaped tower with restaurants.",
  //     "location": "Riyadh, Saudi Arabia",
  //     "images": [
  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWc__YuN0dWxuLvH0V9IrK2OyT-KM0kfd_QA&s",
  //       "https://images.skyscrapercenter.com/building/2325691873_b8d5c8c714_b.jpg",
  //     ],
  //     "position": Position(46.6839, 24.6877),
  //   },
  //   {
  //     "title": "National Museum",
  //     "description": "Exhibits on Saudi history and culture.",
  //     "location": "Riyadh, Saudi Arabia",
  //     "images": [
  //       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_kSTcZJoHZ6j7a9tLEo9DNzSvSYNdpOwGoQ&s",
  //       "https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/National_Museum_Riyadh_%286781666263%29.jpg/330px-National_Museum_Riyadh_%286781666263%29.jpg",
  //     ],
  //     "position": Position(46.7100, 24.6478),
  //   },
  // ];
  @override
  void dispose() {
    pointAnnotationManager?.deleteAll();
    super.dispose();
  }

  void _onMapCreated(MapboxMap mapboxMap) async {
    this.mapboxMap = mapboxMap;
    pointAnnotationManager =
        await mapboxMap.annotations.createPointAnnotationManager();

    final ByteData bytes = await rootBundle.load('assets/marker.png');
    final Uint8List imageData = bytes.buffer.asUint8List();

    for (PlaceModel landmark in placeController.places) {
      await pointAnnotationManager?.create(PointAnnotationOptions(
        geometry: Point(
            coordinates:
                Position(landmark.longitude ?? 0.0, landmark.latitude ?? 0.0)),
        image: imageData,
        iconSize: 0.2,
      ));
    }

    if (pointAnnotationManager != null) {
      pointAnnotationManager!.addOnPointAnnotationClickListener(
        _CustomPointAnnotationClickListener(
          onPointAnnotationClickCallback: (PointAnnotation annotation) {
            final Position tappedPosition = annotation.geometry.coordinates;

            // Debug print to verify click
            print(
                'Annotation clicked at: ${tappedPosition.lng}, ${tappedPosition.lat}');

            final matched = placeController.places.firstWhere(
              (landmark) {
                final landmarkPos = Position(
                    landmark.longitude ?? 0.0, landmark.latitude ?? 0.0);
                // Use a small tolerance for floating-point comparison
                const tolerance = 0.0001;
                return (landmarkPos.lng - tappedPosition.lng).abs() <
                        tolerance &&
                    (landmarkPos.lat - tappedPosition.lat).abs() < tolerance;
              },
              orElse: () => PlaceModel(),
            );

            // Debug print to verify match
            print('Matched landmark: $matched');

            if (matched.name != null) {
              _showLandmarkBottomSheet(
                title: matched.name ?? "",
                description: matched.description ?? "",
                location: matched.name ?? "",
                images: List<String>.from(matched.images ?? []),
              );
            } else {
              print('No matching landmark found');
            }
          },
        ),
      );
    }
  }

  void _showLandmarkBottomSheet({
    required String title,
    required String description,
    required String location,
    required List<String> images,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display up to 3 network images at the top
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    images.length > 3 ? 3 : images.length, // Limit to 3 images
                itemBuilder: (_, i) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      images[i],
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Text('Image failed to load');
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Title below images
            Text(
              "$title - $description",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 4),
            Text(location),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppTheme.secondaryLavenderColor.withAlpha(80)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.monetization_on,
                        color: AppTheme.primaryLavenderColor,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "100-200",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppTheme.primaryLavenderColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppTheme.primaryGreenColor.withAlpha(40)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.watch_later,
                        color: AppTheme.primaryGreenColor,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "10:00 - 14:00",
                        style: TextStyle(
                          fontSize: 10,
                          color: AppTheme.primaryGreenColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Divider(
              color: AppTheme.primaryLavenderColor.withAlpha(80),
              thickness: 1,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 150,
                  height: 50,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: AppTheme.secondaryGreenColor),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.directions,
                        color: Colors.white,
                        size: 26,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Plan a Trip",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => placeController.isLoadingPlaces.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : MapWidget(
                key: const ValueKey("mapWidget"),
                styleUri: MapboxStyles.MAPBOX_STREETS,
                cameraOptions: CameraOptions(
                  center: Point(coordinates: Position(46.6753, 24.7136)),
                  zoom: 5.0,
                ),
                onMapCreated: _onMapCreated,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory(() => EagerGestureRecognizer()),
                },
              ),
      ),
    );
  }
}

class _CustomPointAnnotationClickListener
    implements OnPointAnnotationClickListener {
  final Function(PointAnnotation) onPointAnnotationClickCallback;

  _CustomPointAnnotationClickListener(
      {required this.onPointAnnotationClickCallback});

  @override
  void onPointAnnotationClick(PointAnnotation annotation) {
    onPointAnnotationClickCallback(annotation);
  }
}
