package AssetsClass
{
   import export.invite.InvitationInterface;
   
   public class InvitationAssets extends BaseAssets
   {
       
      
      public function InvitationAssets()
      {
         super(InvitationInterface);
         this.loadAssets(["InvitationAssets.swf"]);
      }
   }
}
