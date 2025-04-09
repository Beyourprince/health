import { CommonConstants } from "../../common/constants/CommonConstants"
import BindSheetHeader from "./BindSheetHeader"
import ItemCard from "./ItemCard"
import NumberKeyboards from "./NumberKeyboards"

@Component
struct BindSheetBuilder {
  @State amount: number = 1
  @State value: string = ''
  @Link showPanel: boolean

  build() {
    Column() {
      // 1.顶部日期时间选择
      BindSheetHeader()
      //2.记录项卡片
      ItemCard({ amount: this.amount })
      // 3.数字键盘
      NumberKeyboards({ amount: this.amount, value: this.value })

      Row({ space: CommonConstants.SPACE_6 }) {
        Button('取消')
          .width(120)
          .backgroundColor($r('app.color.light_gray'))
          .type(ButtonType.Normal)
          .borderRadius(6)
          .onClick(() => this.showPanel = false)
        Button('提交')
          .width(120)
          .backgroundColor($r('app.color.primary_color'))
          .type(ButtonType.Normal)
          .borderRadius(6)
          .onClick(() => {
            //1.持久化保存
            // 确保 this.item 不是 null


          })
      }.margin({ top: 10 })
    }
    .width('100%')
  }
}

export default BindSheetBuilder