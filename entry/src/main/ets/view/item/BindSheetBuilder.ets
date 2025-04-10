import { CommonConstants } from "../../common/constants/CommonConstants"
import BindSheetHeader from "./BindSheetHeader"
import ItemCard from "./ItemCard"
import NumberKeyboards from "./NumberKeyboards"
import RecordItem from '../../viewmodel/RecordItem'
@Component
struct BindSheetBuilder {
  @State amount: number = 1
  @State value: string = ''
  @Link showPanel: boolean;
  @Link paramsData:RecordItem;

  build() {
    Column() {
      // 1.顶部日期时间选择
      BindSheetHeader()
      //2.记录项卡片
      ItemCard({ amount: this.amount,item:this.paramsData })
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
            console.info('+++data',JSON.stringify(this.paramsData))


          })
      }.margin({ top: 10 })
    }
    .width('100%')
  }

}

export default BindSheetBuilder