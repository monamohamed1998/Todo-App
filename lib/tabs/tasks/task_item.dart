import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';

class TaskItem extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        
        children: [
          Container(
            margin: EdgeInsetsDirectional.only(end: 8),
            width: 4,
            height: 62,
            color: AppTheme.primraryLight,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Reading",style: Theme.of(context).textTheme.titleMedium,),
              Text("this is the first task",style: Theme.of(context).textTheme.labelMedium,),
            ],
          ),
        Spacer(),
        Container(
          width: 69,
          height: 34,
          child: Icon(Icons.check,color: AppTheme.white,size: 32,),
          decoration: BoxDecoration(
            color: AppTheme.primraryLight,
             borderRadius: BorderRadius.circular(15),
          ),
        ),
        ],
      ),
    );
  }
}