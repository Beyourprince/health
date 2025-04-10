import { CommonConstants } from "../../common/constants/CommonConstants"
import BindSheetBuilder from "./BindSheetBuilder"
import RecordItem from '../../viewmodel/RecordItem'
import ItemModel from '../../model/ItemModel'
import ItemCategory from '../../viewmodel/ItemCategory'
import {FoodCategoryEnum} from  '../../model/ItemCategoryModel'
import GroupInfo from '../../viewmodel/GroupInfo'
@Extend(Text)
function myTextStyle() {
  .fontSize(14)
  .fontColor($r('app.color.light_gray'))
}

@Component
struct ItemList {
  @State showPanel: boolean = false
  @State isFood:boolean=true
  @State rowData?:RecordItem|null=null
  // 修改后的数据定义（方案1）
   private data: GroupInfo<ItemCategory, RecordItem>[] = [
    new GroupInfo(new ItemCategory(FoodCategoryEnum.STAPLE, '主食'), []),
    new GroupInfo(new ItemCategory(FoodCategoryEnum.FRUIT, '果蔬'), []),
    new GroupInfo(new ItemCategory(FoodCategoryEnum.MEAT, '肉蛋奶'), []),
    new GroupInfo(new ItemCategory(FoodCategoryEnum.NUT, '坚果'), []),
    new GroupInfo(new ItemCategory(FoodCategoryEnum.OTHER, '其它'), []),
  ];
  build() {
    Tabs() {
      TabContent() {
        this.TabContentBuilder(ItemModel.list(this.isFood))
      }.tabBar('全部')

      ForEach(ItemModel.listItemGroupByCategory(this.isFood),(group:GroupInfo<ItemCategory, RecordItem>)=>{
        TabContent(){
          this.TabContentBuilder(group.items)
        }
        .tabBar(group.type.name)
      })
    }
    .width(CommonConstants.THOUSANDTH_940)
    .height('100%')
    .barMode(BarMode.Scrollable)
  }

  @Builder
  TabContentBuilder(items:RecordItem[]) {
    List() {
      ForEach(items, (item: RecordItem) => {
        ListItem() {
          Row({ space: CommonConstants.SPACE_6 }) {
            Image(item.image).width(50)
            Column({ space: CommonConstants.SPACE_4 }) {
              Text(item.name).fontWeight(CommonConstants.FONT_WEIGHT_500)
              Text(`${item.calorie}千卡/${item.unit}`).myTextStyle()
            }

            Blank()
            Image($r('app.media.ic_public_add_norm_filled')).width(20)
              .fillColor($r('app.color.primary_color'))
              .onClick(() => {
                this.rowData=item
                this.showPanel=true

                console.info('+++imgclick',JSON.stringify(item))

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
    BindSheetBuilder({showPanel:this.showPanel,paramsData:$rowData})

  }
}

export default ItemList