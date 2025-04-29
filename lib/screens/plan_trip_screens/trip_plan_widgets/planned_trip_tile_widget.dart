import 'package:flutter/material.dart';
import 'package:merhab/models/trip_plan_model/activity_model.dart';
import 'package:merhab/models/trip_plan_model/trip_model.dart';
import 'package:merhab/theme/themes.dart';
import 'package:merhab/utils/helper_function.dart';

class PlannedTripTileWidget extends StatefulWidget {
  final TripModel? trip;
  final List<ActivityModel>? activities;

  const PlannedTripTileWidget({super.key, this.trip, this.activities});

  @override
  State<PlannedTripTileWidget> createState() => _PlannedTripTileWidgetState();
}

class _PlannedTripTileWidgetState extends State<PlannedTripTileWidget> {
  final Map<String, List<ActivityModel>> groupedActivities = {};

  @override
  void initState() {
    super.initState();
    for (ActivityModel activity in widget.activities ?? []) {
      if (activity.tripId == widget.trip?.id) {
        final dateKey = formatDate(activity.startDate ?? "");
        groupedActivities.putIfAbsent(dateKey, () => []);
        groupedActivities[dateKey]!.add(activity);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final groupedEntries = groupedActivities.entries.toList();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(160, 224, 224, 224),
            spreadRadius: 1,
            blurRadius: 2,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.trip?.tripName ?? "",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                formatDateByStyle(
                  startDate: widget.trip?.startDate,
                  endDate: widget.trip?.endDate,
                  style: DateFormatStyle.fullRangeWithDayMonthYear,
                ),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                 formatTimeWithAmPm(parseTimeOfDayString(activity.startTime??"")),
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${activity.timezone}",
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.normal),
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
                              color: index == 0 ? Colors.transparent : Colors.grey,
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
                                getActivityImagePath(activity.activityType ?? ""),
                              ),
                            ),
                            Container(
                              width: 3,
                              height: 50,
                              color: isLastActivity
                                  ? (isLastGroup ? Colors.transparent : Colors.grey)
                                  : Colors.grey,
                            ),
                          ],
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 20),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    style: const TextStyle(fontSize: 14),
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
            widget.trip?.tripDescription ?? "No description available.",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          const Text(
            'Traveler Details:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.trip?.travelerName ?? "Unknown",
            style: const TextStyle(fontSize: 16),
          ),
          const Text(
            'Traveler Contact No.:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.trip?.travelerContact ?? "Unknown",
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _tripDateRow(String label, String? date) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryLavenderColor,
            ),
          ),
          TextSpan(
            text: formatDate(date ?? ""),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
