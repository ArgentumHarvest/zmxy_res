package export.huodong.festival
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
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
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   
   public class ChildrenDay extends Sprite
   {
       
      
      private var gc:Config;
      
      private var urlLoader:URLLoader;
      
      public var xbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      private var _anti:Antiwear;
      
      public function ChildrenDay()
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this._anti.zero_point_0_2_3_4 = 0.05;
         this.addEventListener("addedToStage",added);
         this.addEventListener("removedFromStage",removed);
      }
      
      private function added(e:Event) : void
      {
         this.removeEventListener("addedToStage",added);
         xbtn.addEventListener("click",xClick);
         lqbtn.addEventListener("click",lqClick);
         gbtn.addEventListener("click",gClick);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("removedFromStage",removed);
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
         gbtn.removeEventListener("click",gClick);
      }
      
      private function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://huodong2.4399.com/2013/ertongjie/"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlVariables:* = null;
         var urlReuest:* = null;
         if(gc.dataObject.hasGetChildrenDayPresent == true || gc.dataObject.hasGetChildrenDayPresent == "true")
         {
            gc.ts.setTxt("该存档已兑换过六一礼包");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(this.judgeZBBackPack())
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
            urlVariables = new URLVariables();
            urlVariables.game = "zmxy";
            urlVariables.code = cid;
            urlReuest = new URLRequest("https://huodong2.4399.com/2013/ertongjie/api.php?" + RandomControllor.getIns().getRandom());
            urlReuest.method = "POST";
            urlReuest.data = urlVariables;
            urlLoader.load(urlReuest);
         }
      }
      
      private function judgeZBBackPack() : Boolean
      {
         var exictmask:* = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            if(gc.player1.zblist.length >= gc.player1.getMax())
            {
               bool = true;
               gc.ts.setTxt("1P装备栏已满");
               gc.stage.addChild(gc.ts);
            }
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               if(gc.player2.zblist.length >= gc.player2.getMax())
               {
                  bool = true;
                  gc.ts.setTxt("2P装备栏已满");
                  gc.stage.addChild(gc.ts);
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
         trace("urlLoader.data -->>" + urlLoader.data);
         switch(urlLoader.data + "")
         {
            case "005":
               gc.ts.setTxt("传递参数不合法");
               break;
            case "004":
               gc.ts.setTxt("激活码格式有误");
               break;
            case "003":
               gc.ts.setTxt("用户未登陆");
               break;
            case "002":
               gc.ts.setTxt("输入的激活码不正确");
               break;
            case "1":
               gc.dataObject.hasGetChildrenDayPresent = true;
               if(gc.player1.roleid > 0)
               {
                  gc.player1.zblist.push(this.randomQiQiuFB());
               }
               if(gc.player2.roleid > 0)
               {
                  gc.player2.zblist.push(this.randomQiQiuFB());
               }
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
               gc.ts.setTxt("领取成功");
         }
         gc.stage.addChild(gc.ts);
      }
      
      private function randomQiQiuFB() : MyEquipObj
      {
         var fname:String = "hsqq";
         var random:uint = int(RandomControllor.getIns().getRandom() * 3);
         if(RandomControllor.getIns().getRandom() <= this._anti.zero_point_0_2_3_4)
         {
            if(random == 0)
            {
               fname = "csqq";
            }
            else if(random == 1)
            {
               fname = "l_sqq";
            }
            else
            {
               fname = "zsqq";
            }
         }
         else if(random == 0)
         {
            fname = "hsqq";
         }
         else if(random == 1)
         {
            fname = "h_sqq";
         }
         else
         {
            fname = "lsqq";
         }
         return gc.allEquip.findByName(fname);
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
