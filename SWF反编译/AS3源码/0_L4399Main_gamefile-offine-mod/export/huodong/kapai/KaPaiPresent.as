package export.huodong.kapai
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import mvc.controllor.RandomControllor;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   
   public class KaPaiPresent extends Sprite
   {
       
      
      public var xbtn:SimpleButton;
      
      public var lqbtn1:SimpleButton;
      
      public var lqbtn2:SimpleButton;
      
      public var gbtn:SimpleButton;
      
      private var urlLoader:URLLoader;
      
      private var gc:Config;
      
      private var presentType:uint = 9;
      
      public function KaPaiPresent()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         xbtn.addEventListener("click",xClick);
         lqbtn1.addEventListener("click",lq1Click);
         lqbtn2.addEventListener("click",lq2Click);
         gbtn.addEventListener("click",gClick);
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         lqbtn1.removeEventListener("click",lq1Click);
         lqbtn2.removeEventListener("click",lq2Click);
         gbtn.removeEventListener("click",gClick);
      }
      
      private function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-54081100"),"_blank");
      }
      
      private function lq1Click(e:MouseEvent) : void
      {
         this.presentType = 9;
         if(gc.dataObject.hasGetKaPai_9_Activity == true || gc.dataObject.hasGetKaPai_9_Activity == "true")
         {
            gc.ts.setTxt("该存档已经领取过普通礼包！");
            gc.stage.addChild(gc.ts);
            return;
         }
         this.lqClick();
      }
      
      private function lq2Click(e:MouseEvent) : void
      {
         this.presentType = 1;
         if(gc.dataObject.hasGetKaPai_1_Activity == true || gc.dataObject.hasGetKaPai_1_Activity == "true")
         {
            gc.ts.setTxt("该存档已经领取过豪华礼包！");
            gc.stage.addChild(gc.ts);
            return;
         }
         this.lqClick();
      }
      
      private function lqClick() : void
      {
         if(this.judgeBackPack())
         {
            return;
         }
         gc.addActionMask("renewalse");
         urlLoader = new URLLoader();
         urlLoader.dataFormat = "text";
         urlLoader.addEventListener("complete",completeHandler);
         urlLoader.addEventListener("ioError",errorHandle);
         urlLoader.addEventListener("securityError",errorHandle);
         var urlReuest:URLRequest = new URLRequest("https://huodong2.4399.com/2016/xdkp/api.php?uid=" + gc.logInfo.uid + "&type=" + this.presentType);
         urlLoader.load(urlReuest);
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
         if(urlLoader.data == 1)
         {
            if(this.presentType == 9)
            {
               this.getNormalPresent();
               gc.dataObject.hasGetKaPai_9_Activity = true;
            }
            else
            {
               this.getHaoHuaPresent();
               gc.dataObject.hasGetKaPai_1_Activity = true;
            }
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
         else
         {
            gc.ts.setTxt("该账号不能领取，快去参加活动吧！");
            gc.stage.addChild(gc.ts);
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
            if(this.presentType == 9)
            {
               if(gc.player1.getSomeOneEquipNumberByName("wpslz") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(gc.player1.getSomeOneEquipNumberByName("wpqhs3") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
               {
                  str += "道具栏已满 ";
               }
            }
            else if(gc.player1.zblist.length >= gc.player1.getMax())
            {
               str += "装备栏已满  ";
            }
            if(gc.player1.szlist.length >= gc.player1.getMax())
            {
               str += "时装栏已满  ";
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
               if(this.presentType == 9)
               {
                  if(gc.player2.getSomeOneEquipNumberByName("wpslz") <= 0 && gc.player2.djlist.length >= gc.player1.getMax())
                  {
                     str += "道具栏已满 ";
                  }
                  if(gc.player2.getSomeOneEquipNumberByName("wpqhs3") <= 0 && gc.player2.djlist.length >= gc.player1.getMax())
                  {
                     str += "道具栏已满 ";
                  }
               }
               else if(gc.player2.zblist.length >= gc.player2.getMax())
               {
                  str += "装备栏已满  ";
               }
               if(gc.player2.szlist.length >= gc.player2.getMax())
               {
                  str += "时装栏已满  ";
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
      
      protected function getNormalPresent() : void
      {
         var smsrsz:* = null;
         smsrsz = null;
         if(gc.player1.roleid > 0)
         {
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(smsrsz);
            gc.player1.petsAry.push(this.getBhPet());
            gc.putQhsInBackPack(gc.player1,"wpslz",1);
            gc.putQhsInBackPack(gc.player1,"wpqhs3",1);
         }
         if(gc.player2.roleid > 0)
         {
            smsrsz = gc.allEquip.findByName("yxsmsrsz");
            smsrsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(smsrsz);
            gc.player2.petsAry.push(this.getBhPet());
            gc.putQhsInBackPack(gc.player2,"wpslz",1);
            gc.putQhsInBackPack(gc.player2,"wpqhs3",1);
         }
         gc.ts.setTxt("成功领取 神秘商人时装x1、白虎宝宝x1、水灵珠x1、3级强化石x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      protected function getHaoHuaPresent() : void
      {
         var gcxdyy:* = null;
         var nmwsz:* = null;
         nmwsz = null;
         if(gc.player1.roleid > 0)
         {
            gc.player1.petsAry.push(this.getJPQLPet());
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player1.zblist.push(gcxdyy);
            gc.player1.zblist.push(gc.allEquip.findByName("_4399zswj"));
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player1.szlist.push(nmwsz);
         }
         if(gc.player2.roleid > 0)
         {
            gc.player2.petsAry.push(this.getJPQLPet());
            gcxdyy = gc.allEquip.findByName("yyzlj");
            gcxdyy.setEupdata(2.4);
            gc.player2.zblist.push(gcxdyy);
            gc.player2.zblist.push(gc.allEquip.findByName("_4399zswj"));
            nmwsz = gc.allEquip.findByName("ptnmwsz");
            nmwsz.setFashionTime(gc.dataObjectInstance.curDate);
            gc.player2.szlist.push(nmwsz);
         }
         gc.ts.setTxt("成功领取 青龙宝宝x1、阴阳斩龙剑x1、忠实玩家头衔x1、牛魔王时装x1",2.5,24);
         gc.stage.addChild(gc.ts);
      }
      
      private function getBhPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("tigress1",1);
         pif.setperception(4);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1400);
         pif.setmpQuality(1000);
         pif.setatkQuality(1400);
         pif.setdefQuality(600);
         pif.setHp(500);
         pif.setMp(150);
         pif.setAtk(30);
         pif.setDef(8);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
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
      }
   }
}
