package union.model.vo
{
   import union.model.Unify;
   import union.model.UnionManager;
   import union.model.vo.utils.VoBasic;
   import union.utils.UnionConfig;
   
   public class MemberVo extends VoBasic
   {
       
      
      public var uId:Number;
      
      public var unionId:Number;
      
      public var username:String;
      
      public var index:uint;
      
      public var nickName:String;
      
      public var contribution:uint;
      
      public var roleId:uint = 0;
      
      public var extra:String;
      
      public var extra2:String;
      
      public var active_time:String;
      
      public function MemberVo()
      {
         super();
      }
      
      override public function updateFromObject(o:Object) : void
      {
         super.updateFromObject(o);
         if(isMZ)
         {
            roleId = 9999;
         }
      }
      
      public function get isMZ() : Boolean
      {
         return uId == UnionManager.getIns().unionInfo.uId;
      }
      
      public function get isFMZ() : Boolean
      {
         return roleId == UnionConfig.ZW_FMZ;
      }
      
      public function get isHF() : Boolean
      {
         return roleId == UnionConfig.ZW_HF;
      }
      
      public function get isJY() : Boolean
      {
         return roleId == UnionConfig.ZW_JY;
      }
      
      public function get isCY() : Boolean
      {
         return roleId == 0;
      }
      
      public function get jobTitle() : String
      {
         if(isMZ)
         {
            return "盟主";
         }
         if(isFMZ)
         {
            return "副盟主";
         }
         if(isHF)
         {
            return "护法";
         }
         if(isJY)
         {
            return "精英";
         }
         return "成员";
      }
      
      public function get name() : String
      {
         return nickName || String(uId);
      }
      
      public function changeFightPower() : void
      {
         var da:Object = Unify.getJsonData(extra);
         da["fightPower"] = Unify.fightPower;
         extra = JSON.stringify(da);
         UnionManager.getIns().setMemberExtra(1,extra);
      }
      
      public function get fightPower() : Number
      {
         var da:Object = Unify.getJsonData(extra);
         if(Unify.uidIsMySelf(uId))
         {
            return Unify.fightPower;
         }
         return Number(da.fightPower || 0);
      }
   }
}
