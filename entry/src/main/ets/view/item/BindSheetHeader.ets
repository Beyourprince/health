import { CommonConstants } from '../../common/constants/CommonConstants'
import DateUtil from '../../common/utils/DateUtil'
import DatePickerDialog from "../record/DatePickDialog"

@Extend(Text)
function myText() {
  .fontSize(18)
  .fontWeight(CommonConstants.FONT_WEIGHT_600)
}

@Component
struct BindSheetHeader {
  @StorageProp('bindSheetDate') selectedDate: number = DateUtil.beginTimeOfDay(new Date())
  controller: CustomDialogController = new CustomDialogController({
    builder: DatePickerDialog({ selectedDate: new Date(this.selectedDate), datakey: 'bindSheetDate' })
  })
  @State menuSelected: string = '早餐'

  build() {
    Row() {
      Text(DateUtil.formatDate(this.selectedDate).substring(5))
        .myText()
        .onClick(() => {
          this.controller.open()
        })
      Text(this.menuSelected).myText()
      Image($r('app.media.ic_public_spinner'))
        .width(20)
        .fillColor($r('app.color.light_gray'))
        .bindMenu([
          {
            value: '早餐',
            action: () => {
              this.menuSelected = '早餐'
            }
          },
          {
            value: '午餐',
            action: () => {
              this.menuSelected = '午餐'
            }
          },
          {
            value: '晚餐',
            action: () => {
              this.menuSelected = '晚餐'
            }
          }
        ])
    }.width('100%')
    .justifyContent(FlexAlign.Center)
  }
}

export default BindSheetHeader