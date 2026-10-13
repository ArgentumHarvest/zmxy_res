package export.garden
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import export.pet.PutPetSkill;
   import export.renewalse.RenewalseThisSZ;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import my.FinancialInfo;
   import petInfo.PetInfo;
   
   public class ForgetSkill extends Sprite
   {
       
      
      private var skill1:PutPetSkill;
      
      private var skill2:PutPetSkill;
      
      private var skill3:PutPetSkill;
      
      private var skill4:PutPetSkill;
      
      private var skill5:PutPetSkill;
      
      private var skill6:PutPetSkill;
      
      private var skill7:PutPetSkill;
      
      private var skill8:PutPetSkill;
      
      private var pif:PetInfo;
      
      private var renewalse:RenewalseThisSZ;
      
      private var csname:String;
      
      private var _anti:Antiwear;
      
      private var gc:Config;
      
      public function ForgetSkill(_pif:PetInfo)
      {
         this._anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this.pif = _pif;
         this._anti.curclickstring = "";
         this._anti.curid = 1;
         this._anti.fourty_five = 45;
         this._anti.needtopay = 300;
         renewalse = new RenewalseThisSZ();
         renewalse.name = "renewalseThisSZ";
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         gc.eventManger.addEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.addEventListener("BuyFail",paymentFail);
         skill8 = new PutPetSkill();
         skill8.x = 212.95;
         skill8.y = 90;
         skill8.buttonMode = true;
         this.addChild(skill8);
         skill7 = new PutPetSkill();
         skill7.x = 140.95;
         skill7.y = 90;
         skill7.buttonMode = true;
         this.addChild(skill7);
         skill6 = new PutPetSkill();
         skill6.x = 69.95;
         skill6.y = 90;
         skill6.buttonMode = true;
         this.addChild(skill6);
         skill5 = new PutPetSkill();
         skill5.x = 0;
         skill5.y = 90;
         skill5.buttonMode = true;
         this.addChild(skill5);
         skill4 = new PutPetSkill();
         skill4.x = 212.95;
         skill4.y = 28;
         skill4.buttonMode = true;
         this.addChild(skill4);
         skill3 = new PutPetSkill();
         skill3.x = 140.95;
         skill3.y = 28;
         skill3.buttonMode = true;
         this.addChild(skill3);
         skill2 = new PutPetSkill();
         skill2.x = 69.95;
         skill2.y = 28;
         skill2.buttonMode = true;
         this.addChild(skill2);
         skill1 = new PutPetSkill();
         skill1.x = 0;
         skill1.y = 28;
         skill1.buttonMode = true;
         this.addChild(skill1);
         this.setPetAllSkill();
      }
      
      private function removed(e:Event) : void
      {
         gc.eventManger.removeEventListener("BuySuccess",paymentSuccess);
         gc.eventManger.removeEventListener("BuyFail",paymentFail);
      }
      
      public function changePetInfo(_pif:PetInfo) : void
      {
         this.pif = _pif;
         this.setPetAllSkill();
      }
      
      private function setPetAllSkill() : void
      {
         var i:* = 0;
         var slen:* = 0;
         i = 0;
         var newObj:Object = null;
         var btn:Sprite = null;
         var per:* = 0;
         var len:* = 0;
         var spr:Sprite = null;
         i = 0;
         while(i < 8)
         {
            this["skill" + (i + 1)].removeSkill();
            i++;
         }
         if(this.pif)
         {
            slen = this.pif.skill.length;
            i = 0;
            while(i < slen)
            {
               newObj = {};
               this.pif.changePetSkillIntroduce();
               newObj.sname = this.pif.skill[i].sname;
               newObj.cname = this.pif.transPetChinaSkillName(this.pif.skill[i].sname);
               newObj.sinfo = this.pif.skill[i].sinfo;
               this["skill" + (i + 1)].setCurrentSkill(newObj);
               btn = AUtils.getImageSprite("closeskillbutton") as Sprite;
               btn.name = "closeskillbutton";
               btn.x = 27;
               btn.y = 4;
               this["skill" + (i + 1)].addCloseButton(btn);
               btn.addEventListener("click",sxClick);
               btn.addEventListener("removedFromStage",btnRemove);
               i++;
            }
            per = uint(this.pif.getperception());
            len = this.pif.hasStudyAllSpecialSkill();
            while(slen < per)
            {
               if(len > 0)
               {
                  spr = AUtils.getImageSprite("addskillbutton") as Sprite;
                  spr.name = "addskillbutton";
                  spr.x = 15;
                  spr.y = 15;
                  this["skill" + (slen + 1)].addCloseButton(spr);
                  spr.addEventListener("click",sadClick);
                  spr.addEventListener("removedFromStage",sprRemove);
                  len--;
                  if(len <= 0)
                  {
                     break;
                  }
               }
               slen++;
            }
         }
      }
      
      private function btnRemove(e:Event) : void
      {
         e.currentTarget.removeEventListener("removedFromStage",btnRemove);
         e.currentTarget.removeEventListener("click",sxClick);
      }
      
      private function sprRemove(e:Event) : void
      {
         e.currentTarget.removeEventListener("removedFromStage",sprRemove);
         e.currentTarget.removeEventListener("click",sadClick);
      }
      
      private function sxClick(e:MouseEvent) : void
      {
         trace("-----sxClick-----");
         if(this.pif)
         {
            if(e.currentTarget.parent.getSkillCName() != "")
            {
               if(this.pif.getpotential() >= this._anti.fourty_five)
               {
                  csname = e.currentTarget.parent.getSkillName();
                  this._anti.curclickstring = "sxClick";
                  this.addRenewalseMask("您确定要花费45潜力点,将【" + e.currentTarget.parent.getSkillCName() + "】遗忘");
               }
               else
               {
                  gc.ts.setTxt("该宠物潜力点不足45点");
                  gc.stage.addChild(gc.ts);
               }
            }
         }
      }
      
      private function sadClick(e:MouseEvent) : void
      {
         if(this.pif)
         {
            this._anti.curclickstring = "sadClick";
            this.addRenewalseMask("您确定要花费" + this._anti.needtopay + "点券领悟一个专属技能");
         }
      }
      
      public function addRenewalseMask(inst:String) : void
      {
         renewalse["txt"].text = inst;
         GMain.getInstance().getMainSence().addChild(renewalse);
         renewalse["okbtn"].addEventListener("click",renewalseOk);
         renewalse["nobtn"].addEventListener("click",renewalseChange);
      }
      
      private function renewalseOk(e:MouseEvent) : void
      {
         var enough:Boolean = false;
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && GMain.getInstance().getMainSence().contains(renewalse))
         {
            GMain.getInstance().getMainSence().removeChild(renewalse);
         }
         if(this._anti.curclickstring == "sxClick")
         {
            if(this.pif)
            {
               if(csname != "")
               {
                  this.pif.setpotential(this.pif.getpotential() - this._anti.fourty_five);
                  this.pif.delSomeOneSkillBySkillName(csname);
                  csname = "";
                  gc.ts.setTxt("遗忘成功");
                  gc.stage.addChild(gc.ts);
                  gc.eventManger.dispatchEvent(new CommonEvent("RefreshTxt"));
               }
            }
         }
         else if(this._anti.curclickstring == "sadClick")
         {
            gc.lastPaymentString = "ForgetSkill";
            gc.eventManger.dispatchEvent(new CommonEvent("BuySuccess",[100000]));
         }
         this.setPetAllSkill();
      }
      
      private function renewalseChange(e:MouseEvent) : void
      {
         renewalse["okbtn"].removeEventListener("click",renewalseOk);
         renewalse["nobtn"].removeEventListener("click",renewalseChange);
         if(renewalse && GMain.getInstance().getMainSence().contains(renewalse))
         {
            GMain.getInstance().getMainSence().removeChild(renewalse);
         }
      }
      
      private function paymentSuccess(e:CommonEvent) : void
      {
         if(gc.lastPaymentString != "ForgetSkill")
         {
            return;
         }
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
         FinancialInfo.sendInfoToFinancialServer(gc.logInfo.uid,[[{
            "id":10660,
            "ename":"custom"
         },1,1],[{
            "id":10660,
            "ename":"custom"
         },0,1]],gc.getTimeStamp(),gc.gameVip.dataObject.lastMoney);
         gc.lastPaymentString = "";
         gc.gameVip.dataObject.lastMoney = e.data[0];
         gc.ts.setTxt("领悟成功");
         gc.stage.addChild(gc.ts);
         this.pif.addSomeOneSkillByRandom();
         this.setPetAllSkill();
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function paymentFail(e:CommonEvent) : void
      {
         var exictmask:Sprite = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
         if(exictmask)
         {
            gc.stage.removeChild(exictmask);
            exictmask = null;
         }
      }
   }
}
