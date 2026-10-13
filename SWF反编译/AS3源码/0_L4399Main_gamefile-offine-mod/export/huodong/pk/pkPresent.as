package export.huodong.pk
{
   import com.adobe.crypto.MD5;
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   
   public class pkPresent extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function pkPresent()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         xbtn.addEventListener("click",xClick);
         lqbtn.addEventListener("click",lqClick);
         gbtn.addEventListener("click",gClick);
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
         gbtn.removeEventListener("click",gClick);
      }
      
      private function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-51359476.html"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlVariables:* = null;
         var token:* = null;
         var urlReuest:* = null;
         var cid:String = this.dhtxt.text;
         for(var clen:uint = cid.length; clen-- > 0; )
         {
            cid = cid.replace(" ","");
         }
         if(cid != "")
         {
            gc.addActionMask("renewalse");
            urlLoader = new URLLoader();
            urlLoader.dataFormat = "text";
            urlLoader.addEventListener("complete",completeHandler);
            urlLoader.addEventListener("ioError",errorHandle);
            urlLoader.addEventListener("securityError",errorHandle);
            urlVariables = new URLVariables();
            urlVariables.uniqueId = 1;
            urlVariables.activation = cid;
            urlVariables.uid = gc.logInfo.uid;
            token = MD5.hash(urlVariables.activation + "-" + urlVariables.uid + "-" + urlVariables.uniqueId + "-" + "14f209242c422bedc9f5655b3fa3ef69");
            urlVariables.token = token;
            urlReuest = new URLRequest("https://my.4399.com/jifen/activation?" + RandomControllor.getIns().getRandom());
            urlReuest.method = "POST";
            urlReuest.data = urlVariables;
            urlLoader.load(urlReuest);
         }
      }
      
      private function completeHandler(e:Event) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandle);
         urlLoader.removeEventListener("securityError",errorHandle);
         trace("urlLoader.data -->>" + urlLoader.data);
         var jObj:* = JSON.parse(urlLoader.data);
         switch(jObj.code + "")
         {
            case "99":
               gc.ts.setTxt("领取失败,未知错误");
               break;
            case "100":
               this.getPresent();
               break;
            case "101":
               trace("参数错误");
               gc.ts.setTxt("领取失败,参数错误");
               break;
            case "102":
               gc.ts.setTxt("领取失败,验证码不存在");
               break;
            case "103":
               trace("验证码还未被兑换");
               gc.ts.setTxt("验证码还未被兑换");
               break;
            case "104":
               gc.ts.setTxt("领取失败,验证码被使用过了");
               break;
            case "105":
               gc.ts.setTxt("领取失败,验证码只能被领取者使用");
               break;
            case "106":
               gc.ts.setTxt("领取失败,每个玩家只能领取一次，你已经领取过");
               break;
            case "107":
               gc.ts.setTxt("领取失败,token失效");
               break;
            case "108":
               gc.ts.setTxt("领取失败,激活码失效了");
               break;
            case "109":
               gc.ts.setTxt("激活失败");
               break;
            case "110":
               gc.ts.setTxt("您的账号今天已经使用过验证码，今天不能再使用");
               break;
            case "206":
               gc.ts.setTxt("您的账号今天已使用过验证码，今天不能再使用");
               break;
            default:
               gc.ts.setTxt("领取失败");
         }
         gc.stage.addChild(gc.ts);
      }
      
      private function getPresent() : void
      {
         this.pkPersent();
      }
      
      protected function pkPersent() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wpst_4",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player1,"kly3",1);
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wpst_4",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
            gc.putQhsInBackPack(gc.player2,"kly3",1);
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
         }
         gc.ts.setTxt("成功领取 四重神铁x1、3级强化石x1、3级昆仑玉x1、水灵珠x1");
         gc.stage.addChild(gc.ts);
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function errorHandle(e:Event) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         urlLoader.removeEventListener("complete",completeHandler);
         urlLoader.removeEventListener("ioError",errorHandle);
         urlLoader.removeEventListener("securityError",errorHandle);
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
