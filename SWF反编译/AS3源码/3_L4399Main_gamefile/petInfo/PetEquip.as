package petInfo
{
   import config.Config;
   import my.PetEquipObj;
   
   public class PetEquip
   {
       
      
      private var _equipArray:Array;
      
      private var pInfo:PetInfo;
      
      private var gc:Config;
      
      public function PetEquip(_petInfo:PetInfo)
      {
         _equipArray = [];
         super();
         gc = Config.getInstance();
         this.pInfo = _petInfo;
      }
      
      public function refreshEquip(newEquipArray:Array) : void
      {
         this.removeAll();
         this._equipArray = newEquipArray;
         this.addAll();
      }
      
      private function addSuitEffectBySuitArray(suitEffect:Array) : void
      {
         var rate:Number = 0;
         for each(var obj in suitEffect)
         {
            if(obj.type == PetSuit.SUIT_ADD_ATK)
            {
               this.pInfo.setAtk(this.pInfo.getAtk() + obj.value);
            }
            else if(obj.type == PetSuit.SUIT_ADD_CRIT)
            {
               this.pInfo.setCrit(this.pInfo.getCrit() + obj.value);
            }
            else if(obj.type == PetSuit.SUIT_ADD_EATBLOOD)
            {
               this.pInfo.setEatBlood(this.pInfo.getEatBlood() + obj.value);
            }
            else if(obj.type == PetSuit.SUIT_ADD_HP)
            {
               rate = this.pInfo.getHp() / this.pInfo.getSHp();
               this.pInfo.setHp(this.pInfo.getHp() + obj.value * rate);
               this.pInfo.setSHp(this.pInfo.getSHp() + obj.value);
            }
            else if(obj.type == PetSuit.SUIT_ADD_MDEF)
            {
               this.pInfo.setMDef(this.pInfo.getMDef() + obj.value);
            }
         }
      }
      
      private function removeSuitEffectBySuitArray(suitEffect:Array) : void
      {
         var rate:Number = 0;
         for each(var obj in suitEffect)
         {
            if(obj.type == PetSuit.SUIT_ADD_ATK)
            {
               this.pInfo.setAtk(this.pInfo.getAtk() - obj.value);
            }
            else if(obj.type == PetSuit.SUIT_ADD_CRIT)
            {
               this.pInfo.setCrit(this.pInfo.getCrit() - obj.value);
            }
            else if(obj.type == PetSuit.SUIT_ADD_EATBLOOD)
            {
               this.pInfo.setEatBlood(this.pInfo.getEatBlood() - obj.value);
            }
            else if(obj.type == PetSuit.SUIT_ADD_HP)
            {
               rate = this.pInfo.getHp() / this.pInfo.getSHp();
               this.pInfo.setHp(this.pInfo.getHp() - obj.value * rate);
               this.pInfo.setSHp(this.pInfo.getSHp() - obj.value);
            }
            else if(obj.type == PetSuit.SUIT_ADD_MDEF)
            {
               this.pInfo.setMDef(this.pInfo.getMDef() - obj.value);
            }
         }
      }
      
      private function removeAll() : void
      {
         var rate:Number = NaN;
         var suitEffect:Array = gc.petSuitInfo.getSuitEffectByEquipArray(this._equipArray);
         if(suitEffect.length > 0)
         {
            this.removeSuitEffectBySuitArray(suitEffect);
         }
         var suitJNEffect:Array = gc.petJNSuitInfo.getSuitEffectByEquipArray(this._equipArray);
         if(suitJNEffect.length > 0)
         {
            this.removeSuitEffectBySuitArray(suitJNEffect);
         }
         for each(var pEquip in this._equipArray)
         {
            rate = this.pInfo.getHp() / this.pInfo.getSHp();
            this.pInfo.setHp(this.pInfo.getHp() - pEquip.getehp() * rate);
            this.pInfo.setSHp(this.pInfo.getSHp() - pEquip.getehp());
            rate = this.pInfo.getMp() / this.pInfo.getSMp();
            this.pInfo.setMp(this.pInfo.getMp() - pEquip.getemp() * rate);
            this.pInfo.setSMp(this.pInfo.getSMp() - pEquip.getemp());
            this.pInfo.setDef(this.pInfo.getDef() - pEquip.getedef());
            this.pInfo.setAtk(this.pInfo.getAtk() - pEquip.geteatt());
            this.pInfo.setMiss(this.pInfo.getMiss() - pEquip.getemiss());
            this.pInfo.setCrit(this.pInfo.getCrit() - pEquip.getecrit());
            this.pInfo.setMDef(this.pInfo.getMDef() - pEquip.getmagicdef());
            this.pInfo.setEHp(this.pInfo.getEHp() - pEquip.geteahp());
            this.pInfo.setEMp(this.pInfo.getEMp() - pEquip.geteamp());
            this.pInfo.setEatBlood(this.pInfo.getEatBlood() - pEquip.geteatblood());
            this.pInfo.setMoveSpeed(this.pInfo.getMoveSpeed() - pEquip.getspeed());
         }
      }
      
      private function addAll() : void
      {
         var rate:Number = NaN;
         for each(var pEquip in this._equipArray)
         {
            rate = this.pInfo.getHp() / this.pInfo.getSHp();
            this.pInfo.setHp(this.pInfo.getHp() + pEquip.getehp() * rate);
            this.pInfo.setSHp(this.pInfo.getSHp() + pEquip.getehp());
            rate = this.pInfo.getMp() / this.pInfo.getSMp();
            this.pInfo.setMp(this.pInfo.getMp() + pEquip.getemp() * rate);
            this.pInfo.setSMp(this.pInfo.getSMp() + pEquip.getemp());
            this.pInfo.setDef(this.pInfo.getDef() + pEquip.getedef());
            this.pInfo.setAtk(this.pInfo.getAtk() + pEquip.geteatt());
            this.pInfo.setMiss(this.pInfo.getMiss() + pEquip.getemiss());
            this.pInfo.setCrit(this.pInfo.getCrit() + pEquip.getecrit());
            this.pInfo.setMDef(this.pInfo.getMDef() + pEquip.getmagicdef());
            this.pInfo.setEHp(this.pInfo.getEHp() + pEquip.geteahp());
            this.pInfo.setEMp(this.pInfo.getEMp() + pEquip.geteamp());
            this.pInfo.setEatBlood(this.pInfo.getEatBlood() + pEquip.geteatblood());
            this.pInfo.setMoveSpeed(this.pInfo.getMoveSpeed() + pEquip.getspeed());
         }
         var suitEffect:Array = gc.petSuitInfo.getSuitEffectByEquipArray(this._equipArray);
         if(suitEffect.length > 0)
         {
            this.addSuitEffectBySuitArray(suitEffect);
         }
         var suitJNEffect:Array = gc.petJNSuitInfo.getSuitEffectByEquipArray(this._equipArray);
         if(suitJNEffect.length > 0)
         {
            this.addSuitEffectBySuitArray(suitJNEffect);
         }
      }
      
      public function get equipArray() : Array
      {
         return _equipArray;
      }
   }
}
