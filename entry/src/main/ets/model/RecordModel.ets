import { ColumnInfo, ColumnType } from '../common/bean/ColumnInfo'
import RecordPO ,{RecordPOInterFace}from '../common/bean/RecordPO'
import DbUtil from '../common/utils/DbUtil'
import relationalStore from '@ohos.data.relationalStore'
import { RecordTypeEnum } from './RecordTypeModel'
import DateUtil from '../common/utils/DateUtil'

const TABLE_NAME = 'record'

const CREATE_TABLE_SQL: string = `
 CREATE TABLE IF NOT EXISTS ${TABLE_NAME} (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   type_id INTEGER NOT NULL,
   item_id INTEGER NOT NULL,
   amount DOUBLE NOT NULL,
   create_time INTEGER NOT NULL
 )
 `

const COLUMNS: ColumnInfo[] = [
  { name: 'id', columnName: 'id', type: ColumnType.LONG },
  { name: 'typeId', columnName: 'type_id', type: ColumnType.LONG },
  { name: 'itemId', columnName: 'item_id', type: ColumnType.LONG },
  { name: 'amount', columnName: 'amount', type: ColumnType.DOUBLE },
  { name: 'createTime', columnName: 'create_time', type: ColumnType.LONG },
]


class RecordModel {
  getCreateSql() {
    return CREATE_TABLE_SQL
  }

  insert(record: RecordPOInterFace) {
    return DbUtil.insert(TABLE_NAME, record, COLUMNS)
  }

  deleteById(id: number) {
    const p = new relationalStore.RdbPredicates(TABLE_NAME)
    p.equalTo('id', id)
    return DbUtil.delete(p)
  }

  listByDate(date: number): Promise<RecordPO[]> {
    if (DbUtil.isInited()) {
      const p = new relationalStore.RdbPredicates(TABLE_NAME)
      p.equalTo('create_time', date)
      return DbUtil.queryForList<RecordPO>(p, COLUMNS)
    } else {
      // 预览器上填充假数据
      return Promise.resolve(mockData())
    }
  }
}

function mockData(): RecordPO[] { // 显式声明函数返回类型
  // 确保 createTime 是 number（时间戳）
  const createTime: number =DateUtil.beginTimeOfDay(new Date()) as number;

  const mockItems: RecordPOInterFace[] = [
    {
      id: 1,
      typeId: RecordTypeEnum.BREAKFAST, // 显式类型断言
      itemId: 0,
      amount: 1,
      createTime: createTime
    } ,
    {
      id: 2,
      typeId: RecordTypeEnum.BREAKFAST,
      itemId: 2,
      amount: 2,
      createTime: createTime
    } ,
    {
      id: 3,
      typeId: RecordTypeEnum.WORKOUT,
      itemId: 0,
      amount: 1,
      createTime: createTime
    }
  ];
  return mockItems;
}

const recordModel = new RecordModel()

export default recordModel as RecordModel