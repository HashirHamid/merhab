import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merhab/controllers/trip_plan_controller.dart';
import 'package:merhab/models/trip_plan_model/activity_model.dart';
import 'package:merhab/models/trip_plan_model/trip_model.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/utils/helper_function.dart';

class PlannedTripTileWidget extends StatelessWidget {
  final TripModel? trip;

  const PlannedTripTileWidget({super.key, this.trip});

  @override
  Widget build(BuildContext context) {
    final TripPlanController tripController = Get.find<TripPlanController>();

    return Obx(() {
      // Group the activities every time activitiesList updates
      final List<ActivityModel> relatedActivities = tripController.activitiesList
          .where((a) => a.tripId == trip?.id)
          .toList();

      final Map<String, List<ActivityModel>> groupedActivities = {};
      for (ActivityModel activity in relatedActivities) {
        final dateKey = formatDate(activity.startDate ?? "");
        groupedActivities.putIfAbsent(dateKey, () => []);
        groupedActivities[dateKey]!.add(activity);
      }

      final groupedEntries = groupedActivities.entries.toList();

      return tripController.isLoadingActivities.value
          ? const Center(child: CircularProgressIndicator())
          : Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                border: Border.all(color: Colors.black12),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(160, 224, 224, 224),
                    spreadRadius: 1,
                    blurRadius: 2,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip?.tripName ?? "",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        formatDateByStyle(
                          startDate: trip?.startDate,
                          endDate: trip?.endDate,
                          style: DateFormatStyle.fullRangeWithDayMonthYear,
                        ),
                        style: const TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  const SizedBox(height: 25),
                  ...List.generate(groupedEntries.length, (groupIndex) {
                    final entry = groupedEntries[groupIndex];
                    String date = entry.key;
                    List<ActivityModel> activities = entry.value;
                    final isLastGroup = groupIndex == groupedEntries.length - 1;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          width: double.infinity,
                          child: Text(
                            formatDateByStyle(
                              startDate: date,
                              style: DateFormatStyle.singleDayWithComma,
                            ),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        ...List.generate(activities.length, (index) {
                          final activity = activities[index];
                          final isLastActivity = index == activities.length - 1;

                          return SizedBox(
                            width: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatTimeWithAmPm(parseTimeOfDayString(
                                              activity.startTime ?? "")),
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          activity.timezone ?? '',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: 3,
                                      height: 12,
                                      color: index == 0
                                          ? Colors.transparent
                                          : Colors.grey,
                                    ),
                                    Container(
                                      width: 30,
                                      height: 30,
                                      padding: const EdgeInsets.all(5),
                                      decoration: const BoxDecoration(
                                        color: AppTheme.primaryLavenderColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.asset(
                                        color: Colors.black,
                                        getActivityImagePath(
                                            activity.activityType ?? ""),
                                      ),
                                    ),
                                    Container(
                                      width: 3,
                                      height: 50,
                                      color: isLastActivity
                                          ? (isLastGroup
                                              ? Colors.transparent
                                              : Colors.grey)
                                          : Colors.grey,
                                    ),
                                  ],
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8, bottom: 20),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            activity.eventName ?? "",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.left,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            activity.venue ?? '',
                                            style:
                                                const TextStyle(fontSize: 14),
                                            textAlign: TextAlign.right,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    );
                  }),
                  const SizedBox(height: 10),
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    trip?.tripDescription ?? "No description available.",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Traveler Details:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    trip?.travelerName ?? "Unknown",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Text(
                    'Traveler Contact No.:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    trip?.travelerContact ?? "Unknown",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
    });
  }
}
