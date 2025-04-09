import { CommonConstants } from "../../common/constants/CommonConstants"
import BindSheetBuilder from "./BindSheetBuilder"

@Extend(Text)
function myTextStyle() {
  .fontSize(14)
  .fontColor($r('app.color.light_gray'))
}

@Component
struct ItemList {
  @State showPanel: boolean = false

  build() {
    Tabs() {
      TabContent() {
        this.TabContent()
      }.tabBar('全部')

      TabContent() {
        this.TabContent()
      }.tabBar('主食')

      TabContent() {
        this.TabContent()
      }.tabBar('水果')

      TabContent() {
        this.TabContent()
      }.tabBar('蛋白质')
    }
    .width(CommonConstants.THOUSANDTH_940)
    .height('100%')
  }

  @Builder
  TabContent() {
    List() {
      ForEach([1, 2, 3, 4, 5], (item: number) => {
        ListItem() {
          Row({ space: CommonConstants.SPACE_6 }) {
            Image($r('app.media.toast')).width(50)
            Column({ space: CommonConstants.SPACE_4 }) {
              Text('全麦吐司').fontWeight(CommonConstants.FONT_WEIGHT_500)
              Text('91千卡/1片').myTextStyle()
            }

            Blank()
            Image($r('app.media.ic_public_add_norm_filled')).width(20)
              .fillColor($r('app.color.primary_color'))
              .onClick(() => {
                this.showPanel = true
              })
              .bindSheet($$this.showPanel, this.myBuilder(), {
                shouldDismiss: () => {
                  this.showPanel = false
                }
              })
          }.width('100%')
          .padding(CommonConstants.SPACE_6)
        }
      })
    }.width('100%')
    .height('100%')
  }

  @Builder
  myBuilder() {
    BindSheetBuilder({showPanel:this.showPanel})

  }
}

export default ItemList