package export.huodong.kaixue
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
   
   public class KaiXuePresent extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function KaiXuePresent()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-59266657"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlVariables:* = null;
         var token:* = null;
         var urlReuest:* = null;
         if(gc.dataObject.hasGetKaiXuePresent == true || gc.dataObject.hasGetKaiXuePresent == "true")
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
            urlVariables = new URLVariables();
            urlVariables.act = "provingCode";
            urlVariables.uid = gc.logInfo.uid;
            urlVariables.type = 1;
            urlVariables.code = cid;
            token = MD5.hash(1 + gc.logInfo.uid + cid + "asdf%g$d#c@d");
            urlVariables.sign = token;
            urlReuest = new URLRequest("https://huodong2.4399.com/baoxiao/termbegin2018/api/ajax.php");
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
         var jObj:* = JSON.parse(urlLoader.data);
         switch(urlLoader.data + "")
         {
            case "1":
               this.getPresent();
               gc.dataObject.hasGetKaiXuePresent = true;
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
               break;
            case "2":
               gc.ts.setTxt("校对码不正确");
               gc.stage.addChild(gc.ts);
               break;
            case "3":
               gc.ts.setTxt("游戏编号不存在");
               gc.stage.addChild(gc.ts);
               break;
            case "4":
               gc.ts.setTxt("激活码不存在");
               gc.stage.addChild(gc.ts);
               break;
            case "5":
               gc.ts.setTxt("已经被领取");
               gc.stage.addChild(gc.ts);
               break;
            default:
               gc.ts.setTxt("领取失败");
               gc.stage.addChild(gc.ts);
         }
      }
      
      private function getPresent() : void
      {
         var gcxdyy:* = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            gc.putQhsInBackPack(gc.player1,"dlhys",1);
            gc.putQhsInBackPack(gc.player1,"wpllz",1);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            gc.putQhsInBackPack(gc.player2,"dlhys",1);
            gc.putQhsInBackPack(gc.player2,"wpllz",1);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
         }
         gc.ts.setTxt("成功领取 4399忠实玩家头衔X1、孟婆药剂x1、大灵魂药水X1、雷灵珠X1",2.5,22);
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
