/**
 * 
 * Trigger to call Apex'method CheckOrderWithoutOrderItem
 * 
 * @author JohnDWorld
 */
trigger TR001_Order on Order (before update) {
    APU001_CheckData.CheckOrderWithoutOrderItem(Trigger.newMap);
}