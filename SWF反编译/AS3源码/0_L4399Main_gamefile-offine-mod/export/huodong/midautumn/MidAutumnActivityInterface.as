package export.huodong.midautumn
{
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
   
   public class MidAutumnActivityInterface extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      public var gbtn:SimpleButton;
      
      private var gc:Config;
      
      private var urlLoader:URLLoader;
      
      public function MidAutumnActivityInterface()
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
         gbtn.visible = false;
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlReuest:* = null;
         if(gc.dataObject.hasGetMidAutumnActivity2013 == true || gc.dataObject.hasGetMidAutumnActivity2013 == "true")
         {
            gc.ts.setTxt("该存档已经领取过！");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(this.judgeBackPack())
         {
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
            urlReuest = new URLRequest("https://huodong.4399.com/2013/zhongqiu/api.php?code=" + cid + "&gametype=zmxy");
            urlLoader.load(urlReuest);
         }
      }
      
      private function judgeBackPack() : Boolean
      {
         var str:* = null;
         str = null;
         var exictmask:* = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.player1.getSomeOneEquipNumberByName("ghyb") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               str = "2P";
               if(gc.player2.getSomeOneEquipNumberByName("ghyb") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            exictmask = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
            if(exictmask)
            {
               gc.stage.removeChild(exictmask);
               exictmask = null;
            }
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
         }
         return bool;
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
         var ary:Array = String(urlLoader.data).split("|");
         if(ary[0] == "1")
         {
            this.getPresent();
            gc.dataObject.hasGetMidAutumnActivity2013 = true;
            gc.ts.setTxt("成功领取桂花月饼×5");
            gc.stage.addChild(gc.ts);
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            if(ary[1] == "002")
            {
               gc.ts.setTxt("激活码输入有误");
            }
            else if(ary[1] == "003")
            {
               gc.ts.setTxt("没有领取激活码");
            }
            else if(ary[1] == "004")
            {
               gc.ts.setTxt("没有登录游戏");
            }
            else if(ary[1] == "005")
            {
               gc.ts.setTxt("激活码格式不正确");
            }
            else if(ary[1] == "006")
            {
               gc.ts.setTxt("传递的参数不完整");
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
            gc.putQhsInBackPack(gc.player1,"ghyb",5);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"ghyb",5);
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
      
      protected function gClick(event:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://huodong.4399.com/2013/zhongqiu/apitest.php?gametype=zmxy"),"_blank");
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
