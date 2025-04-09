import { CommonConstants } from '../../common/constants/CommonConstants'
import DatePickerDialog from './DatePickDialog'
import DateUtil from '../../common/utils/DateUtil'
import CalorieStats from './CalorieStats'
import NurtrientStats from './NutrientStats'

@Component
struct StatsCard {
  @StorageProp('selectedDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  controller: CustomDialogController = new CustomDialogController({
    builder: DatePickerDialog({ selectedDate: new Date(this.selectedDate),datakey:'selectedDate' })
  })

  build() {
    Column() {
      Row() {
        Text(DateUtil.formatDate(this.selectedDate))
        Image($r('app.media.ic_public_spinner'))
          .width(20)
          .fillColor($r('app.color.secondary_color'))
      }.padding(CommonConstants.SPACE_8)
      .width(CommonConstants.THOUSANDTH_940)
      .justifyContent(FlexAlign.Center)
      .onClick(() => {
        this.controller.open()
      })

      Swiper() {
        //热量统计
        CalorieStats()
        NurtrientStats()
      }.width('100%')
      .backgroundColor(Color.White)
      .borderRadius(CommonConstants.DEFAULT_18)
      .indicator(new DotIndicator().selectedColor($r('app.color.primary_color')))
    }
    .width(CommonConstants.THOUSANDTH_940)
    .backgroundColor($r('app.color.stats_title_bgc'))
    .borderRadius(CommonConstants.DEFAULT_18)
  }
}

export default StatsCard