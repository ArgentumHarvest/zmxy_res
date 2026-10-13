package AssetsClass
{
   import event.CommonEvent;
   import export.SelectRole;
   
   public class SelectRoleAssets extends BaseAssets
   {
       
      
      public function SelectRoleAssets()
      {
         super(SelectRole);
         this.loadAssets(["SelectRolev1060.swf"]);
      }
      
      override protected function addContent() : void
      {
         super.addContent();
         gc.eventManger.dispatchEvent(new CommonEvent("RemoveGameMenu"));
      }
   }
}
