package export.pet
{
   import config.Config;
   import event.CommonEvent;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import my.MainGame;
   import petInfo.PetInfo;
   import user.User;
   
   public class PetInterface extends Sprite
   {
       
      
      private var gc:Config;
      
      private var player:User;
      
      private var pif:PetInfo;
      
      public var btn_close:SimpleButton;
      
      public var releasebtn:SimpleButton;
      
      public var fightbtn:SimpleButton;
      
      public var restbtn:SimpleButton;
      
      public var eatimbtn:SimpleButton;
      
      public var hptxt:TextField;
      
      public var mptxt:TextField;
      
      public var atktxt:TextField;
      
      public var deftxt:TextField;
      
      public var expmc:MovieClip;
      
      public var speedtxt:TextField;
      
      public var eamptxt:TextField;
      
      public var mdeftxt:TextField;
      
      public var crittxt:TextField;
      
      public var misstxt:TextField;
      
      public var eahptxt:TextField;
      
      public var exptxt:TextField;
      
      public var qualitymc:MovieClip;
      
      public var txtname:TextField;
      
      private var pethead:PetHeadSprite;
      
      public var listtxt:TextField;
      
      public var leveltxt:TextField;
      
      public var czjnbtn:SimpleButton;
      
      public var czsxbtn:SimpleButton;
      
      public var atebtn:MovieClip;
      
      public var eipbtn:MovieClip;
      
      public var grmmc:MovieClip;
      
      private var giveupPet:Sprite;
      
      private var curPage:uint = 1;
      
      private var allPage:uint = 2;
      
      private var pageNum:uint = 5;
      
      public var prePage:SimpleButton;
      
      public var nextPage:SimpleButton;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      private var issave:Boolean = false;
      
      private var renewalse:RenewalseThisSZ;
      
      private var vipclickwhich:String = "";
      
      private var pas:PetAttributeShow;
      
      private var pbps:PetBackPackShow;
      
      private var pdi:PetDevelopInterface;
      
      public function PetInterface(_user:User)
      {
         super();
         gc = Config.getInstance();
         this.player = _user;
         giveupPet = AUtils.getNewObj("giveUpThisPet") as Sprite;
         giveupPet.name = "giveupPet";
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         atebtn.buttonMode = true;
         eipbtn.buttonMode = true;
         grmmc.buttonMode = true;
         btn_close.addEventListener("click",close);
         releasebtn.addEventListener("click",releaseClick);
         fightbtn.addEventListener("click",fightClick);
         restbtn.addEventListener("click",restClick);
         eatimbtn.addEventListener("click",eatImmor);
         prePage.addEventListener("click",prePageClick);
         nextPage.addEventListener("click",nextPageClick);
         if(this.player != gc.player3)
         {
            czjnbtn.visible = true;
            czsxbtn.visible = true;
            czjnbtn.addEventListener("click",pushPetSkill);
            czsxbtn.addEventListener("click",pushPetAttribute);
         }
         else
         {
            czjnbtn.visible = false;
            czsxbtn.visible = false;
         }
         atebtn.addEventListener("click",ateClick);
         eipbtn.addEventListener("click",eipClick);
         grmmc.addEventListener("click",groomClick);
         gc.eventManger.addEventListener("PETEQUIPMENTOVER",refreshTxt);
         gc.eventManger.addEventListener("closePetInterface",__closePetInterface);
         gc.eventManger.addEventListener("SUPEREVOLUTION",superErevol);
         atebtn.dispatchEvent(new MouseEvent("click"));
         if(gc.gameVip.getVipLevel() >= 3)
         {
            prePage.visible = true;
            nextPage.visible = true;
         }
         else
         {
            prePage.visible = false;
            nextPage.visible = false;
         }
         this.setPetList(true);
      }
      
      private function removed(e:Event) : void
      {
         btn_close.removeEventListener("click",close);
         releasebtn.removeEventListener("click",releaseClick);
         fightbtn.removeEventListener("click",fightClick);
         restbtn.removeEventListener("click",restClick);
         eatimbtn.removeEventListener("click",eatImmor);
         prePage.removeEventListener("click",prePageClick);
         nextPage.removeEventListener("click",nextPageClick);
         czjnbtn.removeEventListener("click",pushPetSkill);
         czsxbtn.removeEventListener("click",pushPetAttribute);
         atebtn.removeEventListener("click",ateClick);
         eipbtn.removeEventListener("click",eipClick);
         grmmc.removeEventListener("click",groomClick);
         gc.eventManger.removeEventListener("PETEQUIPMENTOVER",refreshTxt);
         gc.eventManger.removeEventListener("closePetInterface",__closePetInterface);
         gc.eventManger.removeEventListener("SUPEREVOLUTION",superErevol);
         this.removedPetList();
         if(gc.isSingleGame())
         {
            MainGame.getInstance().continueGame();
         }
         if(this.issave)
         {
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
      }
      
      private function ateClick(e:MouseEvent) : void
      {
         atebtn.gotoAndStop(2);
         eipbtn.gotoAndStop(1);
         grmmc.gotoAndStop(1);
         if(this.pbps && contains(this.pbps))
         {
            this.removeChild(this.pbps);
            this.pbps = null;
         }
         if(this.pdi && contains(this.pdi))
         {
            this.removeChild(this.pdi);
            this.pdi = null;
         }
         if(this.pas == null)
         {
            this.pas = new PetAttributeShow(this.pif);
            this.addChild(this.pas);
            this.pas.x = 486.55;
            this.pas.y = 113.85;
         }
      }
      
      private function eipClick(e:MouseEvent) : void
      {
         eipbtn.gotoAndStop(2);
         atebtn.gotoAndStop(1);
         grmmc.gotoAndStop(1);
         if(this.pas && contains(this.pas))
         {
            this.removeChild(this.pas);
            this.pas = null;
         }
         if(this.pdi && contains(this.pdi))
         {
            this.removeChild(this.pdi);
            this.pdi = null;
         }
         if(this.pbps == null)
         {
            this.pbps = new PetBackPackShow(this.player,this.pif);
            this.addChild(this.pbps);
            this.pbps.x = 486.55;
            this.pbps.y = 113.85;
         }
      }
      
      private function groomClick(e:MouseEvent) : void
      {
         grmmc.gotoAndStop(2);
         eipbtn.gotoAndStop(1);
         atebtn.gotoAndStop(1);
         if(this.pbps && contains(this.pbps))
         {
            this.removeChild(this.pbps);
            this.pbps = null;
         }
         if(this.pas && contains(this.pas))
         {
            this.removeChild(this.pas);
            this.pas = null;
         }
         if(this.pdi == null)
         {
            this.pdi = new PetDevelopInterface(this.pif);
            this.addChild(this.pdi);
            this.pdi.x = 486.55;
            this.pdi.y = 113.85;
         }
      }
      
      private function prePageClick(e:MouseEvent) : void
      {
         this.setCurPage(-1);
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "prePage";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function nextPageClick(e:MouseEvent) : void
      {
         this.setCurPage(1);
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "nextPage";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      public function setCurPage(cp:int) : void
      {
         var lastPage:uint = this.curPage;
         this.curPage += cp;
         if(this.curPage > this.allPage)
         {
            this.curPage = this.allPage;
         }
         if(this.curPage < 1)
         {
            this.curPage = 1;
         }
         if(this.curPage != lastPage)
         {
            this.setPetList();
         }
      }
      
      private function setPetList(isShowFlight:Boolean = false) : void
      {
         var flightPetList:* = null;
         var i:* = 0;
         var petList:* = null;
         this.removedPetList();
         this.setTitleTxt();
         for(i = uint(0); i < 5; )
         {
            petList = AUtils.getNewObj("petlist") as Sprite;
            petList.buttonMode = true;
            if(this.player.petsAry[i + (curPage - 1) * 5] != undefined)
            {
               if(this.player.petsAry[i + (curPage - 1) * 5].isFight == 1)
               {
                  petList["petname"].text = this.player.petsAry[i + (curPage - 1) * 5].getPetChinaName() + "(出战)";
                  flightPetList = petList;
               }
               else
               {
                  petList["petname"].text = this.player.petsAry[i + (curPage - 1) * 5].getPetChinaName();
               }
               petList.name = "petlist" + i;
               petList.x = 349.85;
               petList.y = 142.5 + i * petList.height + 5;
               this.addChild(petList);
               petList.addEventListener("click",plClick);
            }
            i++;
         }
         if(isShowFlight)
         {
            if(flightPetList)
            {
               flightPetList.dispatchEvent(new MouseEvent("click"));
            }
         }
      }
      
      private function removedPetList() : void
      {
         var i:* = 0;
         for(i = uint(0); i < 5; )
         {
            if(this.getChildByName("petlist" + i))
            {
               this.getChildByName("petlist" + i).removeEventListener("click",plClick);
               this.removeChild(this.getChildByName("petlist" + i));
            }
            i++;
         }
      }
      
      private function findPetInCurrentPetListById(id:uint) : PetInfo
      {
         if(this.player.petsAry[id])
         {
            return this.player.petsAry[id];
         }
         return null;
      }
      
      private function plClick(e:MouseEvent) : void
      {
         var txtformat:TextFormat = new TextFormat();
         txtformat.color = "0x381d09";
         var pid:uint = int(String(e.currentTarget.name).substr(7,1));
         var selectPet:PetInfo = this.findPetInCurrentPetListById(pid + (curPage - 1) * 5);
         if(selectPet == null)
         {
            throw new Error("获取选择的宠物为null");
         }
         for(var plen:uint = this.player.petsAry.length; plen-- > 0; )
         {
            if(this.getChildByName("petlist" + plen))
            {
               this.getChildByName("petlist" + plen)["petname"].setTextFormat(txtformat);
            }
         }
         txtformat.color = "0xfdfcba";
         e.currentTarget.petname.setTextFormat(txtformat);
         this.setPetInfomation(selectPet);
         this.addPetHead();
      }
      
      public function refreshInterface() : void
      {
         if(this.pif)
         {
            this.setShow();
            this.refreshPetList();
            this.addPetHead();
            if(this.pas)
            {
               this.pas.changePetInfo(this.pif);
               this.pas.setShow();
               this.pas.setPetAllSkill();
            }
            if(this.pbps)
            {
               this.pbps.changePetInfo(this.pif);
               this.pbps.refreshInterface();
            }
            if(this.pdi)
            {
               this.pdi.changePetInfo(this.pif);
            }
         }
      }
      
      private function addPetHead() : void
      {
         if(pethead)
         {
            if(contains(pethead))
            {
               this.removeChild(pethead);
            }
            pethead.destroy();
            pethead = null;
         }
         pethead = new PetHeadSprite(pif.getPetName());
         this.addChildAt(pethead,1);
         pethead.x = 280;
         pethead.y = 220;
      }
      
      public function setPetInfomation(_pif:PetInfo) : void
      {
         this.pif = _pif;
         this.setShow();
         if(this.pas)
         {
            this.pas.changePetInfo(this.pif);
            this.pas.setShow();
            this.pas.setPetAllSkill();
         }
         if(this.pbps)
         {
            this.pbps.changePetInfo(this.pif);
            this.pbps.refreshInterface();
         }
         if(this.pdi)
         {
            this.pdi.changePetInfo(this.pif);
         }
      }
      
      private function refreshTxt(e:CommonEvent) : void
      {
         this.setShow();
      }
      
      private function superErevol(e:CommonEvent) : void
      {
         this.addPetHead();
         this.refreshPetList(false);
         this.setShow();
      }
      
      private function setShow() : void
      {
         if(pif)
         {
            qualitymc.gotoAndStop(pif.getquality());
            this.setTitleTxt();
            this.leveltxt.text = pif.getLevel() + "";
            this.txtname.text = pif.getPetChinaName() + "";
            this.txtname.width = this.txtname.textWidth + 20;
            this.hptxt.text = pif.getHp() + "/" + pif.getSHp();
            this.mptxt.text = pif.getMp() + "/" + pif.getSMp();
            this.atktxt.text = pif.getAtk() + "";
            this.deftxt.text = pif.getDef() + "";
            this.exptxt.text = pif.getCurExper() + "/" + pif.getPetNextExper();
            this.speedtxt.text = pif.getMoveSpeed() + "";
            this.eamptxt.text = pif.getEMp() + "";
            this.eahptxt.text = pif.getEHp() + "";
            this.crittxt.text = Math.round(pif.getCrit() * 100) + "%";
            this.misstxt.text = Math.round(pif.getMiss() * 100) + "%";
            this.mdeftxt.text = Math.round(pif.getMDef() * 100) + "%";
            this.expmc.gotoAndStop(Math.round(20 * pif.getCurExper() / pif.getPetNextExper()) + 1);
         }
         else
         {
            qualitymc.gotoAndStop(3);
            this.txtname.text = "";
            this.hptxt.text = "";
            this.mptxt.text = "";
            this.atktxt.text = "";
            this.deftxt.text = "";
            this.exptxt.text = "";
            this.leveltxt.text = "";
            this.speedtxt.text = "";
            this.eamptxt.text = "";
            this.eahptxt.text = "";
            this.crittxt.text = "";
            this.misstxt.text = "";
            this.mdeftxt.text = "";
            this.expmc.gotoAndStop(1);
         }
      }
      
      private function setTitleTxt() : void
      {
         var lage:* = 0;
         var canCatchNum:int = 0;
         if(gc.gameVip.getVipLevel() < 3)
         {
            lage = uint(1 + int(this.player.getCurLevel() / 10));
            canCatchNum = lage < 5 ? lage : 5;
            this.listtxt.text = "宠物列表" + this.player.petsAry.length + "/" + canCatchNum;
         }
         else
         {
            this.listtxt.text = "宠物列表" + this.player.petsAry.length + "/10";
         }
      }
      
      private function releaseClick(e:MouseEvent) : void
      {
         if(this.pif)
         {
            this.addChild(giveupPet);
            giveupPet["okbtn"].addEventListener("click",okClick);
            giveupPet["nobtn"].addEventListener("click",noClick);
         }
      }
      
      private function pushPetSkill(e:MouseEvent) : void
      {
         if(this.pif)
         {
            if(gc.gameVip.getVipLevel() >= 3)
            {
               if(gc.gameVip.vipsavelist[7] < 3)
               {
                  vipclickwhich = "czjnbtn";
                  this.addRenewalseMask("您确定要重置宠物技能？ 还可以重置" + (3 - gc.gameVip.vipsavelist[7]) + "次");
               }
               else
               {
                  gc.ts.setTxt("您的次数已经用完!");
                  gc.stage.addChild(gc.ts);
               }
            }
            else
            {
               gc.ts.setTxt("您的VIP等级不够");
               gc.stage.addChild(gc.ts);
            }
         }
      }
      
      private function pushPetAttribute(e:MouseEvent) : void
      {
         if(this.pif)
         {
            if(gc.gameVip.getVipLevel() >= 3)
            {
               if(gc.gameVip.vipsavelist[6] < 3)
               {
                  vipclickwhich = "czsxbtn";
                  this.addRenewalseMask("您确定要重置宠物属性,还可以重置" + (3 - gc.gameVip.vipsavelist[6]) + "次");
               }
               else
               {
                  gc.ts.setTxt("您的次数已经用完!");
                  gc.stage.addChild(gc.ts);
               }
            }
            else
            {
               gc.ts.setTxt("您的VIP等级不够");
               gc.stage.addChild(gc.ts);
            }
         }
      }
      
      public function addRenewalseMask(inst:String) : void
      {
         renewalse["txt"].text = inst;
         this.addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(vipclickwhich == "czjnbtn")
         {
            this.issave = true;
            gc.gameVip.vipsavelist[7] += 1;
            this.pif.refreshPetAllSkillByLevel();
         }
         else if(vipclickwhich == "czsxbtn")
         {
            this.issave = true;
            gc.gameVip.vipsavelist[6] += 1;
            this.pif.refreshThreeAttribute();
         }
         this.setShow();
         if(this.pas)
         {
            this.pas.changePetInfo(this.pif);
            this.pas.setShow();
            this.pas.setPetAllSkill();
         }
         if(this.pdi)
         {
            this.pdi.changePetInfo(this.pif);
         }
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && this.contains(renewalse))
         {
            this.removeChild(renewalse);
         }
      }
      
      private function okClick(e:MouseEvent) : void
      {
         giveupPet["okbtn"].removeEventListener("click",okClick);
         giveupPet["nobtn"].removeEventListener("click",noClick);
         var sit:uint = this.player.petsAry.indexOf(this.pif);
         if(sit != -1)
         {
            this.player.petsAry.splice(sit,1);
         }
         if(pif.isFight == 1)
         {
            this.sendHeroRefreshPet();
         }
         this.pif = null;
         this.setShow();
         if(this.pas)
         {
            this.pas.changePetInfo(this.pif);
            this.pas.setShow();
            this.pas.setPetAllSkill();
         }
         if(this.pdi)
         {
            this.pdi.changePetInfo(this.pif);
         }
         this.setPetList();
         if(pethead)
         {
            if(contains(pethead))
            {
               this.removeChild(pethead);
            }
            pethead.destroy();
            pethead = null;
         }
         if(giveupPet && this.contains(giveupPet))
         {
            this.removeChild(giveupPet);
         }
      }
      
      private function noClick(e:MouseEvent) : void
      {
         giveupPet["okbtn"].removeEventListener("click",okClick);
         giveupPet["nobtn"].removeEventListener("click",noClick);
         if(giveupPet && this.contains(giveupPet))
         {
            this.removeChild(giveupPet);
         }
      }
      
      private function fightClick(e:MouseEvent) : void
      {
         var prePet:PetInfo = this.player.findCurrentPet();
         if(prePet && prePet.isCannotChange)
         {
            gc.ts.setTxt("当前出战宠物无法被收起");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(pif)
         {
            if(pif.getHp() <= 0)
            {
               gc.ts.setTxt("您的宠物需要休息了");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(prePet)
            {
               prePet.isFight = 0;
            }
            if(pif)
            {
               pif.isFight = 1;
            }
            this.refreshPetList();
            this.sendHeroRefreshPet();
         }
      }
      
      private function sendHeroRefreshPet() : void
      {
         if(gc.hero1)
         {
            if(gc.hero1.getPlayer() == this.player)
            {
               gc.hero1.changePet();
            }
         }
         if(gc.hero2)
         {
            if(gc.hero2.getPlayer() == this.player)
            {
               gc.hero2.changePet();
            }
         }
         if(gc.hero3)
         {
            if(gc.hero3.getPlayer() == this.player)
            {
               gc.hero3.changePet();
            }
         }
         gc.eventManger.dispatchEvent(new CommonEvent("CHANGECURRENTPET"));
      }
      
      private function refreshPetList(flag:Boolean = true) : void
      {
         this.setPetList(flag);
      }
      
      private function restClick(e:MouseEvent) : void
      {
         var prePet:PetInfo = this.player.findCurrentPet();
         if(prePet && prePet.isCannotChange)
         {
            gc.ts.setTxt("当前出战宠物无法被收起");
            gc.stage.addChild(gc.ts);
            return;
         }
         if(this.pif)
         {
            this.pif.isFight = 0;
            this.refreshPetList();
            this.sendHeroRefreshPet();
         }
      }
      
      private function eatImmor(e:MouseEvent) : void
      {
         var pei:PetEatImmortality = new PetEatImmortality(this.player);
         this.addChild(pei);
      }
      
      private function __closePetInterface(evt:CommonEvent) : void
      {
         this.close(null);
      }
      
      private function close(e:MouseEvent) : void
      {
         if(pethead)
         {
            if(contains(pethead))
            {
               this.removeChild(pethead);
            }
            pethead.destroy();
            pethead = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
