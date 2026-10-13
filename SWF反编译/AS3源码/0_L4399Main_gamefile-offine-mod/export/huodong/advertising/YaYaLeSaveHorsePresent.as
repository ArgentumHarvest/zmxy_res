package export.huodong.advertising
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
   import flash.net.navigateToURL;
   import flash.text.TextField;
   
   public class YaYaLeSaveHorsePresent extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function YaYaLeSaveHorsePresent()
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
            urlVariables.activation = cid;
            urlVariables.product_id = 1208;
            urlVariables.uid = gc.logInfo.uid;
            urlVariables.type = "1";
            token = MD5.hash(urlVariables.activation + urlVariables.product_id + urlVariables.type + urlVariables.uid + "ccf701884c8b8dd8ce6681243c9c6459");
            urlVariables.token = token;
            urlReuest = new URLRequest("https://my.4399.com/jifen/api-apply");
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
         if(jObj.code == 100)
         {
            this.getPresent();
         }
         else
         {
            if(jObj.msg != "")
            {
               if(jObj.code == 108)
               {
                  gc.ts.setTxt("今天的礼包已经发完，明天再来吧");
               }
               else
               {
                  gc.ts.setTxt(jObj.msg);
               }
            }
            else
            {
               gc.ts.setTxt("领取失败");
            }
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function getPresent() : void
      {
         if(gc.player1.roleid > 0)
         {
            gc.dataObject.worldtransfromTimes += 1;
            gc.putQhsInBackPack(gc.player1,"lhys");
            gc.ts.setTxt("成功领取 灵魂药水x1、世界传送x1");
            gc.stage.addChild(gc.ts);
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
      }
      
      private function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://yayale.4399.com/"),"_blank");
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
