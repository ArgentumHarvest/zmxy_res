package export.huodong.dujia
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
   
   public class DujiaPresent extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function DujiaPresent()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-60016418"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var key:* = null;
         var urlReuest:* = null;
         if(gc.dataObject.dujiaPresent17 == true || gc.dataObject.dujiaPresent17 == "true")
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
            key = MD5.hash(MD5.hash("asdakjapsdfajslkjasdkWPUls" + gc.logInfo.uid + "71" + cid));
            urlReuest = new URLRequest("https://huodong.4399.com/2017/dujia/api.php?uid=" + gc.logInfo.uid + "&type=71&code=" + cid + "&key=" + key);
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
         switch(urlLoader.data + "")
         {
            case "10000":
               gc.ts.setTxt("参数填写不完整",2.5,22);
               gc.stage.addChild(gc.ts);
               break;
            case "10001":
               gc.ts.setTxt("礼包id不正确",2.5,22);
               gc.stage.addChild(gc.ts);
               break;
            case "10002":
               gc.ts.setTxt("校验码不正确",2.5,22);
               gc.stage.addChild(gc.ts);
               break;
            case "10003":
               gc.ts.setTxt("用户没有领取过相关类型的礼包",2.5,22);
               gc.stage.addChild(gc.ts);
               break;
            case "10004":
               gc.ts.setTxt("礼包的激活码没有和用户绑定，或者激活码有误",2.5,22);
               gc.stage.addChild(gc.ts);
               break;
            case "20000":
               gc.dataObject.dujiaPresent17 = true;
               this.getPresent();
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
         }
      }
      
      private function getPresent() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"gjs2",1);
            gc.putQhsInBackPack(gc.player1,"wpllz",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"gjs2",1);
            gc.putQhsInBackPack(gc.player2,"wpllz",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gcxdyy = gc.allEquip.findByName("gcxdyy");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 2级攻击石x1、雷灵珠x1、孟婆药剂x1、龟丞相遗言x1",2.5,22);
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
