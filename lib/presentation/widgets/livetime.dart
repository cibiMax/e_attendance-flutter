import 'package:flutter/material.dart';

import '../../core/theme/app_text_styles.dart';
import '../../core/utils/app_utils/date_time_utils.dart';

class LiveTime extends StatelessWidget {
  const LiveTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream<String>.periodic(
      Duration(seconds: 1),(value){
        value++;
        return DateTimeUtils.formatCurrentTime;
      }
      ),
    
      initialData: DateTimeUtils.formatCurrentTime,
      builder: (context, snap) => Text(
        snap.data!,
        style: AppTextStyles.hint,
      ),
    );
  }
}
