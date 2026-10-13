package export.shop
{
   import config.Config;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import mvc.controllor.RandomControllor;
   import user.User;
   
   public class SkillControl extends Sprite
   {
       
      
      private var player:User;
      
      private var gc:Config;
      
      private var whichxf:uint = 1;
      
      public var upGradebtn:SimpleButton;
      
      public var xf1mc:MovieClip;
      
      public var xf2mc:MovieClip;
      
      public var leveltxt1:TextField;
      
      public var leveltxt2:TextField;
      
      public var lhtxt1:TextField;
      
      public var lhtxt2:TextField;
      
      public var xfname1:TextField;
      
      public var xfname2:TextField;
      
      public var mainskillmc:MovieClip;
      
      public function SkillControl(_who:User)
      {
         super();
         gc = Config.getInstance();
         this.player = _who;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.xf1mc.buttonMode = true;
         this.xf2mc.buttonMode = true;
         this.xf1mc.addEventListener("click",firstXFFunc);
         this.xf2mc.addEventListener("click",secondXFFunc);
         this.upGradebtn.addEventListener("click",upGradeSkillFunc);
         this.xf1mc.dispatchEvent(new MouseEvent("click"));
         this.setXFtxt();
         this.initXFIcon();
      }
      
      private function removed(e:Event) : void
      {
         this.xf1mc.removeEventListener("click",firstXFFunc);
         this.xf2mc.removeEventListener("click",secondXFFunc);
         this.upGradebtn.visible = true;
         this.upGradebtn.removeEventListener("click",upGradeSkillFunc);
         this.mainskillmc.skillset1.removeEventListener("click",skillsetFunc);
         this.mainskillmc.skillset2.removeEventListener("click",skillsetFunc);
         this.mainskillmc.skillset3.removeEventListener("click",skillsetFunc);
         this.mainskillmc.skillset4.removeEventListener("click",skillsetFunc);
         this.mainskillmc.skillset5.removeEventListener("click",skillsetFunc);
      }
      
      private function firstXFFunc(e:MouseEvent) : void
      {
         this.upGradebtn.x = 136.95;
         this.upGradebtn.y = 191.35;
         this.whichxf = 1;
         this.setSkillMc();
         AUtils.checkLoadOK(this.mainskillmc,initStudySkill);
      }
      
      private function secondXFFunc(e:MouseEvent) : void
      {
         this.upGradebtn.x = 136.95;
         this.upGradebtn.y = 391.35;
         this.whichxf = 2;
         this.setSkillMc();
         AUtils.checkLoadOK(this.mainskillmc,initStudySkill);
      }
      
      private function initStudySkill() : void
      {
         var i:* = 0;
         var img:* = undefined;
         var levId:* = 0;
         var sary:* = null;
         var skillbtn:* = null;
         var ary:* = null;
         var mc:* = null;
         var xflev:uint = uint(this.player.isstudyskill[this.whichxf - 1].xflevel);
         for(i = uint(1); i <= xflev; )
         {
            this.mainskillmc["skillset" + i].removeEventListener("click",skillsetFunc);
            this.mainskillmc["skill" + i].removeEventListener("click",buy);
            this.mainskillmc["skillset" + i].addEventListener("click",skillsetFunc);
            this.mainskillmc["skill" + i].addEventListener("click",buy);
            this.mainskillmc["skill" + i].gotoAndStop(2);
            i++;
         }
         if(this.mainskillmc.getChildByName("BaJieSkillDebugBugWithTemp") != null)
         {
            this.mainskillmc.removeChild(this.mainskillmc.getChildByName("BaJieSkillDebugBugWithTemp"));
         }
         if(this.player.roleid == 3 && this.whichxf == 1)
         {
            img = AUtils.getImageObj("ImgBaJieSkillDebugBugWithTemp");
            img.x = -189.95;
            img.y = 33.55;
            img.name = "BaJieSkillDebugBugWithTemp";
            this.mainskillmc.addChild(img);
         }
         var skillAry:Array = String(this.player.isstudyskill[this.whichxf - 1].skillName).split("|");
         for(var slen:uint = skillAry.length; slen-- > 0; )
         {
            sary = skillAry[slen].split("~");
            skillbtn = this.findSkillBtnBySkillName(sary[0]);
            if(skillbtn != "")
            {
               this.mainskillmc[skillbtn].removeEventListener("click",buy);
               this.mainskillmc[skillbtn].gotoAndStop(3);
               ary = this.player.getSkillStringBySkillName(sary[0]);
               if(ary[1])
               {
                  levId = uint(ary[1]);
               }
               else
               {
                  levId = uint(1);
               }
               trace("levId -->>" + levId);
               if(levId >= 2)
               {
                  mc = AUtils.getNewObj("role_skil_llevel_mc") as MovieClip;
                  mc.gotoAndStop(levId - 1);
                  mc.x = 37.5;
                  mc.y = 50.05;
                  this.mainskillmc[skillbtn].addChild(mc);
               }
            }
         }
         if(xflev >= 5)
         {
            this.upGradebtn.visible = false;
         }
         else
         {
            this.upGradebtn.visible = true;
         }
      }
      
      private function upGradeSkillFunc(e:MouseEvent) : void
      {
         var lesslh:uint = this.findNextNeedLHValue(this.player.isstudyskill[whichxf - 1].xflevel + 1);
         if(this.player.isstudyskill[whichxf - 1].xflevel < 5)
         {
            if(this.player.getLhValue() >= lesslh)
            {
               this.player.isstudyskill[whichxf - 1].xflevel++;
               this.player.setLhValue(this.player.getLhValue() - lesslh);
               this.setXFtxt();
               this.initStudySkill();
            }
            else
            {
               trace("you lhValue is not enough!");
            }
         }
         this.setXFIcon();
         BuySkill(this.parent).setTxtlh();
      }
      
      private function initXFIcon() : void
      {
         var i:* = 0;
         for(i = uint(0); i <= 1; )
         {
            this["xf" + (i + 1) + "mc"].gotoAndStop(this.player.getRoleName() + "-yes");
            i++;
         }
      }
      
      private function setXFIcon() : void
      {
         if(this.whichxf == 1)
         {
            this.xf1mc.gotoAndStop(this.player.getRoleName() + "-yes");
         }
         else
         {
            this.xf2mc.gotoAndStop(this.player.getRoleName() + "-yes");
         }
      }
      
      private function skillsetFunc(e:MouseEvent) : void
      {
         var ssctrl:* = null;
         var curskill:* = null;
         var sary:* = null;
         var num:uint = int(String(e.currentTarget.name).substr(8,1));
         if(this.mainskillmc["skill" + num].currentFrame == 3)
         {
            ssctrl = this.getChildByName("SkillSetControl") as SkillSetControl;
            if(ssctrl)
            {
               this.removeChild(ssctrl);
            }
            ssctrl = null;
            curskill = this.findSkillNameBySkillBtn(num);
            sary = this.player.getSkillStringBySkillName(curskill[0]);
            trace("skillsetFunc sary --" + sary);
            ssctrl = new SkillSetControl(this.player,sary,curskill[1]);
            ssctrl.name = "SkillSetControl";
            this.addChild(ssctrl);
         }
      }
      
      private function setXFtxt() : void
      {
         var i:* = 0;
         for(i = uint(0); i <= 1; )
         {
            if(this.player.isstudyskill[i].xflevel != 0)
            {
               this["leveltxt" + (i + 1)].text = this.player.isstudyskill[i].xflevel + " ";
            }
            else
            {
               this["leveltxt" + (i + 1)].text = "0";
            }
            this["lhtxt" + (i + 1)].text = this.findNextNeedLHValue(this.player.isstudyskill[i].xflevel + 1) + " ";
            this["xfname" + (i + 1)].text = this.findXFNameById(i);
            i++;
         }
      }
      
      private function setSkillMc() : void
      {
         if(this.player)
         {
            this.mainskillmc.gotoAndStop(this.player.getRoleName() + "-" + this.whichxf);
         }
      }
      
      private function findNextNeedLHValue(nextlevel:uint) : uint
      {
         var needlh:Number = 0;
         switch(int(nextlevel) - 1)
         {
            case 0:
               needlh = 100 + RandomControllor.getIns().getRandom() / 1000;
               break;
            case 1:
               needlh = 200 + RandomControllor.getIns().getRandom() / 1000;
               break;
            case 2:
               needlh = 500 + RandomControllor.getIns().getRandom() / 1000;
               break;
            case 3:
               needlh = 1000 + RandomControllor.getIns().getRandom() / 1000;
               break;
            case 4:
               needlh = 2000 + RandomControllor.getIns().getRandom() / 1000;
         }
         return int(needlh);
      }
      
      private function findXFNameById(id:uint) : String
      {
         if(this.player.roleid == 1)
         {
            if(id == 0)
            {
               return "斩系心法";
            }
            return "火系心法";
         }
         if(this.player.roleid == 2)
         {
            if(id == 0)
            {
               return "愈系心法";
            }
            return "水系心法";
         }
         if(this.player.roleid == 3)
         {
            if(id == 0)
            {
               return "御系心法";
            }
            return "土系心法";
         }
         if(this.player.roleid == 4)
         {
            if(id == 0)
            {
               return "毒系心法";
            }
            return "木系心法";
         }
         return "";
      }
      
      private function buy(e:MouseEvent) : void
      {
         var index:* = 0;
         var curSkill:* = null;
         var hasbtn:* = null;
         var sObj:* = null;
         if(this.player.howMuchSkillHasYouStudy() < this.player.getSkillLimt())
         {
            index = uint(int(String(e.currentTarget.name).substr(5,1)));
            if(this.mainskillmc["skill" + index].currentFrame == 2)
            {
               curSkill = findSkillNameBySkillBtn(index);
               this.player.isstudyskill[this.whichxf - 1].skillName += curSkill[0] + "~1|";
               hasbtn = this.player.findWhichSkillBtnNoneSet();
               if(hasbtn != "")
               {
                  sObj = {
                     "skillName":curSkill[0],
                     "keys":hasbtn,
                     "needLh":curSkill[1],
                     "slev":1
                  };
                  this.player.skillbykey.push(sObj);
               }
               this.mainskillmc["skill" + index].removeEventListener("click",buy);
               this.mainskillmc["skill" + index].gotoAndStop(3);
            }
         }
         else
         {
            gc.ts.setTxt("您当前只能学习" + this.player.getSkillLimt() + "个技能!");
            this.addChild(gc.ts);
         }
      }
      
      private function findSkillNameBySkillBtn(index:int) : Array
      {
         var nmmp:int = 0;
         var skillName:String = "";
         if(this.whichxf == 1)
         {
            skillName = gc.allSklName[2 * (this.player.roleid - 1)][index - 1];
            nmmp = gc.needMMP[2 * (this.player.roleid - 1)][index - 1];
         }
         else
         {
            skillName = gc.allSklName[2 * this.player.roleid - 1][index - 1];
            nmmp = gc.needMMP[2 * this.player.roleid - 1][index - 1];
         }
         return [skillName,nmmp];
      }
      
      private function findSkillBtnBySkillName(data:String) : String
      {
         var sBtnId:* = 0;
         var i:* = 0;
         var subAry:* = null;
         var slen:* = 0;
         var j:* = 0;
         var alen:uint = gc.allSklName.length;
         for(i = uint(0); i < alen; )
         {
            subAry = gc.allSklName[i];
            slen = uint(subAry.length);
            for(j = uint(0); j < slen; )
            {
               if(data == subAry[j])
               {
                  sBtnId = uint(j + 1);
                  break;
               }
               j++;
            }
            i++;
         }
         if(sBtnId == 0)
         {
            return "";
         }
         return "skill" + sBtnId;
      }
   }
}
