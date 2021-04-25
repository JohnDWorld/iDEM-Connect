/**
 * 
 * Class test for APU001_CheckData and TR001_Order
 * 
 * @author JohnDWorld
 */
@isTest
private class APU001_CheckData_TEST {
    //Setup the Data for the test
    @TestSetup
    static void setup(){
        Account account = TestDataFactory.createAccount();
        insert account;

        Product2 product2 = TestDataFactory.createProduct2();
        insert product2;

        PricebookEntry priceBook = TestDataFactory.createPriceBook(product2);
        insert priceBook;
        
        List<Order> ordersList = TestDataFactory.createListOrders(account, priceBook, 10);
        insert ordersList;

        List<OrderItem> orderItemsList = TestDataFactory.createListOrderItems(ordersList, priceBook);
        insert orderItemsList;
    }

    //Implementation Test of CheckOrderWithoutOrderItem Method
    @isTest static void CheckOrderWithoutOrderItem_TEST() {
        //Change status and delete order item
        List<Order> orders = [SELECT Status, (SELECT Id FROM OrderItems) FROM Order];
        List<Order> odrToUpd = new List<Order>();
        for(Order order: orders){
            order.Status = 'Activated';
            delete order.OrderItems;
            odrToUpd.add(order);
        }

        Test.startTest();
        try {
            update odrToUpd;
        } catch (Exception e) {
            Boolean expectedExceptionThrown =  e.getMessage().contains('An order must have at least one product.') ? true : false; 
            System.AssertEquals(expectedExceptionThrown, true); 
        }
        Test.stopTest();

        //The order without order item will have status = draft
        orders = [SELECT Status, (SELECT Id FROM OrderItems) FROM Order];
        for(Order order: orders){
            System.assertEquals('Draft', order.Status);
        }
    }

    //Implementation test of CheckAccountForOrder Method
    @isTest static void CheckAccountWithoutOtherOrder_TEST() {
        //Pass active case on true
        Account account = [SELECT Id, Active__c, (SELECT Id FROM Orders) FROM Account WHERE Name='Test Account'];
        account.Active__c = true;

        Test.startTest();
        for(Order order: account.Orders){
            delete order;
        }
        Test.stopTest();

        //Check case active is false without order
        account = [SELECT Active__c FROM Account WHERE Name='Test Account'];
        System.assertEquals(false, account.Active__c);
    }
}