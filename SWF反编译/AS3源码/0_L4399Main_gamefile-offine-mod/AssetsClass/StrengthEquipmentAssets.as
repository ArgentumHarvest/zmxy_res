package AssetsClass
{
   import event.CommonEvent;
   import export.strength.StrengthEquipment;
   
   public class StrengthEquipmentAssets extends BaseAssets
   {
       
      
      private var state:String = "";
      
      public function StrengthEquipmentAssets(_state:String)
      {
         this.state = _state;
         super(StrengthEquipment);
         this.loadAssets(["StrengthEquipmentv1090.swf"]);
      }
      
      override protected function addContent() : void
      {
         this.content = new this.assetsClass();
         StrengthEquipment(this.content).setCurrentState(this.state);
         this.addChild(this.content);
         this.content.addEventListener("removedFromStage",__contentRemoved);
         gc.eventManger.dispatchEvent(new CommonEvent("ShowOtherScene"));
      }
   }
}
