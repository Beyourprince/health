import { CommonConstants } from "../../common/constants/CommonConstants"
@CustomDialog
struct UserPrivacyDialog {
  controller:CustomDialogController
  confrim?:()=>void
  cancle?:()=>void
  build() {
     Column(){
       Text($r('app.string.user_privacy_title')).fontSize(20).fontWeight(CommonConstants.FONT_WEIGHT_700)

       Text($r('app.string.user_privacy_content'))

       Button($r('app.string.agree_label')).width(150).backgroundColor($r('app.color.primary_color'))
         .onClick(()=>{
           this.confrim&&this.confrim()
           this.controller.close()
         })
       Button($r('app.string.refuse_label')).width(150).backgroundColor($r('app.color.light_gray'))
         .onClick(()=>{
           this.cancle&&this.cancle()
           this.controller.close()
         })
     }.width('100%')
    .padding(10)
  }
}
export  default UserPrivacyDialog