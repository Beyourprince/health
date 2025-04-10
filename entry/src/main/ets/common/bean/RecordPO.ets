import { RecordTypeEnum } from '../../model/RecordTypeModel'
export default class RecordPO {
  /**
   * 记录id
   */
  id?: number;
  /**
   * 饮食记录类型
   */
  typeId: RecordTypeEnum;
  /**
   * 记录中的食物或运动信息
   */
  itemId: number;
  /**
   * 食物数量或运动时长，如果是运动信息则无
   */
  amount: number;
  /**
   * 时间戳
   */
  createTime: number;

  constructor(
    typeId: number,
    itemId: number,
    createTime: number,
    amount: number = 0,
    id?: number
  ) {
    this.typeId = typeId;
    this.itemId = itemId;
    this.createTime = createTime;
    this.amount = amount;
    this.id = id;
  }


}
interface RecordPOInterFace{
  /**
   * 记录id
   */
  id?: number;
  /**
   * 饮食记录类型
   */
  typeId: RecordTypeEnum;
  /**
   * 记录中的食物或运动信息
   */
  itemId: number;
  /**
   * 食物数量或运动时长，如果是运动信息则无
   */
  amount: number;
  /**
   * 时间戳
   */
  createTime: number;
}
export {RecordPOInterFace}