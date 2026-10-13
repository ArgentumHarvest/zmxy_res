package AssetsClass
{
   import export.rank.RankTopInterface;
   
   public class RankTopAssets extends BaseAssets
   {
       
      
      public function RankTopAssets()
      {
         super(RankTopInterface);
         var role1Name:String = gc.getRoleSwfNameByRoleName("Role1");
         var role2Name:String = gc.getRoleSwfNameByRoleName("Role2");
         var role3Name:String = gc.getRoleSwfNameByRoleName("Role3");
         var role4Name:String = gc.getRoleSwfNameByRoleName("Role4");
         this.loadAssets(["RankTopv3560.swf",role1Name + ".swf",role2Name + ".swf",role3Name + ".swf",role4Name + ".swf"]);
      }
   }
}
