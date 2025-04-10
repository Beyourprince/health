import BreakpointConstants from '../common/constants/BreakpointConstants';
import { CommonConstants } from '../common/constants/CommonConstants';
import BreakpointSystem from '../common/utils/BreakpointSystem';
import RecordIndex from '../view/record/RecordIndex';
import BreakpointType from '../common/bean/BreanpointType'

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  private breakpointSystem: BreakpointSystem = new BreakpointSystem()
  @StorageProp(BreakpointConstants.KEY) currentBreakpoint: string = BreakpointConstants.SM

  @Builder
  TabBarBuilder(image: ResourceStr, index: number, title: ResourceStr) {
    Column({ space: CommonConstants.SPACE_8 }) {
      Image(image)
        .width(22)
        .fillColor(this.selectColor(index))
      Text(title).fontSize(14).fontColor(this.selectColor(index))
    }
  }

  aboutToAppear(): void {
    this.breakpointSystem.register()
  }

  aboutToDisappear(): void {
    this.breakpointSystem.unregister()
  }

  selectColor(index: number) {
    return this.currentIndex === index ? $r( 'app.color.light_primary_color') : $r('app.color.gray')
  }
  isSm() {
    return this.currentBreakpoint == BreakpointConstants.SM
  }
  getBarPosition(): BarPosition {

    return new BreakpointType({
      sm: BarPosition.End,
      md: BarPosition.Start,
      lg: BarPosition.Start,
    }).getValue(this.currentBreakpoint)

  }

  build() {
    Tabs({ barPosition: BreakpointConstants.BAR_POSITION.getValue(this.currentBreakpoint)}) {
      TabContent() {
        RecordIndex()
      }.tabBar(this.TabBarBuilder($r('app.media.ic_calendar'), 0, $r('app.string.tab_record')))

      TabContent() {
        Text('发现页面')
      }.tabBar(this.TabBarBuilder($r('app.media.discover'), 1, $r('app.string.tab_discover')))

      TabContent() {
        Text('我的主页')
      }.tabBar(this.TabBarBuilder($r('app.media.ic_user_portrait'), 2, $r('app.string.tab_user')))
    }
    .height('100%')
    .width('100%')
    .onChange((index) => {
      this.currentIndex = index
    })
    .vertical(!this.isSm())
  }
}