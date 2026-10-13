package export.huodong.nuandong
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
   
   public class NuanDongPresent extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function NuanDongPresent()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-60344766"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var sign:* = null;
         var urlReuest:* = null;
         if(gc.dataObject.hasPresent2019_nuandong == true || gc.dataObject.hasPresent2019_nuandong == "true")
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
            sign = MD5.hash(1 + cid + "asdf%g$d#c@d");
            urlReuest = new URLRequest("https://huodong2.4399.com/2019/nddps/api/ajax.php?act=provingCode&type=1&code=" + cid + "&sign=" + sign);
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
         if(urlLoader.data == "1" || urlLoader.data == 1)
         {
            gc.dataObject.hasPresent2019_nuandong = true;
            this.getPresent();
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else if(urlLoader.data == 2)
         {
            gc.ts.setTxt("校对码不正确");
            gc.stage.addChild(gc.ts);
         }
         else if(urlLoader.data == 3)
         {
            gc.ts.setTxt("游戏编号不存在");
            gc.stage.addChild(gc.ts);
         }
         else if(urlLoader.data == 4)
         {
            gc.ts.setTxt("激活码不存在");
            gc.stage.addChild(gc.ts);
         }
         else if(urlLoader.data == 5)
         {
            gc.ts.setTxt("已经被领取");
            gc.stage.addChild(gc.ts);
         }
         else if(urlLoader.data == 6)
         {
            gc.ts.setTxt("活动时间已过");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function getPresent() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"wphlz",1);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gc.putQhsInBackPack(gc.player1,"wplvdyl",3);
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"wphlz",1);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
            gc.putQhsInBackPack(gc.player2,"wplvdyl",3);
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 4399忠实玩家头衔x1、火灵珠x1、云阳板x1、龙女的眼泪x3",2.5,22);
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
