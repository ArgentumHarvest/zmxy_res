package export.cure
{
   public class BigHP extends SmallHP
   {
       
      
      public function BigHP(used:Boolean = false)
      {
         super();
         this.isUsed = used;
         this.cname = "BHp";
         this.curNum = 200;
         allcount = 192;
      }
   }
}
