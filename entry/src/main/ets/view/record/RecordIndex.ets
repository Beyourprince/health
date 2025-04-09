import RecordList from "./RecordList"
import SearchHeader from "./SearchHeader"
import StatsCard from "./StatsCard"

@Component
struct RecordIndex {
  build() {
    Column() {
      SearchHeader()
      StatsCard()
      RecordList()
    }.width('100%')
    .height('100%')
    .backgroundColor($r('app.color.index_page_background'))
  }
}

export default RecordIndex