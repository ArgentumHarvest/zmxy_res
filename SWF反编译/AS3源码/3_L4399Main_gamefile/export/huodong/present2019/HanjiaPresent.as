package export.huodong.present2019
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
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   
   public class HanjiaPresent extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public function HanjiaPresent()
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
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-59583399"),"_blank");
      }
      
      private function lqClick(e:MouseEvent) : void
      {
         var sign:* = null;
         var urlReuest:* = null;
         if(gc.dataObject.hasPresent2019_hangjia == true || gc.dataObject.hasPresent2019_hangjia == "true")
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
            urlReuest = new URLRequest("https://huodong.4399.com/4399game/hj2018/api/ajax.php?act=provingCode&type=1&code=" + cid + "&sign=" + sign);
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
            gc.dataObject.hasPresent2019_hangjia = true;
            this.getGameBoxPresent();
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
      
      protected function getGameBoxPresent() : void
      {
         var gcxdyy:* = null;
         var equip:* = null;
         equip = null;
         if(gc.player1.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player1,"xns1",1);
            gc.putQhsInBackPack(gc.player1,"mpyj",1);
            equip = gc.allEquip.findByName("_jsyxpt");
            gc.player1.zblist.push(equip);
            gc.player1.petsAry.push(this.getJPQLPet());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"xns1",1);
            gc.putQhsInBackPack(gc.player2,"mpyj",1);
            equip = gc.allEquip.findByName("_jsyxpt");
            gc.player2.zblist.push(equip);
            gc.player2.petsAry.push(this.getJPQLPet());
         }
         gc.ts.setTxt("成功领取 救世英雄头衔X1、1级仙女石X1、孟婆药剂X1、青龙宝宝X1",2.5,22);
         gc.stage.addChild(gc.ts);
      }
      
      private function getJPQLPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("dragon1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1400);
         pif.setmpQuality(700);
         pif.setatkQuality(1400);
         pif.setdefQuality(500);
         pif.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * 200));
         pif.setMp(150 + Math.round(RandomControllor.getIns().getRandom() * 50));
         pif.setAtk(15 + Math.round(RandomControllor.getIns().getRandom() * 15));
         pif.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 6));
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
         gc.eventManger.dispatchEvent(new CommonEvent("OPEN_HUODONG_INTERFACE"));
      }
   }
}
