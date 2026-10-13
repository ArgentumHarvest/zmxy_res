package union.model.vo
{
   import config.Config;
   import union.model.Unify;
   import union.model.UnionManager;
   import union.model.vo.utils.VoBasic;
   import union.utils.UnionConfig;
   
   public class UnionInfoVo extends VoBasic
   {
       
      
      public var id:uint;
      
      public var gameId:uint;
      
      public var uId:Number;
      
      public var username:String;
      
      public var index:uint;
      
      public var title:String;
      
      public var level:uint = 0;
      
      public var experience:uint;
      
      public var contribution:uint;
      
      public var extra:String;
      
      public var extra2:String;
      
      public var dissolveDate:uint;
      
      public var count:uint;
      
      public var transfer:String;
      
      public var tasks:Array;
      
      public var memberVo:MemberVo;
      
      private var memberVos:Array;
      
      public function UnionInfoVo()
      {
         tasks = [];
         super();
      }
      
      public function get hasUnion() : Boolean
      {
         return !!id;
      }
      
      public function updateMember(data:Object) : void
      {
         memberVo = new MemberVo();
         memberVo.buildFromObject(data);
         Unify.gc.honorData.groupId = -1;
         if(hasUnion)
         {
            Unify.gc.honorData.allianceLevel = level;
            Unify.gc.honorData.score = memberVo.contribution;
            Unify.gc.honorData.groupId = id;
            Unify.gc.honorData.honorName = title;
            Unify.gc.honorData.jobName = memberVo.jobTitle;
         }
      }
      
      public function updateAllMember(arr:Array) : void
      {
         var i:int = 0;
         var vo:* = null;
         memberVos = [];
         for(i = 0; i < arr.length; )
         {
            vo = new MemberVo();
            vo.updateFromObject(arr[i]);
            memberVos.push(vo);
            i++;
         }
         Unify.arraySortByParam(memberVos,"roleId",true);
      }
      
      public function pushMember(vo:MemberVo) : void
      {
         memberVos.push(vo);
      }
      
      public function deleteMember(uId:Number) : void
      {
         var i:int = 0;
         var vo:* = null;
         var len:int = memberVos.length;
         for(i = 0; i < len; )
         {
            vo = memberVos[i];
            Unify.log(vo.uId == uId,vo.uId,uId);
            if(vo.uId == uId)
            {
               memberVos.splice(i,1);
               return;
            }
            i++;
         }
      }
      
      public function get allMembers() : Array
      {
         return memberVos;
      }
      
      public function changeNote(value:String) : void
      {
         var da:Object = Unify.getJsonData(extra);
         da["note"] = value;
         saveExtra(da);
      }
      
      public function changeTeam(value:int) : void
      {
         var da:Object = Unify.getJsonData(extra);
         da["team"] = value;
         saveExtra(da);
      }
      
      private function saveExtra(da:Object) : void
      {
         extra = JSON.stringify(da);
         UnionManager.getIns().setUnionExtra(1,extra,id);
      }
      
      public function get note() : String
      {
         var da:Object = Unify.getJsonData(extra);
         return da.note || "无";
      }
      
      public function get team() : String
      {
         return Unify.getTeam(extra);
      }
      
      public function get isLeader() : Boolean
      {
         return uId == Config.getInstance().logInfo.uid;
      }
      
      public function addExp(value:int) : void
      {
         var i:int = 0;
         var vo:* = null;
         experience += value;
         contribution += value;
         memberVo.contribution += value;
         for(i = 0; i < memberVos.length; )
         {
            vo = memberVos[i];
            if(vo.uId == memberVo.uId)
            {
               vo.contribution += value;
            }
            i++;
         }
         level = UnionConfig.getUnionLevel(experience);
      }
      
      public function set personMoney(value:int) : void
      {
         memberVo.contribution = value;
         Unify.gc.honorData.score = memberVo.contribution;
      }
      
      public function get personMoney() : int
      {
         return memberVo.contribution;
      }
      
      public function getMemberJob(type:int) : int
      {
         var i:int = 0;
         var vo:* = null;
         var value:int = 0;
         var len:int = memberVos.length;
         for(i = 0; i < len; )
         {
            vo = memberVos[i];
            if(vo.roleId == type)
            {
               value++;
            }
            i++;
         }
         return value;
      }
   }
}
