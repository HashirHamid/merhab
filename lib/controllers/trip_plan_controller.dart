import 'dart:convert';

import 'package:get/get.dart';
import 'package:merhab/controllers/auth_controller.dart';
import 'package:merhab/models/trip_plan_model/activity_model.dart';
import 'package:merhab/models/trip_plan_model/trip_model.dart';
import 'package:merhab/services/supabase_service.dart';

class TripPlanController extends GetxController {
  RxList<ActivityModel> activities = <ActivityModel>[].obs;
  Rx<TripModel> trip = TripModel().obs;
  RxList<TripModel> tripList = <TripModel>[].obs;
  RxList<ActivityModel> activitiesList = <ActivityModel>[].obs;

  RxBool isLoadingTrips = false.obs;
  RxBool isAddingTrip = false.obs;
  RxBool isLoadingActivities = false.obs;

  void addActivity(ActivityModel activity) {
    activities.add(activity);
  }

  void removeActivity(String? eventName) {
    activities.removeWhere(
        (e) => e.eventName?.toUpperCase() == eventName?.toUpperCase());
  }

  void clearActivity() {
    activities.clear();
  }

  Future<void> createTrip() async {
    try {
      isAddingTrip.value = true;

      final data = {
        'trip_name': trip.value.tripName,
        'trip_destination': trip.value.tripDestination,
        'start_date': trip.value.startDate,
        'end_date': trip.value.endDate,
        'trip_description': trip.value.tripDescription,
        "traveler_name": trip.value.travelerName,
        "traveler_contact": trip.value.travelerContact,
        "user_id": Get.find<AuthController>().userData.userId
      };

      final id = await SupabaseService().insertDataAndGetId("Trip", [data]);

      if (activities.isNotEmpty) {
        if (id != null && id.isNotEmpty) {
          activities.forEach((e) {
            e.tripId = id;
          });

          final activityData = activities.map((e) => e.toJson()).toList();
          await SupabaseService()
              .insertDataAndGetId("Activities", activityData);
          activities.clear();
        } else {}
      }
    } catch (e) {
      print("An error occurred while creating the trip: $e");
    } finally {
      isAddingTrip.value = false;
    }
  }

  Future<void> createActivity(ActivityModel activity) async {
    try {
      isAddingTrip.value = true;

      final data = activity.toJson();
      final id =
          await SupabaseService().insertDataAndGetId("Activities", [data]);
      if (id.isNotEmpty) {
        final data = await SupabaseService().getDataById("Activities", id);
        if (data != null) {
          final activityData =
              ActivityModel.fromJson(jsonDecode(jsonEncode(data)));
          activitiesList.add(activityData);
          activitiesList.refresh();
        }
      }
    } catch (e) {
      print("An error occurred while creating the trip: $e");
    } finally {
      isAddingTrip.value = false;
    }
  }

  Future<void> getTableData(String tableName) async {
    try {
      isLoadingTrips.value = true;
      final trip = await SupabaseService().getItemsByField(
          tableName, "user_id", Get.find<AuthController>().userData.userId);
      //final trip = await SupabaseService().getData(tableName);
      final activity = await SupabaseService().getData('Activities');

      if (trip.isNotEmpty) {
        tripList.value = tripModelFromJson(jsonEncode(trip));
      }

      if (activity.isNotEmpty) {
        activitiesList.value = activityModelFromJson(jsonEncode(activity));
      }

      assignActivitiesToPlan();
    } catch (e) {
      print("Error fetching data: $e");
    } finally {
      isLoadingTrips.value = false;
    }
  }

  void assignActivitiesToPlan() {
    for (var trip in tripList) {
      trip.activities
          ?.addAll(activities.where((e) => e.tripId == trip.id).toList());
    }
  }
}
