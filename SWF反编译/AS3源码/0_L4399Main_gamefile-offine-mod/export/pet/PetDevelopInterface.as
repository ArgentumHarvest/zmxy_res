package export.pet
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import petInfo.PetInfo;
   
   public class PetDevelopInterface extends Sprite
   {
       
      
      public var llmc:MovieClip;
      
      public var ggmc:MovieClip;
      
      public var wxmc:MovieClip;
      
      public var qlmc:MovieClip;
      
      public var wxplus:SimpleButton;
      
      public var ggplus:SimpleButton;
      
      public var llplus:SimpleButton;
      
      public var qltxt:TextField;
      
      public var qljxtxt:TextField;
      
      public var lltxt:TextField;
      
      public var ggtxt:TextField;
      
      public var wxtxt:TextField;
      
      public var nbtn:SimpleButton;
      
      public var sbtn:SimpleButton;
      
      private var pif:PetInfo;
      
      private var gc:Config;
      
      protected var _anti:Antiwear;
      
      public function PetDevelopInterface(_pif:PetInfo)
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this.pif = _pif;
         this._anti.zero = 0;
         this._anti.five = 5;
         this._anti.ten = 10;
         this._anti.twenty = 20;
         this._anti.forty = 40;
         this._anti.eighty = 80;
         this._anti.one_hundred_sixty = 160;
         this._anti.three_hundred_twenty = 320;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         nbtn.visible = false;
         sbtn.visible = false;
         wxplus.addEventListener("click",wxplusClick);
         ggplus.addEventListener("click",ggplusClick);
         llplus.addEventListener("click",llplusClick);
         this.setShow();
         this.showTowButton();
      }
      
      private function removed(e:Event) : void
      {
         wxplus.removeEventListener("click",wxplusClick);
         ggplus.removeEventListener("click",ggplusClick);
         llplus.removeEventListener("click",llplusClick);
         nbtn.removeEventListener("click",aoyiClick);
         sbtn.removeEventListener("click",superClick);
      }
      
      public function setShow() : void
      {
         if(this.pif)
         {
            this.qltxt.text = this.pif.getpotential() + "";
            this.qljxtxt.text = this.pif.getpotentiallimit() + "/ 100";
            this.lltxt.text = this.pif.gettechniqueprogress() + "/" + this.getNextProgressValue(this.pif.gettechnique());
            this.ggtxt.text = this.pif.getwarpowerprogress() + "/" + this.getNextProgressValue(this.pif.getwarpower());
            this.wxtxt.text = this.pif.getperceptionprogress() + "/" + this.getNextProgressValue(this.pif.getperception());
            this.llmc.gotoAndStop(1 + int(this.pif.gettechniqueprogress() / this.getNextProgressValue(this.pif.gettechnique()) * 50));
            this.ggmc.gotoAndStop(1 + int(this.pif.getwarpowerprogress() / this.getNextProgressValue(this.pif.getwarpower()) * 50));
            this.wxmc.gotoAndStop(1 + int(this.pif.getperceptionprogress() / this.getNextProgressValue(this.pif.getperception()) * 50));
            this.qlmc.gotoAndStop(1 + int(this.pif.getpotentiallimit() / 100 * 50));
         }
         else
         {
            this.qltxt.text = "";
            this.qljxtxt.text = "";
            this.lltxt.text = "";
            this.ggtxt.text = "";
            this.wxtxt.text = "";
            this.llmc.gotoAndStop(1);
            this.ggmc.gotoAndStop(1);
            this.wxmc.gotoAndStop(1);
            this.qlmc.gotoAndStop(1);
         }
      }
      
      private function wxplusClick(e:MouseEvent) : void
      {
         if(this.pif)
         {
            if(this.isAllGetedTop())
            {
               if(this.pif.getpotential() >= 1)
               {
                  this.pif.setpotential(this.pif.getpotential() - 1);
                  this.setPotentialLimitValue(1);
                  this.setShow();
               }
               else
               {
                  gc.ts.setTxt("潜力值不够");
                  gc.stage.addChild(gc.ts);
               }
               return;
            }
            if(this.pif.getperception() >= 8)
            {
               gc.ts.setTxt("悟性值已到上限");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(this.pif.getpotential() >= 1)
            {
               this.pif.setperceptionprogress(this.pif.getperceptionprogress() + 1);
               this.pif.setpotential(this.pif.getpotential() - 1);
               this.setPotentialLimitValue(1);
               if(this.pif.getperceptionprogress() >= this.getNextProgressValue(this.pif.getperception()))
               {
                  this.pif.changePerceptionAdd();
                  this.pif.setperceptionprogress(0);
                  gc.eventManger.dispatchEvent(new CommonEvent("PETEQUIPMENTOVER"));
               }
               this.setShow();
            }
            else
            {
               gc.ts.setTxt("潜力值不够");
               gc.stage.addChild(gc.ts);
            }
         }
      }
      
      private function ggplusClick(e:MouseEvent) : void
      {
         if(this.pif)
         {
            if(this.isAllGetedTop())
            {
               if(this.pif.getpotential() >= 1)
               {
                  this.pif.setpotential(this.pif.getpotential() - 1);
                  this.setPotentialLimitValue(1);
                  this.setShow();
               }
               else
               {
                  gc.ts.setTxt("潜力值不够");
                  gc.stage.addChild(gc.ts);
               }
               return;
            }
            if(this.pif.getwarpower() >= 8)
            {
               gc.ts.setTxt("根骨值已到上限");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(this.pif.getpotential() >= 1)
            {
               this.pif.setwarpowerprogress(this.pif.getwarpowerprogress() + 1);
               this.pif.setpotential(this.pif.getpotential() - 1);
               this.setPotentialLimitValue(1);
               if(this.pif.getwarpowerprogress() >= this.getNextProgressValue(this.pif.getwarpower()))
               {
                  this.pif.changeWarpowerAdd();
                  this.pif.setwarpowerprogress(0);
                  gc.eventManger.dispatchEvent(new CommonEvent("PETEQUIPMENTOVER"));
               }
               this.setShow();
            }
            else
            {
               gc.ts.setTxt("潜力值不够");
               gc.stage.addChild(gc.ts);
            }
         }
      }
      
      private function llplusClick(e:MouseEvent) : void
      {
         if(this.pif)
         {
            if(this.isAllGetedTop())
            {
               if(this.pif.getpotential() >= 1)
               {
                  this.pif.setpotential(this.pif.getpotential() - 1);
                  this.setPotentialLimitValue(1);
                  this.setShow();
               }
               else
               {
                  gc.ts.setTxt("潜力值不够");
                  gc.stage.addChild(gc.ts);
               }
               return;
            }
            if(this.pif.gettechnique() >= 8)
            {
               gc.ts.setTxt("灵力值已到上限");
               gc.stage.addChild(gc.ts);
               return;
            }
            if(this.pif.getpotential() >= 1)
            {
               this.pif.settechniqueprogress(this.pif.gettechniqueprogress() + 1);
               this.pif.setpotential(this.pif.getpotential() - 1);
               this.setPotentialLimitValue(1);
               if(this.pif.gettechniqueprogress() >= this.getNextProgressValue(this.pif.gettechnique()))
               {
                  this.pif.changeTechniqueAdd();
                  this.pif.settechniqueprogress(0);
                  gc.eventManger.dispatchEvent(new CommonEvent("PETEQUIPMENTOVER"));
               }
               this.setShow();
            }
            else
            {
               gc.ts.setTxt("潜力值不够");
               gc.stage.addChild(gc.ts);
            }
         }
      }
      
      private function isAllGetedTop() : Boolean
      {
         if(this.pif.gettechnique() >= 8 && this.pif.getwarpower() >= 8 && this.pif.getperception() >= 8)
         {
            return true;
         }
         return false;
      }
      
      private function setPotentialLimitValue(v:int) : void
      {
         if(gc.isHideDebug)
         {
            if(this.pif.getpotentiallimit() < 100)
            {
               this.pif.setpotentiallimit(this.pif.getpotentiallimit() + v);
            }
         }
         else if(this.pif.getpotentiallimit() < 100)
         {
            this.pif.setpotentiallimit(this.pif.getpotentiallimit() + 20);
         }
         this.showTowButton();
      }
      
      private function showTowButton() : void
      {
         if(this.pif == null)
         {
            return;
         }
         if(this.pif.getpotentiallimit() >= this._anti.ten * this._anti.ten && this.pif.getLevel() >= this._anti.ten * this._anti.five)
         {
            if(this.pif.getPetName() == "monkey4")
            {
               if(!this.pif.findHasStudySkill("jgaoyi"))
               {
                  nbtn.visible = true;
                  sbtn.visible = false;
                  nbtn.addEventListener("click",aoyiClick);
               }
            }
            else if(this.pif.getPetName() == "horse4")
            {
               if(!this.pif.findHasStudySkill("tmaoyi"))
               {
                  nbtn.visible = true;
                  sbtn.visible = false;
                  nbtn.addEventListener("click",aoyiClick);
               }
            }
            else if(this.pif.getPetName() == "tigress4")
            {
               if(!this.pif.findHasStudySkill("bhaoyi"))
               {
                  nbtn.visible = true;
                  sbtn.visible = false;
                  nbtn.addEventListener("click",aoyiClick);
               }
            }
            else if(this.pif.getPetName() == "turtle4")
            {
               if(!this.pif.findHasStudySkill("xwaoyi"))
               {
                  nbtn.visible = true;
                  sbtn.visible = false;
                  nbtn.addEventListener("click",aoyiClick);
               }
            }
            else if(this.pif.getPetName() == "phoenix4")
            {
               if(!this.pif.findHasStudySkill("zqaoyi"))
               {
                  nbtn.visible = true;
                  sbtn.visible = false;
                  nbtn.addEventListener("click",aoyiClick);
               }
            }
            else if(this.pif.getPetName() == "dragon4")
            {
               if(!this.pif.findHasStudySkill("qlaoyi"))
               {
                  nbtn.visible = true;
                  sbtn.visible = false;
                  nbtn.addEventListener("click",aoyiClick);
               }
            }
            else if(this.pif.getPetName() == "rabbit4")
            {
               if(!this.pif.findHasStudySkill("ysaoyi"))
               {
                  nbtn.visible = true;
                  sbtn.visible = false;
                  nbtn.addEventListener("click",aoyiClick);
               }
            }
            else if(this.pif.getPetName() == "turtle3" || this.pif.getPetName() == "monkey3" || this.pif.getPetName() == "horse3" || this.pif.getPetName() == "tigress3" || this.pif.getPetName() == "phoenix3" || this.pif.getPetName() == "dragon3" || this.pif.getPetName() == "rabbit3" || this.pif.getPetName() == "mouse2" || this.pif.getPetName() == "mouse3" || this.pif.getPetName() == "mouse1" || this.pif.getPetName() == "neat2" || this.pif.getPetName() == "neat3" || this.pif.getPetName() == "neat1" || this.pif.getPetName() == "roomhorse2" || this.pif.getPetName() == "roomhorse3" || this.pif.getPetName() == "roomhorse1" || this.pif.getPetName() == "terribletiger1" || this.pif.getPetName() == "terribletiger2" || this.pif.getPetName() == "terribletiger3")
            {
               nbtn.visible = false;
               sbtn.visible = true;
               sbtn.addEventListener("click",superClick);
            }
         }
      }
      
      private function aoyiClick(e:MouseEvent) : void
      {
         trace("---aoyiClick---");
         nbtn.removeEventListener("click",aoyiClick);
         var bool:Boolean = this.pif.studyEsoteric();
         if(bool)
         {
            nbtn.visible = false;
            this.pif.setpotentiallimit(0);
            this.setShow();
            this.showTowButton();
         }
      }
      
      private function superClick(e:MouseEvent) : void
      {
         trace("--superClick--");
         sbtn.visible = false;
         sbtn.removeEventListener("click",superClick);
         var prename:String = this.pif.getPetName().substr(0,this.pif.getPetName().length - 1);
         if(prename == "mouse" || prename == "neat" || prename == "roomhorse" || prename == "terribletiger")
         {
            this.pif.theFourShape(true);
         }
         else
         {
            this.pif.theFourShape();
         }
         this.pif.setpotentiallimit(0);
         this.setShow();
         this.showTowButton();
         gc.eventManger.dispatchEvent(new CommonEvent("SUPEREVOLUTION"));
      }
      
      private function getNextProgressValue(cv:uint) : uint
      {
         if(cv == 1)
         {
            return this._anti.five;
         }
         if(cv == 2)
         {
            return this._anti.ten;
         }
         if(cv == 3)
         {
            return this._anti.twenty;
         }
         if(cv == 4)
         {
            return this._anti.forty;
         }
         if(cv == 5)
         {
            return this._anti.eighty;
         }
         if(cv == 6)
         {
            return this._anti.one_hundred_sixty;
         }
         if(cv == 7)
         {
            return this._anti.three_hundred_twenty;
         }
         return this._anti.zero;
      }
      
      public function changePetInfo(_pif:PetInfo) : void
      {
         nbtn.removeEventListener("click",aoyiClick);
         sbtn.removeEventListener("click",superClick);
         nbtn.visible = false;
         sbtn.visible = false;
         this.pif = _pif;
         this.showTowButton();
         this.setShow();
      }
   }
}
