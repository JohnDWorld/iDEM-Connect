/**
 * 
 * Class to check data in function of trigger
 * 
 * @author JohnDWorld
 */
public with sharing class APU001_CheckData {
    //Method to check order item before update his status
    public static void CheckOrderWithoutOrderItem(List<Order> orders) {
        for(Order order: orders){
            if(order.Status == 'Actived' && order.OrderItems.size() == 0){
                order.Status = 'Draft';
                order.addError('No items detected. Please insert items to update the order status.');
            }
        }
    }
}