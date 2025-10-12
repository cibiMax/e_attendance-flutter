import 'package:e_attendance/core/theme/app_icons.dart';
import 'package:e_attendance/core/theme/app_text_styles.dart';
import 'package:e_attendance/core/utils/app_utils/date_time_utils.dart';
import 'package:flutter/material.dart';

class LiveDateTime extends StatelessWidget {
  const LiveDateTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: AppIcons.clockIcon,
        title: StreamBuilder<String>(stream: Stream.periodic(Duration(days: 1),(value){
          value++;
          return DateTimeUtils.displayDate;
        }),
          builder: (context,snap) {
            return Text(
              DateTimeUtils.displayDate,
              style: AppTextStyles.subheading,
            );
          }
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StreamBuilder(
              stream: Stream<String>.periodic(
              Duration(seconds: 1),(value){
                value++;
                return DateTimeUtils.formatCurrentTime;
              }
              ),
      
              initialData: DateTimeUtils.formatCurrentTime,
              builder: (context, snap) => Text(
                snap.data!,
                style: AppTextStyles.italicHint,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
