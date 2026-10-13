package export.pet
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import petInfo.PetInfo;
   
   public class ShowPetInfo extends Sprite
   {
       
      
      private var pif:PetInfo;
      
      private var rid:uint;
      
      public var headmc:MovieClip;
      
      public var txtlevel:TextField;
      
      public var txthp:TextField;
      
      public var txtmp:TextField;
      
      public var hpmc:MovieClip;
      
      public var mpmc:MovieClip;
      
      public function ShowPetInfo()
      {
         super();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
      }
      
      private function removed(e:Event) : void
      {
      }
      
      public function setPetInfo(_pif:PetInfo) : void
      {
         this.pif = _pif;
      }
      
      public function flipHorizontalTxt(rid:uint) : void
      {
         if(rid == 2 || rid == 3)
         {
            AUtils.flipHorizontal(this.txthp,-1);
            this.txthp.x = 140;
            AUtils.flipHorizontal(this.txtmp,-1);
            this.txtmp.x = 140;
            AUtils.flipHorizontal(this.txtlevel,-1);
            this.txtlevel.x = 25;
         }
      }
      
      public function show() : void
      {
         if(pif)
         {
            pif.transPetChinaSkillName(pif.getPetName());
            this.headmc.gotoAndStop(pif.getPetChinaName());
            this.txtlevel.text = pif.getLevel() + "";
            this.txthp.text = pif.getHp() + "/" + pif.getSHp();
            this.hpmc.gotoAndStop(25 - Math.round(25 * pif.getHp() / pif.getSHp()));
            this.txtmp.text = pif.getMp() + "/" + pif.getSMp();
            this.mpmc.gotoAndStop(25 - Math.round(25 * pif.getMp() / pif.getSMp()));
         }
      }
   }
}
