package export.pet
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import petInfo.PetInfo;
   
   public class PetAttributeShow extends Sprite
   {
       
      
      private var pif:PetInfo;
      
      public var lifetimemc:MovieClip;
      
      public var defqualitymc:MovieClip;
      
      public var atkqualitymc:MovieClip;
      
      public var mpqualitymc:MovieClip;
      
      public var hpqualitymc:MovieClip;
      
      public var lifetimetxt:TextField;
      
      public var defqualitytxt:TextField;
      
      public var atkqualitytxt:TextField;
      
      public var mpqualitytxt:TextField;
      
      public var hpqualitytxt:TextField;
      
      private var skill1:PutPetSkill;
      
      private var skill2:PutPetSkill;
      
      private var skill3:PutPetSkill;
      
      private var skill4:PutPetSkill;
      
      private var skill5:PutPetSkill;
      
      private var skill6:PutPetSkill;
      
      private var skill7:PutPetSkill;
      
      private var skill8:PutPetSkill;
      
      public var warpowertxt:TextField;
      
      public var techniquetxt:TextField;
      
      public var perceptiontxt:TextField;
      
      public function PetAttributeShow(_pif:PetInfo)
      {
         super();
         this.pif = _pif;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         skill8 = new PutPetSkill();
         skill8.x = 222.95;
         skill8.y = 307.45;
         this.addChild(skill8);
         skill7 = new PutPetSkill();
         skill7.x = 154.95;
         skill7.y = 307.45;
         this.addChild(skill7);
         skill6 = new PutPetSkill();
         skill6.x = 88;
         skill6.y = 307.45;
         this.addChild(skill6);
         skill5 = new PutPetSkill();
         skill5.x = 21;
         skill5.y = 307.45;
         this.addChild(skill5);
         skill4 = new PutPetSkill();
         skill4.x = 222.95;
         skill4.y = 244.45;
         this.addChild(skill4);
         skill3 = new PutPetSkill();
         skill3.x = 154.95;
         skill3.y = 244.45;
         this.addChild(skill3);
         skill2 = new PutPetSkill();
         skill2.x = 88;
         skill2.y = 244.45;
         this.addChild(skill2);
         skill1 = new PutPetSkill();
         skill1.x = 21;
         skill1.y = 244.45;
         this.addChild(skill1);
         this.setShow();
         this.setPetAllSkill();
      }
      
      private function removed(e:Event) : void
      {
      }
      
      public function changePetInfo(_pif:PetInfo) : void
      {
         this.pif = _pif;
      }
      
      public function setShow() : void
      {
         if(this.pif)
         {
            this.perceptiontxt.text = pif.getperception() + "";
            this.techniquetxt.text = pif.gettechnique() + "";
            this.warpowertxt.text = pif.getwarpower() + "";
            this.lifetimetxt.text = pif.getlifetime() + "/" + 100;
            if(pif.getdefExp() > 0)
            {
               this.defqualitytxt.text = pif.getdefQuality(true) + "+" + pif.getdefExp();
            }
            else
            {
               this.defqualitytxt.text = pif.getdefQuality(true) + "";
            }
            if(pif.getatkExp() > 0)
            {
               this.atkqualitytxt.text = pif.getatkQuality(true) + "+" + pif.getatkExp();
            }
            else
            {
               this.atkqualitytxt.text = pif.getatkQuality(true) + "";
            }
            if(pif.getmpExp() > 0)
            {
               this.mpqualitytxt.text = pif.getmpQuality(true) + "+" + pif.getmpExp();
            }
            else
            {
               this.mpqualitytxt.text = pif.getmpQuality(true) + "";
            }
            if(pif.gethpExp() > 0)
            {
               this.hpqualitytxt.text = pif.gethpQuality(true) + "+" + pif.gethpExp();
            }
            else
            {
               this.hpqualitytxt.text = pif.gethpQuality(true) + "";
            }
            lifetimemc.gotoAndStop(20 - Math.round(20 * pif.getlifetime() / 100));
            defqualitymc.gotoAndStop(Math.round(20 * pif.getdefQuality() / 2000) + 1);
            atkqualitymc.gotoAndStop(Math.round(20 * pif.getatkQuality() / 2000) + 1);
            mpqualitymc.gotoAndStop(Math.round(20 * pif.getmpQuality() / 2000) + 1);
            hpqualitymc.gotoAndStop(Math.round(20 * pif.gethpQuality() / 2000) + 1);
         }
         else
         {
            this.perceptiontxt.text = "";
            this.techniquetxt.text = "";
            this.warpowertxt.text = "";
            this.lifetimetxt.text = "";
            this.defqualitytxt.text = "";
            this.atkqualitytxt.text = "";
            this.mpqualitytxt.text = "";
            this.hpqualitytxt.text = "";
            lifetimemc.gotoAndStop(20);
            defqualitymc.gotoAndStop(1);
            atkqualitymc.gotoAndStop(1);
            mpqualitymc.gotoAndStop(1);
            hpqualitymc.gotoAndStop(1);
         }
      }
      
      public function setPetAllSkill() : void
      {
         var i:* = 0;
         var slen:* = 0;
         i = 0;
         var newObj:* = null;
         for(i = uint(0); i < 8; )
         {
            this["skill" + (i + 1)].removeSkill();
            i++;
         }
         if(this.pif)
         {
            slen = uint(this.pif.skill.length);
            for(i = uint(0); i < slen; )
            {
               newObj = {};
               this.pif.changePetSkillIntroduce();
               newObj.sname = this.pif.skill[i].sname;
               newObj.cname = this.pif.transPetChinaSkillName(this.pif.skill[i].sname);
               newObj.sinfo = this.pif.skill[i].sinfo;
               this["skill" + (i + 1)].setCurrentSkill(newObj);
               i++;
            }
         }
      }
   }
}
