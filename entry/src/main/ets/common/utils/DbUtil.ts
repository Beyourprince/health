import relationalStore from '@ohos.data.relationalStore'
import common from '@ohos.app.ability.common'
import Logger from './Logger'
import { ColumnInfo, ColumnType } from '../bean/ColumnInfo'

const DB_FILENAME: string = 'healthy.db'

class DbUtil {
  rdbStore: relationalStore.RdbStore

  initDB(context: common.UIAbilityContext): Promise<void> {
    let config: relationalStore.StoreConfig = {
      name: DB_FILENAME,
      securityLevel: relationalStore.SecurityLevel.S1
    }
    return new Promise((resolve, reject) => {
      relationalStore.getRdbStore(context, config)
        .then(rdbStore => {
          this.rdbStore = rdbStore
          Logger.debug('rdbStore 初始化完成！')
          resolve()
        })
        .catch(reason => {
          Logger.error('rdbStore 初始化异常', JSON.stringify(reason))
          reject(reason)
        })
    })
  }

  isInited() {
    return !!this.rdbStore
  }

  createTable(sql: string): Promise<void> {
    return new Promise((resolve, reject) => {
      this.rdbStore.executeSql(sql)
        .then(() => {
          Logger.debug('创建成功', sql)
          resolve()
        })
        .catch(err => {
          Logger.error('创建失败,' + err.message, JSON.stringify(err))
        })
    })
  }

  insert(tableName: string, obj: any, columns: ColumnInfo[]): Promise<number> {
    return new Promise((resolve, reject) => {
      const value = this.buildValueBucket(obj, columns)
      this.rdbStore.insert(tableName, value, (err, id) => {
        if (err) {
          Logger.error('新增失败！', JSON.stringify(err))
          reject(err)
        } else {
          Logger.debug('新增成功！新增id：', id.toString())
          resolve(id)
        }
      })
    })
  }

  delete(predicates: relationalStore.RdbPredicates): Promise<number> {
    return new Promise((resolve, reject) => {
      this.rdbStore.delete(predicates, (err, rows: number) => {
        if (err) {
          Logger.error('删除失败！', JSON.stringify(err))
          reject(err)
        } else {
          Logger.debug('删除成功！删除行数：', rows.toString())
          resolve(rows)
        }
      })
    })
  }

  queryForList<T>(predicates: relationalStore.RdbPredicates, columns: ColumnInfo[]): Promise<T[]> {
    return new Promise((resolve, reject) => {
      if (!this.rdbStore) {
        Logger.error('预览器上没有初始化 rdbStore: ' + this.rdbStore)
        resolve([])
        return
      }
      this.rdbStore.query(predicates, columns.map(info => info.columnName), (err, result: relationalStore.ResultSet) => {
        if (err) {
          Logger.error('查询失败！' + JSON.stringify(err))
          reject(err)
        } else {
          Logger.debug('查询成功！查询行数：' + result.rowCount.toString())
          resolve(this.parseResultSet<T>(result, columns))
        }
      })
    })
  }

  parseResultSet<T>(result: relationalStore.ResultSet, columns: ColumnInfo[]): T[] {
    const arr = []
    if (result.rowCount <= 0) {
      return arr
    }
    while (!result.isAtLastRow) {
      result.goToNextRow()
      let obj = {}
      columns.forEach(info => {
        let val = null
        switch (info.type) {
          case ColumnType.LONG:
            val = result.getLong(result.getColumnIndex(info.columnName))
            break
          case ColumnType.DOUBLE:
            val = result.getDouble(result.getColumnIndex(info.columnName))
            break
          case ColumnType.STRING:
            val = result.getString(result.getColumnIndex(info.columnName))
            break
          case ColumnType.BLOB:
            val = result.getBlob(result.getColumnIndex(info.columnName))
            break
        }
        obj[info.name] = val
      })
      arr.push(obj)
    }
    return arr
  }

  buildValueBucket(obj: any, columns: ColumnInfo[]): relationalStore.ValuesBucket {
    const value = {}
    columns.forEach(info => {
      const val = obj[info.name]
      if (typeof val !== 'undefined') {
        value[info.columnName] = val
      }
    })
    //Logger.debug("参数数据：", JSON.stringify(value))
    return value
  }
}

const dbUtil: DbUtil = new DbUtil()

export default dbUtil as DbUtil