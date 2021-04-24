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
            if(order.Status == 'Activated' && order.OrderItems.size() == 0){
                order.Status = 'Draft';
                order.addError('No items detected. Please insert items to update the order status.');
            }
        }
    }

    //Method to check case active on account
    public static void CheckAccountForOrder(Map<Id,Order> orders) {
        List<Account> accounts = new List<Account>();
        for(Account account : [SELECT Active__c, (SELECT Id FROM Orders WHERE Id IN :orders.keySet()) FROM Account]){
            if (account.Orders.size() == 0) {
                account.active__c = false;
            }
            accounts.add(account);
        }
        update accounts;
    }
}