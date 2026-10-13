package export.huodong.present2019
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
   import my.MyEquipObj;
   
   public class XiaoYouXiPresent2019 extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function XiaoYouXiPresent2019()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-59854056"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlReuest:* = null;
         if(gc.dataObject.hasPresent2019_xiaoyouxi == true || gc.dataObject.hasPresent2019_xiaoyouxi == "true")
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
            urlReuest = new URLRequest("https://huodong2.4399.com/comm/zmxy3/api.php?cid=18&code=" + cid);
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
         var ary:Array = String(urlLoader.data).split("|");
         if(ary[0] == "1")
         {
            this.getGameBoxPresent();
            gc.dataObject.hasPresent2019_xiaoyouxi = true;
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            if(ary[1] == "01")
            {
               gc.ts.setTxt("未登录");
            }
            else if(ary[1] == "02")
            {
               gc.ts.setTxt("参数有误");
            }
            else if(ary[1] == "03")
            {
               gc.ts.setTxt("同一帐号连续错误超过20次");
            }
            else if(ary[1] == "04")
            {
               gc.ts.setTxt("该存档已经兑换过");
            }
            else if(ary[1] == "05")
            {
               gc.ts.setTxt("兑换码未领过");
            }
            else if(ary[1] == "06")
            {
               gc.ts.setTxt("已过期");
            }
            else if(ary[1] == "07")
            {
               gc.ts.setTxt("兑换码已被其他人领取");
            }
            else if(ary[1] == "08")
            {
               gc.ts.setTxt("已过期");
            }
            else
            {
               gc.ts.setTxt("其它错误");
            }
            gc.stage.addChild(gc.ts);
         }
      }
      
      protected function getGameBoxPresent() : void
      {
         var gcxdyy:* = null;
         var equip:* = null;
         equip = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"sms2",1);
            gc.putQhsInBackPack(gc.player1,"wplvdyl",3);
            equip = gc.allEquip.findByName("_lsyxpt");
            gc.player1.zblist.push(equip);
            gcxdyy = gc.allEquip.findByName("dkhl");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"sms2",1);
            gc.putQhsInBackPack(gc.player2,"wplvdyl",3);
            equip = gc.allEquip.findByName("_lsyxpt");
            gc.player2.zblist.push(equip);
            gcxdyy = gc.allEquip.findByName("dkhl");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
         }
         gc.ts.setTxt("成功领取 2级生命石x1、龙女的眼泪x3、乱世英雄头衔x1、地魁花篮x1",2.5,22);
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
