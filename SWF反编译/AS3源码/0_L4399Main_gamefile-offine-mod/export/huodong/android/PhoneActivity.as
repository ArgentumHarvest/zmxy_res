package export.huodong.android
{
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import my.MyEquipObj;
   import petInfo.PetInfo;
   
   public class PhoneActivity extends MiaoMiaoBaseInterface
   {
       
      
      public function PhoneActivity()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://huodong3.4399.com/mclient/"),"_blank");
      }
      
      override protected function lqClick(e:MouseEvent) : void
      {
         var str:* = null;
         str = null;
         var exictmask:* = null;
         var bool:Boolean = false;
         if(gc.player1.roleid > 0)
         {
            str = "1P";
            if(gc.gameVip.getVipLevel() >= 3)
            {
               if(gc.player1.petsAry.length >= 10)
               {
                  str += "宠物栏已满";
               }
            }
            else if(gc.player1.petsAry.length >= 5)
            {
               str += "宠物栏已满";
            }
            if(gc.player1.zblist.length >= gc.player1.getMax())
            {
               str += "装备栏已满 ";
            }
            if(gc.player1.getSomeOneEquipNumberByName("mpyj") <= 0 && gc.player1.djlist.length >= gc.player1.getMax())
            {
               str += "道具栏已满 ";
            }
            if(str != "1P")
            {
               bool = true;
            }
         }
         if(!bool)
         {
            if(gc.player2.roleid > 0)
            {
               str = "2P";
               if(gc.gameVip.getVipLevel() >= 3)
               {
                  if(gc.player2.petsAry.length >= 10)
                  {
                     str += "宠物栏已满";
                  }
               }
               else if(gc.player2.petsAry.length >= 5)
               {
                  str += "宠物栏已满";
               }
               if(gc.player2.zblist.length >= gc.player2.getMax())
               {
                  str += "装备栏已满 ";
               }
               if(gc.player2.getSomeOneEquipNumberByName("mpyj") <= 0 && gc.player2.djlist.length >= gc.player2.getMax())
               {
                  str += "道具栏已满 ";
               }
               if(str != "2P")
               {
                  bool = true;
               }
            }
         }
         if(bool)
         {
            exictmask = gc.stage.getChildByName("execuitionActionrenewalse") as Sprite;
            if(exictmask)
            {
               gc.stage.removeChild(exictmask);
               exictmask = null;
            }
            gc.ts.setTxt(str);
            gc.stage.addChild(gc.ts);
            return;
         }
         super.lqClick(e);
      }
      
      override protected function getPresent(_result:uint) : void
      {
         if(_result == 267)
         {
            if(gc.player1.roleid > 0)
            {
               gc.player1.petsAry.push(this.getPet());
               gc.putQhsInBackPack(gc.player1,"mpyj",1);
               gc.player1.zblist.push(this.getEquip());
            }
            if(gc.player2.roleid > 0)
            {
               gc.player2.petsAry.push(this.getPet());
               gc.putQhsInBackPack(gc.player2,"mpyj",1);
               gc.player2.zblist.push(this.getEquip());
            }
            gc.ts.setTxt("孟婆药剂X1、子鼠宝宝X1、阴阳斩龙剑X1");
            gc.stage.addChild(gc.ts);
         }
         if(gc.isHideDebug)
         {
            gc.memory.setStorage(gc.luanqibazaojiami.saveId);
         }
      }
      
      private function getPet() : PetInfo
      {
         var pif:PetInfo = new PetInfo();
         pif.setPetNameAndLevel("mouse1",1);
         pif.setperception(5);
         pif.setwarpower(4);
         pif.settechnique(4);
         pif.sethpQuality(1500);
         pif.setmpQuality(200);
         pif.setatkQuality(1500);
         pif.setdefQuality(400);
         pif.setHp(1000);
         pif.setMp(300);
         pif.setAtk(50);
         pif.setDef(10);
         pif.setSHp(pif.getHp());
         pif.setSMp(pif.getMp());
         return pif;
      }
      
      private function getEquip() : MyEquipObj
      {
         var equip:MyEquipObj = gc.allEquip.findByName("yyzlj");
         equip.setEupdata(2.4);
         equip.setWX({
            "jin":false,
            "mu":true,
            "shui":false,
            "huo":false,
            "tu":false
         });
         return equip;
      }
   }
}
