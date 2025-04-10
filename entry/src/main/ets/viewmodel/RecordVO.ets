import RecordItem from './RecordItem'

/**
 * 饮食记录的页面数据模型
 */
export default class RecordVO {
  /**
   * 记录id
   */
  id: number
  /**
   * 饮食记录类型，参考 RecordTypeEnum
   */
  typeId: number
  /**
   * 卡路里总数
   */
  calorie: number
  /**
   * 记录中的食物或运动信息
   */
  recordItem: RecordItem
  /**
   * 食物数量或运动时长，如果是运动信息则无
   */
  amount: number = 0

  constructor(
    id: number,
    typeId: number,
    calorie: number,
    recordItem: RecordItem,
    amount: number = 0 // 默认值放在参数列表
  ) {
    this.id = id;
    this.typeId = typeId;
    this.calorie = calorie;
    this.recordItem = recordItem;
    this.amount = amount;
  }
}

interface RecordVOInterFace{
  /**
   * 记录id
   */
  id: number
  /**
   * 饮食记录类型，参考 RecordTypeEnum
   */
  typeId: number
  /**
   * 卡路里总数
   */
  calorie: number
  /**
   * 记录中的食物或运动信息
   */
  recordItem: RecordItem
  /**
   * 食物数量或运动时长，如果是运动信息则无
   */
  amount: number

}
export {RecordVOInterFace}