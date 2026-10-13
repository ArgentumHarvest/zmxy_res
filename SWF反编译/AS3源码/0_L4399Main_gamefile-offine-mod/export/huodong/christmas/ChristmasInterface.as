package export.huodong.christmas
{
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
   import my.MyEquipObj;
   
   public class ChristmasInterface extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      public var gbtn:SimpleButton;
      
      private var gc:Config;
      
      private var urlLoader:URLLoader;
      
      public function ChristmasInterface()
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
         gbtn.removeEventListener("click",gClick);
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
            if(gc.player1.szlist.length >= gc.player1.getMax())
            {
               str += "时装栏已满 ";
            }
            if(gc.player1.getSomeOneEquipNumberByName("wplvdyl") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(gc.player1.getSomeOneEquipNumberByName("sbjyd") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
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
               if(gc.player2.szlist.length >= gc.player2.getMax())
               {
                  str += "时装栏已满 ";
               }
               if(gc.player2.getSomeOneEquipNumberByName("wplvdyl") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(gc.player2.getSomeOneEquipNumberByName("sbjyd") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
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
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlVariables:* = null;
         var urlReuest:* = null;
         if(gc.dataObject.hasGetChristmasActivity == true || gc.dataObject.hasGetChristmasActivity == "true")
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
            urlVariables = new URLVariables();
            urlVariables.code = cid;
            urlVariables.game = 1;
            urlReuest = new URLRequest("https://huodong.4399.com/2013/shengdan/");
            urlReuest.method = "GET";
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
         var ary:Array = String(urlLoader.data).split("|");
         if(ary[0] == "1")
         {
            this.getPresent();
            gc.dataObject.hasGetChristmasActivity = true;
            gc.ts.setTxt("神秘商人装×1、双倍经验丹x1、龙女的眼泪下x99");
            gc.stage.addChild(gc.ts);
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            if(ary[1] == "001")
            {
               gc.ts.setTxt("活动还没开始");
            }
            else if(ary[1] == "002")
            {
               gc.ts.setTxt("活动已经结束");
            }
            else if(ary[1] == "003")
            {
               gc.ts.setTxt("未登录");
            }
            else if(ary[1] == "004")
            {
               gc.ts.setTxt("兑换码无效");
            }
            else if(ary[1] == "005")
            {
               gc.ts.setTxt("参数有误");
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
         var smsrsz:* = null;
         if(gc.player1.roleid > 0)
         {
            smsrsz = gc.allEquip.findByName("ptsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(smsrsz);
            gc.putQhsInBackPack(gc.player1,"sbjyd",1);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",99);
         }
         if(gc.player2.roleid > 0)
         {
            smsrsz = gc.allEquip.findByName("ptsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(smsrsz);
            gc.putQhsInBackPack(gc.player2,"sbjyd",1);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",99);
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
