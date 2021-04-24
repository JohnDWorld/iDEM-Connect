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
        
        Order order = TestDataFactory.createOrder(account, priceBook);
        insert order;

        OrderItem orderItem = TestDataFactory.createOrderItem(order, priceBook);
        insert orderItem;
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
            System.Assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'));
            System.Assert(e.getMessage().contains('No items detected. Please insert items to update the order status.'));
        }
        Test.stopTest();

        //The order without order item will have status = draft
        orders = [SELECT Status, (SELECT Id FROM OrderItems) FROM Order];
        for(Order order: orders){
            System.assertEquals('Draft', order.Status);
        }
    }
}
