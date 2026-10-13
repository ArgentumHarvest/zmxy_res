package export.huodong.wangzi
{
   import com.adobe.crypto.MD5;
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.text.TextField;
   import flash.utils.getTimer;
   import mvc.controllor.RandomControllor;
   
   public class PrinceActivity extends Sprite
   {
       
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      public function PrinceActivity()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         xbtn.addEventListener("click",xClick);
         lqbtn.addEventListener("click",lqClick);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
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
            urlVariables.time = getTimer();
            urlVariables.uid = gc.logInfo.uid;
            urlVariables.code = cid;
            token = MD5.hash(urlVariables.code + urlVariables.time + urlVariables.uid + "2d2&d/+=fa46e8");
            urlVariables.signature = token;
            urlReuest = new URLRequest("https://my.4399.com/jifen/check-index?" + RandomControllor.getIns().getRandom());
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
            case "100":
               gc.ts.setTxt("领取成功");
               this.getPresent();
               break;
            case "99":
               gc.ts.setTxt("领取失败,参数错误");
               break;
            case "98":
               gc.ts.setTxt("领取失败,验证码无效");
               break;
            case "97":
               gc.ts.setTxt("领取失败,验证码被使用过了");
               break;
            case "96":
               gc.ts.setTxt("激活失败，请重新验证");
               break;
            default:
               gc.ts.setTxt("领取失败");
         }
         gc.stage.addChild(gc.ts);
      }
      
      private function getPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(gc.allEquip.findByName("_zmxyptxnkl"));
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            gc.putQhsInBackPack(gc.player1,"wphhd",1);
            gc.putQhsInBackPack(gc.player1,"wpdd",1);
            gc.putQhsInBackPack(gc.player1,"hsj",1);
            gc.putQhsInBackPack(gc.player1,"rls",1);
            gc.putQhsInBackPack(gc.player1,"tss",1);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player1.zblist.push(gc.allEquip.findByName("_zmxyptxnkl"));
            gc.putQhsInBackPack(gc.player1,"wpcsd",1);
            gc.putQhsInBackPack(gc.player1,"wphhd",1);
            gc.putQhsInBackPack(gc.player1,"wpdd",1);
            gc.putQhsInBackPack(gc.player1,"hsj",1);
            gc.putQhsInBackPack(gc.player1,"rls",1);
            gc.putQhsInBackPack(gc.player1,"tss",1);
         }
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
         gc.eventManger.dispatchEvent(new CommonEvent("OPEN_HUODONG_INTERFACE"));
      }
   }
}
