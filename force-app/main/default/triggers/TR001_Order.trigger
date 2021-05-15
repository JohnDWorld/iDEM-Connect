/**
 * 
 * Trigger on Order
 * 
 * @author JohnDWorld
 */
trigger TR001_Order on Order (before update, after delete) {

    if(Trigger.isBefore && Trigger.isUpdate){
        APU001_CheckData.CheckOrderWithoutOrderItem(Trigger.newMap);
    } else if(Trigger.isAfter && Trigger.isDelete){
        APU001_CheckData.CheckAccountForOrder(Trigger.oldMap);
    }
}