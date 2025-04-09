export default class BreakpointConstants {
  /**
   * 屏幕设备的断点标记
   */
  static readonly SM = 'sm'
  static readonly MD = 'md'
  static readonly LG = 'lg'
  /**
   * 当前断点的存储key
   */
  static readonly KEY = 'currentBreakpoint'
  /**
   * 设备屏幕宽度范围
   */
  static readonly RANGE_SM = '(320vp<=width<600vp)'
  static readonly RANGE_MD = '(600vp<=width<840vp)'
  static readonly RANGE_LG = '(840vp<=width)'
}

// @StorageLink的参数只能是常量
export const BreakpointKey = 'currentBreakpoint'