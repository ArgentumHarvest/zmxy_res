package export.pet
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class PutPetSkill extends Sprite
   {
       
      
      private var currentSkill:Object;
      
      private var sinstro:Sprite;
      
      public function PutPetSkill()
      {
         super();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         sinstro = AUtils.getNewObj("skillIntro") as Sprite;
         sinstro.name = "skillIntro";
         sinstro.x = this.width / 2;
         sinstro.y = this.height / 2;
         this.addEventListener("mouseOver",show);
         this.addEventListener("mouseOut",hide);
      }
      
      private function removed(e:Event) : void
      {
         this.removeEventListener("mouseOver",show);
         this.removeEventListener("mouseOut",hide);
         sinstro = null;
      }
      
      public function removeSkill() : void
      {
         if(this.getChildByName("closeskillbutton") != null)
         {
            this.removeChild(this.getChildByName("closeskillbutton"));
         }
         if(this.getChildByName("addskillbutton") != null)
         {
            this.removeChild(this.getChildByName("addskillbutton"));
         }
         if(this.getChildByName("skillImage"))
         {
            this.removeChild(this.getChildByName("skillImage"));
            if(contains(sinstro))
            {
               this.removeChild(sinstro);
            }
            this.currentSkill = null;
         }
      }
      
      public function setCurrentSkill(data:*) : void
      {
         this.currentSkill = data;
         this.setImage();
         this.setIntroTxt();
      }
      
      public function getSkillName() : String
      {
         if(currentSkill)
         {
            return currentSkill.sname;
         }
         return "";
      }
      
      public function getSkillCName() : String
      {
         if(currentSkill)
         {
            return currentSkill.cname;
         }
         return "";
      }
      
      private function setIntroTxt() : void
      {
         if(currentSkill)
         {
            sinstro["txtname"].text = currentSkill.cname + " ";
            sinstro["txtintro"].text = currentSkill.sinfo + " ";
         }
      }
      
      private function show(e:MouseEvent) : void
      {
         this.setIntroTxt();
         if(currentSkill)
         {
            this.addChild(sinstro);
         }
      }
      
      private function hide(e:MouseEvent) : void
      {
         if(currentSkill)
         {
            if(contains(sinstro))
            {
               this.removeChild(sinstro);
            }
         }
      }
      
      private function setImage() : void
      {
         var img:* = undefined;
         if(currentSkill)
         {
            img = AUtils.getImageObj("petskill_" + currentSkill.sname);
            img.name = "skillImage";
            this.addChild(img);
         }
      }
      
      public function addCloseButton(btn:Sprite) : void
      {
         this.addChild(btn);
      }
   }
}
