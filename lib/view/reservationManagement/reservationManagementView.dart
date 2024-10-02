import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_u_web/global.dart';
import 'package:on_u_web/models/reservationList.dart';
import 'package:on_u_web/view/reservationManagement/reservationManagementController.dart';
import 'package:table_calendar/table_calendar.dart';

class ReservationManagementView extends GetView<ReservationManagementController> {
  const ReservationManagementView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ReservationManagementController());
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('예약 현황', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
            SizedBox(height: 20,),
            Container(
              child: Stack(
                children: [
                  Container(
                    width: 800,
                    height: 370,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: gray200),
                    ),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 350,
                        child: GetBuilder<ReservationManagementController>(
                            builder: (controller) {
                              return TableCalendar(
                                locale: 'ko_KR',
                                selectedDayPredicate: (day) {
                                  return isSameDay(controller.selectedDay.value, day);
                                },
                                onDaySelected: (selectedDay, focusedDay) {
                                  controller.selectedDay.value = selectedDay;
                                  controller.update();
                                },
                                focusedDay: controller.selectedDay.value,
                                currentDay: DateTime.now(),
                                firstDay: DateTime.now(),
                                lastDay: DateTime.now().add(const Duration(days: 365)),
                                onPageChanged: (newFocusedDay) {
                                  controller.selectedDay.value = newFocusedDay;
                                  controller.update();

                                },
                                // locale: 'ko_KR',
                                daysOfWeekVisible: true,
                                weekNumbersVisible: false,
                                calendarBuilders: CalendarBuilders(
                                  defaultBuilder: (context, date, events) {
                                    bool isReserved = false;
                                    for(var i in controller.reservationList){
                                      if(i.createDate.year == date.year && i.createDate.month == date.month && i.createDate.day == date.day){
                                        isReserved = true;
                                      }
                                    }
                                    return Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            margin: const EdgeInsets.all(4.0),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Text(
                                              date.day.toString(),
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 16,
                                          bottom: 0,
                                          child: isReserved
                                              ? Icon(Icons.circle, color: isReserved
                                              ? mainColor
                                              : Colors.transparent, size: 10,)
                                              : Container(),
                                        )
                                      ],
                                    );
                                  },
                                  selectedBuilder: (context, date, events) {

                                    return Container(
                                      margin: const EdgeInsets.all(4.0),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: mainColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        date.day.toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  },
                                  todayBuilder: (context, date, events) => Container(
                                    margin: const EdgeInsets.all(4.0),
                                    alignment: Alignment.center,
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                holidayPredicate: (day) { //TODO: 홀리데이 설정하는거임.
                                  for(int i = 0; i < controller.holyday.length; i++){
                                    if(controller.holyday[i].year == day.year && controller.holyday[i].month == day.month && controller.holyday[i].day == day.day){
                                      return true;
                                    }
                                  }
                                  return false;
                                },
                                headerStyle: HeaderStyle(
                                  titleCentered: true,
                                  formatButtonVisible: false,
                                  titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                                  leftChevronIcon: Icon(Icons.chevron_left, color: mainColor),
                                  rightChevronIcon: Icon(Icons.chevron_right, color: mainColor),
                                ),
                                calendarStyle: CalendarStyle(
                                  rangeEndTextStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                                  defaultTextStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                                  weekendTextStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                                  holidayTextStyle: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w400,),
                                  holidayDecoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  todayTextStyle: const TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.w400),
                                  todayDecoration: const BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  selectedTextStyle: const TextStyle(fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                                  selectedDecoration: BoxDecoration(
                                    color: mainColor,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: 29,
                      left: 28,
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text('휴무', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: gray700),),
                          SizedBox(width: 20,),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: mainColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text('예약', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: gray700),),
                        ],

                      )
                  )
                ],
              ),
            ),
            SizedBox(height: 40,),
            Container(
              width: 800,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() => Row(
                    children: [
                      Text(
                        '${controller.selectedDay.value.month}월',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 17,),
                      controller.isHolyDay(controller.selectedDay.value) ? Text('휴무일', style: TextStyle(color: Colors.red, fontSize: 17, fontWeight: FontWeight.w500),) : Container(),
                    ],
                  ),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStatePropertyAll(Size(99, 36)),
                        backgroundColor: WidgetStatePropertyAll(Color(0xffF6F6F9)),
                      ),
                      onPressed: (){
                        controller.isReservationExist = !controller.isReservation(controller.selectedDay.value);
                        controller.holydayDialog(context, !controller.isHolyDay(controller.selectedDay.value));
                      },
                      child: Text(
                        '휴무일 지정',
                        style: TextStyle(
                            fontSize: 15,
                            color: typoColor,
                            fontWeight: FontWeight.w600
                        ),
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: 28,),
            Obx(() => Container(
              width: 800,
              height: controller.reservationList.where((element) =>
                  element.createDate.year == controller.selectedDay.value.year
                  && element.createDate.month == controller.selectedDay.value.month
                  && element.createDate.day == controller.selectedDay.value.day).length == 0 ? 207
                  : null,
              decoration: controller.reservationList.where((element) =>
                  element.createDate.year == controller.selectedDay.value.year
                  && element.createDate.month == controller.selectedDay.value.month
                  && element.createDate.day == controller.selectedDay.value.day).length == 0
                  ? BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xffF6F6F9),
              )
                  : null,
              child: controller.reservationList.where((element) =>
                  element.createDate.year == controller.selectedDay.value.year
                  && element.createDate.month == controller.selectedDay.value.month
                  && element.createDate.day == controller.selectedDay.value.day).length == 0 ? Center(child: Text('예약 내역이 없습니다.'),)
                  : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.reservationList.where((element) =>
                      element.createDate.year == controller.selectedDay.value.year
                      && element.createDate.month == controller.selectedDay.value.month
                      && element.createDate.day == controller.selectedDay.value.day).length,
                  // padding: EdgeInsets.only(top: 20),
                  itemBuilder: (context, index) {
                    if(controller.reservationList == []){
                      return CircularProgressIndicator();
                    }
                    ReservationList reservation = controller.reservationList.where((element) =>
                        element.createDate.year == controller.selectedDay.value.year
                        && element.createDate.month == controller.selectedDay.value.month
                        && element.createDate.day == controller.selectedDay.value.day).toList()[index];
                    return Container(
                      width: 800,
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: gray100),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(

                            title: Row(
                              children: [
                                Text(
                                  reservation.createDate.toString().substring(11, 16),
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: typoColor
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                ),
                                SizedBox(width: 37),
                                Text(
                                  reservation.name,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                                SizedBox(width: 37),
                                Text(
                                  reservation.hp,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.clip,
                                ),
                              ],
                            ),
                            children: [
                              Container(
                                  height: 100,
                                  width: 800,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          width: 542,
                                          height: 93,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                              color: Color(0xffF5FCFB)
                                          ),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Image(image: AssetImage('images/edit_square.png')),
                                              SizedBox(width: 20,),
                                              SingleChildScrollView(
                                                child: Container(
                                                  width: 450,
                                                  child: Text(
                                                    reservation.request,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w500,
                                                        color: typoColor,
                                                        height: 1.5

                                                    ),
                                                    softWrap: true,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 10,
                                        bottom: 0,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                              minimumSize: WidgetStatePropertyAll(Size(77, 40)),
                                              backgroundColor: WidgetStatePropertyAll(Color(0xff19B795)),
                                              shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))),
                                            ),
                                            onPressed: (){
                                              controller.cancelReservationDialog(context, reservation.documentId);
                                            },
                                            child: Text(
                                                '예약 취소'
                                            )
                                        ),
                                      )
                                    ],
                                  )
                              )
                            ],
                            onExpansionChanged: (expanded) {
                              controller.setExpanded(expanded);
                            }
                        ),
                      ),
                    );
                  }
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
