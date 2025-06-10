import 'package:flutter/material.dart';
import 'package:portfolio_app/core/ui.dart';
import 'package:portfolio_app/presentation/widget/vertical_spacer.dart';

class ExperienceTimeine extends StatelessWidget {
  const ExperienceTimeine(
      {required this.company_name,
      required this.designation,
      required this.duration,
      this.isLast = false,
      super.key});
  final String company_name;
  final String designation;
  final String duration;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final kTextTheme = Theme.of(context).textTheme;
    return IntrinsicHeight(
      child: Row(
        children: [
          /// timeline
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  width: 2,
                  // height: 20,
                  color: Colors.black,
                ),
              ),
              CircleAvatar(
                backgroundColor: ColorConstant.primaryColor,
                radius: 5,
              ),
              Expanded(
                child: Container(
                  width: 2,
                  // height: 20,
                  color: isLast ? Colors.transparent : Colors.black,
                ),
              ),
            ],
          ),

          /// connector - middle horizontal line
          Expanded(
            flex: 1,
            child: Container(
              height: 2,
              color: Colors.black,
            ),
          ),

          /// Company details
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    designation,
                    style: kTextTheme.titleSmall!,
                  ),
                  Text(
                    company_name,
                    style: kTextTheme.bodySmall!,
                  ),
                  Text(
                    duration,
                    style: kTextTheme.displaySmall!,
                  ),
                  const VerticalSpacer.medium()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
