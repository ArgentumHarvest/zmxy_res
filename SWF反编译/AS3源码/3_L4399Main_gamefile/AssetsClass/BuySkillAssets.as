package AssetsClass
{
   import event.CommonEvent;
   import export.shop.BuySkill;
   
   public class BuySkillAssets extends BaseAssets
   {
       
      
      private var state:String = "";
      
      public function BuySkillAssets(_state:String)
      {
         this.state = _state;
         super(BuySkill);
         this.loadAssets(["RoleSkillInterfacev3550.swf"]);
      }
      
      override protected function addContent() : void
      {
         super.addContent();
         if(this.state == "maping")
         {
            gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
         }
         BuySkill(this.content).setCurrentState(this.state);
      }
   }
}
