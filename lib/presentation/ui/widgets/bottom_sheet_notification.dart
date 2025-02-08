import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/text_constant.dart';
import 'package:weather_app/extensions/media_query_values.dart';
import 'package:weather_app/helper/text_style_helper.dart';
import 'package:weather_app/presentation/bloc/notification/notification_cubit.dart';
import 'package:weather_app/presentation/bloc/notification/notification_state.dart';
import '../../../helper/color_helper.dart';

class BottomSheetNotification extends StatefulWidget {
  const BottomSheetNotification({super.key});

  @override
  State<BottomSheetNotification> createState() =>
      _BottomSheetNotificationState();
}

class _BottomSheetNotificationState extends State<BottomSheetNotification> {
  @override
  void initState() {
    context.read<NotificationCubit>().initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure the NotificationCubit is created and initialized

    return Container(
      height: context.screenHeight * 0.5,
      width: context.screenWidth,
      decoration: BoxDecoration(
        color: ColorHelper.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state.notificationModel.isEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/bell.png'),
                Text(TextConstant.noNotification,
                    style: TextStyleHelper.textStylefontSize18.copyWith(
                      color: ColorHelper.lightBlue,
                    )),
              ],
            );
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    TextConstant.notifications,
                    style: TextStyleHelper.textStylefontSize18.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.notificationModel.length,
                    itemBuilder: (context, index) {
                      final notification = state.notificationModel[index];
                      DateTime now = DateTime.now();
                      Duration difference = now.difference(notification.date!);
                      int minutesAgo = difference.inMinutes;

                      return _buildNotificationItem(
                        body: notification.body!,
                        imagePath: notification.imagePath!,
                        minutesAgo: minutesAgo,
                        title: notification.title!,
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class _buildNotificationItem extends StatelessWidget {
  const _buildNotificationItem({
    required this.imagePath,
    required this.title,
    required this.body,
    required this.minutesAgo,
  });

  final String imagePath, title, body;
  final int minutesAgo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        imagePath,
        width: 20,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.notifications);
        },
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyleHelper.textStylefontSize18,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '$minutesAgo mins ago',
            style: TextStyleHelper.textStylefontSize18.copyWith(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
      subtitle: Text(
        body,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
