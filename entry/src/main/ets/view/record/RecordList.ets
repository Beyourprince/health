import { CommonConstants } from "../../common/constants/CommonConstants"

@Extend(Text)
function myTextStyle() {
  .fontSize(14)
  .fontColor($r('app.color.light_gray'))
}

@Component
struct RecordList {
  build() {

    List({ space: CommonConstants.SPACE_10 }) {

      ForEach([1, 2, 3, 4, 5], (item: number) => {
        ListItem() {
          Column() {
            // 1.标题
            Row({ space: CommonConstants.SPACE_4 }) {
              Image($r('app.media.ic_breakfast')).width(24)
              Text('早餐').fontSize(18).fontWeight(CommonConstants.FONT_WEIGHT_700)
              Text('建议432-593千卡').myTextStyle()
              Blank()
              Text('190').fontSize(14).fontColor($r('app.color.primary_color'))
              Text('千卡').myTextStyle()
              Image($r('app.media.ic_public_add_norm_filled'))
                .width(20)
                .fillColor($r('app.color.primary_color'))
            }.width('100%')

            // 2.内容
            List() {
              ForEach([1, 2], (item: number) => {
                ListItem() {
                  Row({ space: CommonConstants.SPACE_6 }) {
                    Image($r('app.media.toast')).width(50)
                    Column({ space: CommonConstants.SPACE_4 }) {
                      Text('全麦吐司').fontWeight(CommonConstants.FONT_WEIGHT_500)
                      Text('1片').myTextStyle()
                    }

                    Blank()
                    Text('91千卡').myTextStyle()
                  }.width('100%')
                  .padding(CommonConstants.SPACE_6)
                }.swipeAction({ end: this.deleteButton() })
              })
            }

          }
          .width('100%')
          .backgroundColor(Color.White)
          .borderRadius(CommonConstants.DEFAULT_18)
          .padding(CommonConstants.SPACE_12)
        }
      })
    }.width(CommonConstants.THOUSANDTH_940)
    .margin({ top: 10 })

  }

  @Builder
  deleteButton() {
    Image($r('app.media.ic_public_delete_filled'))
      .width(20)
      .fillColor(Color.Red)
      .margin(5)
  }
}

export default RecordList