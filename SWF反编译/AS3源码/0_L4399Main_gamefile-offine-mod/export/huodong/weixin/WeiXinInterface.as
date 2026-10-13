package export.huodong.weixin
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
   import mvc.controllor.RandomControllor;
   import petInfo.PetInfo;
   
   public class WeiXinInterface extends Sprite
   {
       
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      public var xbtn:SimpleButton;
      
      public var lqbtn:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      public var dhtxt:TextField;
      
      public function WeiXinInterface()
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
         gbtn.visible = false;
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         lqbtn.removeEventListener("click",lqClick);
      }
      
      private function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://huodong.4399.com/2013/weixin"),"_blank");
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
            if(gc.player1.getSomeOneEquipNumberByName("nianqld") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(gc.gameVip.getVipLevel() >= 3)
            {
               if(gc.player1.petsAry.length >= 10)
               {
                  str += "宠物栏已满";
               }
            }
            else if(gc.player1.petsAry.length >= 5)
            {
               str += "宠物栏已满";
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
               if(gc.player2.getSomeOneEquipNumberByName("nianqld") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(gc.gameVip.getVipLevel() >= 3)
               {
                  if(gc.player2.petsAry.length >= 10)
                  {
                     str += "宠物栏已满";
                  }
               }
               else if(gc.player2.petsAry.length >= 5)
               {
                  str += "宠物栏已满";
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
         var urlReuest:* = null;
         if(gc.dataObject.hasGetWeiXinActivity == true || gc.dataObject.hasGetWeiXinActivity == "true")
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
            urlReuest = new URLRequest("https://huodong.4399.com/weixin/zmxy/api.php?game=zmxy&code=" + cid);
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
            gc.dataObject.hasGetWeiXinActivity = true;
            gc.ts.setTxt("领取成功");
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
            gc.putQhsInBackPack(gc.player1,"nianqld",1);
            gc.player1.petsAry.push(this.getPetInfo());
         }
         if(gc.player2.roleid > 0)
         {
            gc.putQhsInBackPack(gc.player2,"nianqld",1);
            gc.player2.petsAry.push(this.getPetInfo());
         }
      }
      
      private function getPetInfo() : Object
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("nian1",1);
         pif.setperception(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.three));
         pif.setwarpower(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
         pif.settechnique(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
         pif.sethpQuality((1000 + Math.round(RandomControllor.getIns().getRandom() * 500)) * 1.3);
         pif.setmpQuality((100 + Math.round(RandomControllor.getIns().getRandom() * 100)) * 1.3);
         pif.setatkQuality((800 + Math.round(RandomControllor.getIns().getRandom() * 400)) * 1.3);
         pif.setdefQuality((100 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
         pif.setHp(500 + Math.round(RandomControllor.getIns().getRandom() * 500));
         pif.setMp(200 + Math.round(RandomControllor.getIns().getRandom() * 200));
         pif.setAtk(30 + Math.round(RandomControllor.getIns().getRandom() * 30));
         pif.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5));
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
