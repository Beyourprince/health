import { CommonConstants } from '../../common/constants/CommonConstants'
import App from '@system.app'

@CustomDialog
struct DatePickerDialog {
  controller: CustomDialogController
  selectedDate: Date = new Date()
  datakey:string=''

  build() {
    Column() {
      DatePicker({
        start: new Date('2020-01-01'),
        end: new Date(),
        selected: this.selectedDate
      })
        .onDateChange((value: Date) => {
          this.selectedDate = value
          console.info('select current date is: ' + value.toString())
        })

      Row({ space: CommonConstants.SPACE_12 }) {
        Button('取消').width(120).backgroundColor($r('app.color.light_gray'))
          .onClick(() => {
            this.controller.close()
          })
        Button('确定').width(120).backgroundColor($r('app.color.primary_color'))
          .onClick(() => {
            //保存日期到全局存储
            AppStorage.setOrCreate(this.datakey, this.selectedDate.getTime())
            this.controller.close()
          })
      }
    }
  }
}

export default DatePickerDialog