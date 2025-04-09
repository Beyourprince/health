import media from '@ohos.multimedia.media'
import mediaquery from '@ohos.mediaquery'
import BreakpointConstants from '../constants/BreakpointConstants'

export default class BreakpointSystem {
  private smListener = mediaquery.matchMediaSync(BreakpointConstants.RANGE_SM)
  private mdListener = mediaquery.matchMediaSync(BreakpointConstants.RANGE_MD)
  private lgListener = mediaquery.matchMediaSync(BreakpointConstants.RANGE_LG)

  private update(bp: string) {
    AppStorage.SetOrCreate(BreakpointConstants.KEY, bp)
  }

  private smCallback(result: mediaquery.MediaQueryResult) {
    if (result.matches) {
      this.update(BreakpointConstants.SM)
    }
  }

  private mdCallback(result: mediaquery.MediaQueryResult) {
    if (result.matches) {
      this.update(BreakpointConstants.MD)
    }
  }

  private lgCallback(result: mediaquery.MediaQueryResult) {
    if (result.matches) {
      this.update(BreakpointConstants.LG)
    }
  }

  register() {
    this.smListener.on('change', this.smCallback.bind(this))
    this.mdListener.on('change', this.mdCallback.bind(this))
    this.lgListener.on('change', this.lgCallback.bind(this))
  }

  unregister() {
    this.smListener.off('change')
    this.mdListener.off('change')
    this.lgListener.off('change')
  }
}