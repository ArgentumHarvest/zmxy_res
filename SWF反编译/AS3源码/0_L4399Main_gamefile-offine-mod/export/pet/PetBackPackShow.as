package export.pet
{
   import base.BaseHero;
   import config.Config;
   import event.CommonEvent;
   import export.pet.pstrength.PetStrengthInterface;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import my.PetEquipObj;
   import petInfo.PetInfo;
   import user.User;
   
   public class PetBackPackShow extends Sprite
   {
       
      
      public var zbjn:Sprite;
      
      public var zbst:Sprite;
      
      public var zbmz:Sprite;
      
      public var zbxz:Sprite;
      
      public var zbyf:Sprite;
      
      public var bpmc:Sprite;
      
      public var pbpbtn:SimpleButton;
      
      public var pstrbtn:SimpleButton;
      
      private var gc:Config;
      
      private var gzSprite:Sprite;
      
      private var curPage:uint = 1;
      
      private var allPage:uint = 2;
      
      private var pageNum:uint = 25;
      
      private var pif:PetInfo;
      
      private var player:User;
      
      private var lastBtn:String = "";
      
      private var btnState;
      
      private var curShowTag:uint = 1;
      
      public function PetBackPackShow(_user:User, _pif:PetInfo)
      {
         super();
         gc = Config.getInstance();
         pif = _pif;
         this.player = _user;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.curequip();
         zbst.addEventListener("click",zbClick);
         zbmz.addEventListener("click",zbClick);
         zbxz.addEventListener("click",zbClick);
         zbyf.addEventListener("click",zbClick);
         zbjn.addEventListener("click",zbClick);
         pbpbtn.addEventListener("click",petBackPackClick);
         pstrbtn.addEventListener("click",petStrengthClick);
         gc.eventManger.addEventListener("STRENGTHUPDATECHANGEEQUIP",changeEquip);
         pbpbtn.dispatchEvent(new MouseEvent("click"));
      }
      
      private function removed(e:Event) : void
      {
         zbst.removeEventListener("click",zbClick);
         zbmz.removeEventListener("click",zbClick);
         zbxz.removeEventListener("click",zbClick);
         zbyf.removeEventListener("click",zbClick);
         zbjn.removeEventListener("click",zbClick);
         pbpbtn.removeEventListener("click",petBackPackClick);
         pstrbtn.removeEventListener("click",petStrengthClick);
         gc.eventManger.removeEventListener("STRENGTHUPDATECHANGEEQUIP",changeEquip);
      }
      
      public function changePetInfo(_pif:PetInfo) : void
      {
         this.pif = _pif;
      }
      
      private function petBackPackClick(e:MouseEvent) : void
      {
         this.refreshInterface();
         this.curShowTag = 1;
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "pbpbtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function petStrengthClick(e:MouseEvent) : void
      {
         if(gzSprite && bpmc.contains(gzSprite))
         {
            bpmc.removeChild(gzSprite);
            gzSprite = null;
         }
         if(bpmc.getChildByName("PetStrengthInterface") != null)
         {
            bpmc.removeChild(bpmc.getChildByName("PetStrengthInterface"));
         }
         var psi:PetStrengthInterface = new PetStrengthInterface(this.player);
         psi.name = "PetStrengthInterface";
         psi.x = -2;
         psi.y = 3.5;
         bpmc.addChild(psi);
         this.curShowTag = 2;
         if(btnState)
         {
            if(lastBtn != "")
            {
               this[lastBtn].upState = btnState;
            }
         }
         lastBtn = "pstrbtn";
         btnState = e.target.upState;
         e.target.upState = e.target.downState;
      }
      
      private function zbClick(e:MouseEvent) : void
      {
         var ary:* = null;
         var sit:int = 0;
         trace("zbClick");
         if(pif == null)
         {
            return;
         }
         var sz:PetShowObj = e.currentTarget.getChildByName("curzb") as PetShowObj;
         if(sz)
         {
            if(this.curShowTag == 1)
            {
               e.currentTarget.removeChild(sz);
               ary = this.pif.getEquipArray();
               sit = ary.indexOf(sz.getPetEquipObj());
               if(sit != -1)
               {
                  ary.splice(sit,1);
               }
               this.refreshEquipByPlayer(ary);
               sz.getPetEquipObj().setPetInfo(null);
               this.player.plist.push(sz.getPetEquipObj());
               this.refreshInterface();
               if(e.currentTarget.name == "zbjn")
               {
                  if(sz.getPetEquipObj().getFillName() == "p_cyzsjl" || sz.getPetEquipObj().getFillName() == "p_jlcyzsjl" || sz.getPetEquipObj().getFillName() == "p_sscyzsjl")
                  {
                     this.pif.removeMouseAoYi("zsaoyi");
                  }
                  else if(sz.getPetEquipObj().getFillName() == "p_cycnjl" || sz.getPetEquipObj().getFillName() == "p_jlcycnjl" || sz.getPetEquipObj().getFillName() == "p_sscycnjl")
                  {
                     this.pif.removeMouseAoYi("cnaoyi");
                  }
               }
               sz = null;
            }
            else
            {
               gc.eventManger.dispatchEvent(new CommonEvent("STRENGTHPETEQUIPMENT",[sz.getPetEquipObj()]));
            }
         }
      }
      
      private function refreshEquipByPlayer(ary:Array) : void
      {
         var bh:BaseHero = this.getHeroByPlayer(this.player);
         if(bh)
         {
            if(bh.isDead())
            {
               this.pif.refreshEquip(ary);
            }
            else if(this.player.findCurrentPet(true) == pif && pif.getHp() > 0)
            {
               this.pif.callPetToRefreshEquip(ary);
            }
            else
            {
               this.pif.refreshEquip(ary);
            }
         }
      }
      
      private function getHeroByPlayer(player:User) : BaseHero
      {
         if(player.roleid > 0)
         {
            if(player.controlPlayer == 0)
            {
               return gc.hero1;
            }
            return gc.hero2 || gc.hero3;
         }
         return null;
      }
      
      private function changeEquip(e:CommonEvent) : void
      {
         var temp:* = null;
         var petEquip:* = null;
         var newPetEquip:* = null;
         if(this[e.data[0]].getChildByName("curzb") != null)
         {
            temp = this[e.data[0]].getChildByName("curzb");
            this[e.data[0]].removeChild(temp);
            temp = null;
         }
         var ary:Array = this.pif.getEquipArray();
         for(var alen:uint = ary.length; alen-- > 0; )
         {
            if(ary[alen].type == e.data[1].type)
            {
               newPetEquip = e.data[1];
               petEquip = gc.allEquip.findByName(newPetEquip.getFillName());
               petEquip.setehp(newPetEquip.getehp(true));
               petEquip.setemp(newPetEquip.getemp(true));
               petEquip.seteatt(newPetEquip.geteatt(true));
               petEquip.setedef(newPetEquip.getedef(true));
               petEquip.setecrit(newPetEquip.getecrit());
               petEquip.setemiss(newPetEquip.getemiss());
               petEquip.seteahp(newPetEquip.geteahp());
               petEquip.seteamp(newPetEquip.geteamp());
               petEquip.setmagicdef(newPetEquip.getmagicdef());
               petEquip.setspeed(newPetEquip.getspeed());
               petEquip.seteatblood(newPetEquip.geteatblood(true));
               petEquip.setStrengthValue(newPetEquip.getStrengthValue());
               petEquip.setPetInfo(this.pif);
               ary[alen] = petEquip;
               break;
            }
         }
         this.refreshEquipByPlayer(ary);
         this.curequip();
      }
      
      private function drawgz(list:Array) : void
      {
         var temp:* = null;
         var i:* = 0;
         var j:* = 0;
         var t:uint = 0;
         for(i = uint(0); i < 3; )
         {
            for(j = uint(0); j < 5; )
            {
               temp = AUtils.getNewObj("export.pet.PetPackThings") as PetPackThings;
               temp.x = j * (temp.width + 3);
               temp.y = i * (temp.height + 3);
               gzSprite.addChildAt(temp,0);
               if(list[t + (curPage - 1) * 25])
               {
                  temp.setObj(list[t + (curPage - 1) * 25],this.player);
                  t++;
               }
               j++;
            }
            i++;
         }
      }
      
      private function reSetBackPackageTile() : void
      {
         if(gzSprite && bpmc.contains(gzSprite))
         {
            bpmc.removeChild(gzSprite);
            gzSprite = null;
         }
         gzSprite = new Sprite();
         bpmc.addChild(gzSprite);
      }
      
      public function pifIsNull() : Boolean
      {
         if(this.pif == null)
         {
            return true;
         }
         return false;
      }
      
      public function equip(_name:String, zb:PetEquipObj) : void
      {
         var temp:* = null;
         if(this[_name].getChildByName("curzb") != null)
         {
            temp = this[_name].getChildByName("curzb");
            this[_name].removeChild(temp);
            this.player.plist.push(temp.getPetEquipObj());
         }
         var ary:Array = this.pif.getEquipArray();
         var alen:uint = ary.length;
         for(var tag:Boolean = false; alen-- > 0; )
         {
            if(ary[alen].type == zb.type)
            {
               zb.setPetInfo(this.pif);
               ary[alen] = zb;
               tag = true;
               break;
            }
         }
         if(!tag)
         {
            zb.setPetInfo(this.pif);
            ary.push(zb);
         }
         this.refreshEquipByPlayer(ary);
         if(temp)
         {
            temp.getPetEquipObj().setPetInfo(null);
         }
         this.refreshInterface();
         if(zb.getFillName() == "p_cyzsjl" || zb.getFillName() == "p_jlcyzsjl" || zb.getFillName() == "p_sscyzsjl")
         {
            this.pif.addMouseAoYi("mouse","zsaoyi");
         }
         else if(zb.getFillName() == "p_cycnjl" || zb.getFillName() == "p_jlcycnjl" || zb.getFillName() == "p_sscycnjl")
         {
            this.pif.addMouseAoYi("neat","cnaoyi");
         }
         else if(zb.getFillName() == "p_cyyhjl" || zb.getFillName() == "p_jlcyyhjl" || zb.getFillName() == "p_sscyyhjl")
         {
            this.pif.addMouseAoYi("terribletiger","yhaoyi");
         }
      }
      
      public function refreshInterface() : void
      {
         if(bpmc.getChildByName("PetStrengthInterface") != null)
         {
            bpmc.removeChild(bpmc.getChildByName("PetStrengthInterface"));
         }
         this.reSetBackPackageTile();
         this.drawgz(this.player.plist);
         this.curequip();
      }
      
      private function removeAll() : void
      {
         var temp:* = null;
         if(zbst.getChildByName("curzb") != null)
         {
            temp = zbst.getChildByName("curzb") as PetShowObj;
            zbst.removeChild(temp);
         }
         if(zbmz.getChildByName("curzb") != null)
         {
            temp = zbmz.getChildByName("curzb") as PetShowObj;
            zbmz.removeChild(temp);
         }
         if(zbxz.getChildByName("curzb") != null)
         {
            temp = zbxz.getChildByName("curzb") as PetShowObj;
            zbxz.removeChild(temp);
         }
         if(zbyf.getChildByName("curzb") != null)
         {
            temp = zbyf.getChildByName("curzb") as PetShowObj;
            zbyf.removeChild(temp);
         }
         if(zbjn.getChildByName("curzb") != null)
         {
            temp = zbjn.getChildByName("curzb") as PetShowObj;
            zbjn.removeChild(temp);
         }
         temp = null;
      }
      
      private function curequip() : void
      {
         var sobj:* = null;
         if(pif == null)
         {
            return;
         }
         this.removeAll();
         var ary:Array = this.pif.getEquipArray();
         for(var alen:uint = ary.length; alen-- > 0; )
         {
            ary[alen].setPetInfo(this.pif);
            sobj = new PetShowObj(ary[alen]);
            sobj.y = -2;
            if(this[ary[alen].type].numChildren <= 1)
            {
               this[ary[alen].type].addChild(sobj);
            }
         }
         gc.eventManger.dispatchEvent(new CommonEvent("PETEQUIPMENTOVER"));
      }
   }
}
