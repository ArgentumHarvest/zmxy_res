package AssetsClass
{
   import export.pet.PetInterface;
   import petInfo.PetInfo;
   import user.User;
   
   public class PetInterfaceAssets extends BaseAssets
   {
       
      
      public function PetInterfaceAssets(_user:User)
      {
         var pi:* = null;
         var petName:* = null;
         var petSwfName:* = null;
         super(PetInterface,[_user]);
         var returnArray:Array = [];
         var players:Array = gc.getUsersArray();
         for each(var player in players)
         {
            for each(pi in player.petsAry)
            {
               petName = pi.getPetPreName();
               petSwfName = gc.getPetSwfNameByPetName(petName);
               if(returnArray.indexOf(petSwfName + ".swf") == -1)
               {
                  returnArray.push(petSwfName + ".swf");
               }
            }
         }
         returnArray.push("PetInterfacev1270.swf");
         this.loadAssets(returnArray);
      }
   }
}
