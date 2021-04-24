/**
 * 
 * Class to setup data for the test
 * 
 * @author JohnDWorld
 */
public abstract class TestDataFactory {

    //Account creation
    public static Account createAccount() {
        Account account = new Account(
            Name ='Test Account');
        return account;
    }

    //Product2 creation
    public static Product2 createProduct2() {
        Product2 product = new Product2(
            Name='Test Product',
            IsActive=true);
        return product;
    }

    //PricebookEntry creation
    public static PricebookEntry createPriceBook(Product2 product2) {
        PricebookEntry priceBook = new PricebookEntry(
            Pricebook2Id= Test.getStandardPricebookId(),
            Product2Id = product2.Id,
            UnitPrice = 10,
            IsActive = true);
        return priceBook;
    }

    //Order creation
    public static Order createOrder(Account account, PricebookEntry priceBook) {
        Order order = new Order(
            Name='Order Test',
            AccountId=account.Id,
            Pricebook2Id=priceBook.Pricebook2Id,
            EffectiveDate=System.today(),
            Status='Draft');
        return order;
    }

    //OrderItem creation
    public static OrderItem createOrderItem(Order order, PricebookEntry priceBook) {
        OrderItem orderItem = new OrderItem(
            OrderId=order.Id, 
            PricebookEntryId=priceBook.Id,
            Quantity=1,
            UnitPrice=10);
        return orderItem;
    }

    //Account list creation
    public static List<Account> createListAccounts(Integer numberOfAccounts) {
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<numberOfAccounts; i++) {
            Account account = new Account(
                Name='Test Account '+i);
            accounts.add(account);
        }
        return accounts;
    }

    //Order list creation
    public static List<Order> createListOrders(Account account, PricebookEntry priceBook, Integer numbersOfOrderForAccount) {
        List<Order> orders = new List<Order>();
        for(Integer i=0; i<numbersOfOrderForAccount; i++){
            Order order = TestDataFactory.createOrder(account, priceBook);
            order.Name='Order Test List '+i;
            orders.add(order);
        }
        return orders;
    }

    //OrderItem list creation
    public static List<OrderItem> createListOrderItems(List<Order> orders, PricebookEntry priceBook) {
        List<OrderItem> orderItems = new List<OrderItem>();
        for (Order order : orders){
            OrderItem orderItem = TestDataFactory.createOrderItem(order, priceBook);
            orderItems.add(orderItem);
        }
        return orderItems;
    }

    //User creation
    public static User createUser(){
        Profile profile = [SELECT Id FROM Profile WHERE Name='Standard User'];
        Blob b = Crypto.generateAesKey(128);
        String h = EncodingUtil.convertToHex(b);
        String uId = h.substring(0, 8);
        User user = new User(
            Alias = uId, 
            Email=uId+'@testorg.com', 
            EmailEncodingKey='UTF-8', 
            LastName='UserTest', 
            LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', 
            ProfileId = profile.Id, 
            TimeZoneSidKey='Europe/Paris', 
            UserName=uId+'@testorg.com',
            IsActive=true);
        return user;
    }
}