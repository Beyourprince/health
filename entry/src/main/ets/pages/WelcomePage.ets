import UserPrivacyDialog from '../view/welcome/UserPrivacyDialog'
import { common } from '@kit.AbilityKit'
import PreferenceUtil from '../common/utils/PreferenceUtil'
import { router } from '@kit.ArkUI'


@Extend(Text)
function WelPage_txt(opacity: number, fz: number = 10) {
  .opacity(opacity)
  .fontSize(fz)
  .fontColor(Color.White)
}

const PREF_KEY = 'userPrivacyKey'

@Entry
@Component
struct WelcomePage {
  context = getContext(this) as common.UIAbilityContext
  controller: CustomDialogController = new CustomDialogController({
    builder: UserPrivacyDialog({
      confrim: () => this.onConfirm(),
      cancle: () => this.exitApp()
    })
  })

  async aboutToAppear() {
    console.info('++进入页面')
    let isAgree = await PreferenceUtil.getPreferenceValue(PREF_KEY, false)
    console.info('++进入页面isAgree', isAgree)
    if (isAgree) {
      this.jumpToIndex()
    } else {
      this.controller.open()
    }

  }

  jumpToIndex() {
    console.error('++11')
    setTimeout(() => {
      router.pushUrl({
        url: 'pages/Index'
      })
    }, 1000)
  }

  onConfirm(): void {
    console.info('++ok')
    PreferenceUtil.putPreferenceValue(PREF_KEY, true)
    console.info('++oked')
    this.jumpToIndex()
  }

  exitApp(): void {
    this.context.terminateSelf()
  }

  build() {
    Column() {
      Blank()
      Image($r('app.media.home_slogan')).width('70%')
      Blank()
      Image($r('app.media.home_logo')).width(150)
      Column({ space: 5 }) {
        Row() {
          Text('黑马健康支持').WelPage_txt(0.8, 12)
          Text('IPV6')
            .border({
              style: BorderStyle.Solid,
              width: 1,
              color: Color.White,
              radius: 15
            })
            .padding({ left: 5, right: 5 })
            .WelPage_txt(0.8, 10)
          Text('网络').WelPage_txt(0.8, 12)

        }

        Text('黑马健康App希望通过软件工具的形式，精简更多用户实现身材管理')
          .WelPage_txt(0.6)
        Text('粤ICP备00000000号-666')
          .WelPage_txt(0.4)
      }.margin({ bottom: 35 })
    }
    .height('100%')
    .width('100%')
    .backgroundColor($r('app.color.welcome_page_background'))
  }
}