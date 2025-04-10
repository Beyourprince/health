/**
 * 饮食记录中的记录项，食物或者运动
 */
class RecordItem {
  id: number
  name: ResourceStr
  image: ResourceStr
  // 分类ID
  categoryId: number
  // 数量单位
  unit: ResourceStr
  // 热量
  calorie: number
  // 碳水含量，单位（克）
  carbon: number
  // 蛋白质含量，单位（克）
  protein: number
  // 脂肪含量，单位（克）
  fat: number

  constructor(id: number, name: ResourceStr, image: ResourceStr,
              categoryId: number, unit: ResourceStr, calorie: number,
              carbon: number = 0, protein: number = 0, fat: number = 0) {
    this.id = id
    this.name = name
    this.image = image
    this.categoryId = categoryId
    this.unit = unit
    this.calorie = calorie
    this.carbon = carbon
    this.protein = protein
    this.fat = fat
  }
}
export default RecordItem