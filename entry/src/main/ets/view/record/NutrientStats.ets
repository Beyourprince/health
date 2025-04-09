import { CommonConstants } from '../../common/constants/CommonConstants'

@Component
struct NurtrientStats {
  build() {
    Row({ space: CommonConstants.SPACE_6 }) {
      this.StateBuilder('碳水化合物',
        23,
        237,
        $r('app.color.light_primary_color')
      )
      this.StateBuilder('蛋白质', 9, 68, $r('app.color.protein_color'))
      this.StateBuilder('脂肪', 7, 53, $r('app.color.fat_color'))
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceEvenly)
    .padding({ top: 30, bottom: 35 })
  }

  @Builder
  StateBuilder(label: string, nowNu: number, maxNum: number, procol: ResourceStr) {
    Column({ space: CommonConstants.SPACE_10 }) {
      Stack() {
        Progress({
          value: nowNu,
          total: maxNum,
          type: ProgressType.Ring
        })
          .width(100)
          .style({ strokeWidth: CommonConstants.DEFAULT_10 })
          .color(procol)
        Column({ space: CommonConstants.SPACE_6 }) {
          Text('推荐摄入')
            .fontSize(12)
            .fontColor($r('app.color.gray'))
          Text(`${nowNu}/${maxNum}`)
            .fontSize(18)
            .fontWeight(CommonConstants.FONT_WEIGHT_600)


        }
      }

      Text() {
        Span(label).margin({ right: 5 })
        Span('（克）')
      }
      .fontSize(12)
      .fontWeight(CommonConstants.FONT_WEIGHT_600)
      .fontColor($r('app.color.light_gray'))
    }
  }
}

export default NurtrientStats