package export.huodong.weixin
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
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import my.MyEquipObj;
   
   public class WuyiBaoXiaoPresent extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function WuyiBaoXiaoPresent()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-58864727"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var userId:* = undefined;
         var urlReuest:* = null;
         if(gc.dataObject.hasWuYiBaoXiaoSjActivity == true || gc.dataObject.hasWuYiBaoXiaoSjActivity == "true")
         {
            gc.ts.setTxt("该存档已经领取过！");
            gc.stage.addChild(gc.ts);
            return;
         }
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
            userId = gc.getLocalUserId();
            urlReuest = new URLRequest("https://huodong.4399.com/baoxiao/flower2018/api/ajax.php?ac=exchangecode&cid=2&code=" + cid + "&secure=" + MD5.hash(cid + "@#dfl3892$#90EDSF&%$"));
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
         var jsonData:* = JSON.parse(urlLoader.data);
         if(jsonData.result == 200)
         {
            gc.dataObject.hasWuYiBaoXiaoSjActivity = true;
            this.getGameBoxPresent();
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            gc.ts.setTxt("领取失败" + jsonData.msg);
            gc.stage.addChild(gc.ts);
         }
      }
      
      protected function getGameBoxPresent() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gc.putQhsInBackPack(gc.player1,"wptlz",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gc.putQhsInBackPack(gc.player2,"wptlz",1);
            gcxdyy = gc.allEquip.findByName("hyzzs");
            gcxdyy.setEupdata(1.6);
            gcxdyy.setWX({
               "jin":true,
               "mu":true,
               "shui":false,
               "huo":false,
               "tu":false
            });
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 大灵魂药水x1、土灵珠x1、混元珍珠伞x1",2.5,24);
         gc.stage.addChild(gc.ts);
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
