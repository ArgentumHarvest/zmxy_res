package myanalysis
{
   import config.Config;
   import flash.display.Sprite;
   import my.MyEquipObj;
   import user.User;
   
   public class MyAnalyzingEquip extends Sprite
   {
       
      
      private var gc:Config;
      
      private var meid:MyAllEquipId;
      
      public function MyAnalyzingEquip()
      {
         super();
         gc = Config.getInstance();
         meid = MyAllEquipId.getInstance();
      }
      
      public function readChangeEquipment(data:Object, callIdObj:Object) : void
      {
         var fillname:String = meid.idTransFillName(data.proId + "");
         var findEquip:MyEquipObj = gc.allEquip.findByName(fillname);
         if(findEquip == null)
         {
            return;
         }
         findEquip.setnum(int(data.count));
         findEquip.setbackpackid(int(data.pId));
         if(data.keys != undefined)
         {
            for(var n in data.keys)
            {
               findEquip.setEquipSaveObj([n,data.keys[n]]);
            }
         }
         if(data.hideKeys != undefined)
         {
            for(var nn in data.hideKeys)
            {
               findEquip.setEquipSaveObj([nn,data.hideKeys[nn]]);
            }
         }
         var player:User = gc["player" + callIdObj.playerid] as User;
         if(callIdObj.whichpack == 0)
         {
            player.zblist.push(findEquip);
         }
         else if(callIdObj.whichpack == 1)
         {
            player.djlist.push(findEquip);
         }
         else if(callIdObj.whichpack == 2)
         {
            player.szlist.push(findEquip);
         }
         else if(callIdObj.whichpack == 3)
         {
            player.curarray.push(findEquip);
         }
      }
   }
}
