package union.utils
{
   import union.model.Unify;
   import union.model.UnionManager;
   
   public class UnionConfig
   {
      
      public static const jobs:Array = ["{\"level\":\"1;10\",\"fmz\":1,\"hf\":4,\"jy\":6}","{\"level\":\"11;20\",\"fmz\":2,\"hf\":4,\"jy\":6}","{\"level\":\"21;40\",\"fmz\":3,\"hf\":6,\"jy\":8}","{\"level\":\"31;50\",\"fmz\":3,\"hf\":6,\"jy\":8}","{\"level\":\"51;999\",\"fmz\":3,\"hf\":6,\"jy\":8}"];
      
      public static const createItem:String = "{\"itemId\":100001,\"num\":1}";
      
      public static const contribute1:Array = ["联盟资金+50","个人贡献+50","消耗点券：100","剩余次数：num"];
      
      public static const contribute2:Array = ["联盟资金+50","个人贡献+50","消耗灵魂：100","剩余次数：num"];
      
      public static const contriTicket:int = 100;
      
      public static const contriSprite:int = 100;
      
      public static var contriSpriteTaskId:int = 107;
      
      public static var contriTicketTaskId:int = 109;
      
      public static var commonVarGx:int = 215;
      
      public static const conNumTicket:int = 1;
      
      public static const conNumSprite:int = 1;
      
      public static const selectTeamLevel:int = 2;
      
      public static const selectTeamTicket:int = 100;
      
      public static const createTicket:int = 5000;
      
      public static const ZW_MZ:int = 9999;
      
      public static var ZW_FMZ:int = 27;
      
      public static var ZW_HF:int = 26;
      
      public static var ZW_JY:int = 25;
      
      public static const ZW_CY:int = 0;
      
      public static const NA_FMZ:String = "副盟主";
      
      public static const NA_HF:String = "护法";
      
      public static const NA_JY:String = "精英";
      
      public static const NA_CY:String = "成员";
      
      public static const GX_PT:int = 50;
      
      public static const GX_DJ:int = 50;
      
      public static var gxCount:int = 0;
      
      public static const TIP_ZYSM:String = "联盟等级达到num级后，可选择不同的联盟阵营加入。加入对应阵营后，更换阵营需消耗num点券";
      
      public static const TIP_FWQM:String = "服务器繁忙，稍后再试";
      
      public static const TIP_MGC:String = "包含敏感词，请修改!";
      
      public static const TIP_TCLM:String = "你确定要退出联盟吗？";
      
      public static const TIP_TCCY:String = "你确定踢出num吗？";
      
      public static const TIP_DJGX:String = "你确定消耗num点券贡献吗？";
      
      public static const TIP_XZZY:String = "确定消耗num点券，选择num阵营吗？";
      
      public static const TIP_CJLM:String = "确定消耗num点券，创建联盟吗？";
      
      public static const TIP_ZYXT:String = "你已经是该阵营的了";
      
      public static const TIP_JOB:String = "num职位人数已经满了";
      
      public static const TIP_GX:String = "今日普通贡献次数已满";
      
      public static const ERROR_CODE:Object = {
         "10002":"参数错误",
         "10003":"游戏未开通联盟API",
         "10004":"只有盟主有权限",
         "10005":"用户未登陆",
         "20001":"用户没有钱",
         "20002":"余额不足",
         "20003":"扣款失败",
         "20004":"联盟名称已存在",
         "20005":"一个用户的一个存档，只能建一个联盟",
         "20006":"超过申请数量上限",
         "20007":"该联盟的申请列表已满",
         "20008":"用户已经有联盟了",
         "20009":"已经申请过了",
         "20010":"用户还没有加入任何联盟",
         "20011":"不存在该联盟",
         "20012":"移除成员失败，用户不属于该联盟",
         "20013":"移除成员失败，盟主不能被移除",
         "20014":"审核失败，联盟成员已满",
         "20015":"编辑extra失败，只有盟主有该权限",
         "20016":"超过最大贡献值",
         "20017":"不存在该公共变量",
         "20018":"超过最大数量",
         "20019":"extra的字符数超过最大个数限制（1500）",
         "20020":"退出联盟后，24小时内不能申请加联盟",
         "20021":"没有兑换配置",
         "20022":"用户的申请信息已经过期",
         "20023":"联盟id错误",
         "20024":"已经申请过解散联盟了",
         "20025":"没有该任务",
         "20026":"用户不在审核列表中",
         "20027":"只有在加入联盟的24小时后才能进行贡献",
         "20028":"没有解散过联盟，不能进行取消解散",
         "20029":"公共变量未到生效时间",
         "20030":"账号不能变换存档加入同一个联盟。",
         "20031":"贡献点不足",
         "20032":"用户不在该联盟中",
         "20033":"不能转让给自己",
         "20034":"不存在的转让",
         "20035":"转让已存在",
         "20036":"解散状态不能转让",
         "20037":"转让状态不能解散",
         "20038":"未过24小时时间限制",
         "20039":"移除成员失败，自己不能被移除",
         "30001":"数据库添加失败",
         "30002":"数据库删除失败",
         "40001":"特殊用户的type填写错误",
         "40002":"没有这个用户",
         "60001":"角色不存在",
         "60002":"角色没有足够的权限"
      };
      
      private static var _unionExps:Array = [0,4500,18500,56000,116000,203500,323500,458500,658500,878500,1238500,1628500,2188500,2938500,3898500,5088500,6438500];
      
      private static var _unionMembers:Array = [30,30,40,50,60,70,80,90,100,110,120,130,140,150,160,170,180,200,200];
      
      public static var isSave:Boolean = false;
       
      
      public function UnionConfig()
      {
         super();
      }
      
      public static function initConfig(release:Boolean) : void
      {
         if(release)
         {
            ZW_FMZ = 30;
            ZW_HF = 29;
            ZW_JY = 28;
            contriSpriteTaskId = 110;
            contriTicketTaskId = 109;
            commonVarGx = 253;
         }
      }
      
      public static function get unionExps() : Array
      {
         return _unionExps;
      }
      
      public static function getUnionMembers(level:int) : int
      {
         return _unionMembers[level];
      }
      
      public static function getUnionLevel(exp:int) : int
      {
         var i:int = 0;
         var level:* = int(1);
         var exps:Array = unionExps;
         for(i = 0; i < exps.length; )
         {
            if(exp < exps[i])
            {
               level = i;
               break;
            }
            i++;
         }
         return level;
      }
      
      public static function getMemberJob(type:String) : int
      {
         var i:int = 0;
         var da:* = null;
         var lvls:* = null;
         var value:int = 0;
         var level:int = UnionManager.getIns().unionLevel;
         var len:int = jobs.length;
         for(i = 0; i < len; )
         {
            da = Unify.getJsonData(jobs[i]);
            lvls = da.level.split(";");
            if(lvls[0] <= level && level <= lvls[1])
            {
               value = da[type];
               break;
            }
            i++;
         }
         return value;
      }
      
      public static function get maxContribute() : int
      {
         return int(_unionMembers[UnionManager.getIns().unionLevel]);
      }
      
      public static function get canContribute() : Boolean
      {
         Unify.log("可贡献最大次数" + maxContribute + ",当前次数" + gxCount);
         var value:Boolean = maxContribute >= gxCount;
         if(!value)
         {
            Unify.alert("今日普通贡献次数已满");
         }
         return value;
      }
      
      public static function saveData() : void
      {
         if(isSave)
         {
            Unify.saveData();
         }
      }
   }
}
