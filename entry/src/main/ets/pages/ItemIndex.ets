import { router } from '@kit.ArkUI'
import { CommonConstants } from '../common/constants/CommonConstants'
import ItemList from '../view/item/ItemList'

@Entry
@Component
struct ItemIndex {

  build() {
    Column() {
      // 1.头部导航
      this.Header()
      // 2.列表
      ItemList()

    }
    .height('100%')
    .width('100%')
  }

  @Builder
  Header() {
    Row() {
      Image($r('app.media.ic_public_back'))
        .width(30)
        .onClick(() => router.back())
      Blank()
      Text('早餐')
        .fontSize(18)
        .fontWeight(CommonConstants.FONT_WEIGHT_600)
    }
    .width(CommonConstants.THOUSANDTH_940)
    .height(32)
  }
}