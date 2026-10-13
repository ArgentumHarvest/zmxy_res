package export.huodong.zztenyear
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   
   public class FifteenYearActivity extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function FifteenYearActivity()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-57366109"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var urlReuest:* = null;
         if(gc.dataObject.hasFifteenYearActivity == true || gc.dataObject.hasFifteenYearActivity == "true")
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
            urlReuest = new URLRequest("https://huodong2.4399.com/2017/15years/api.php?uid=" + gc.logInfo.uid + "&type=12&code=" + cid);
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
            case "0":
               gc.ts.setTxt("没参与活动",2.5,22);
               gc.stage.addChild(gc.ts);
               break;
            case "1":
               gc.dataObject.hasFifteenYearActivity = true;
               this.getGameBoxPresent();
               if(gc.isHideDebug)
               {
                  gc.memory.setStorage(gc.luanqibazaojiami.saveId);
               }
         }
      }
      
      protected function getGameBoxPresent() : void
      {
         var gcxdyy:* = null;
         var smsrsz1:* = null;
         smsrsz1 = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.zblist.push(gc.allEquip.findByName("_zmxyanniversary"));
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            smsrsz1 = gc.allEquip.findByName("jlsmsrsz");
            smsrsz1.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(smsrsz1);
            gc.player1.petsAry.push(this.getNewJPZQPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.zblist.push(gc.allEquip.findByName("_zmxyanniversary"));
            gcxdyy = gc.allEquip.findByName("yyb");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            smsrsz1 = gc.allEquip.findByName("jlsmsrsz");
            smsrsz1.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(smsrsz1);
            gc.player2.petsAry.push(this.getNewJPZQPet());
         }
         gc.ts.setTxt("成功领取 朱雀宝宝x1、云阳板x1，周年头衔x1，神秘商人装x1",2.5,22);
         gc.stage.addChild(gc.ts);
      }
      
      private function getNewJPZQPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("phoenix1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1200);
         pif.setmpQuality(1200);
         pif.setatkQuality(1400);
         pif.setdefQuality(600);
         pif.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * 250));
         pif.setMp(120 + Math.round(RandomControllor.getIns().getRandom() * 80));
         pif.setAtk(16 + Math.round(RandomControllor.getIns().getRandom() * 16));
         pif.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 4));
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
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
      }
   }
}
