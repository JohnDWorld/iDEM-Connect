/**
 * 
 * Class test the batch with some account without Task
 * 
 * @author JohnDWorld
 */
@isTest
private class APB001_CreateTask_TEST {
    //Setup the Data for the test
    @TestSetup
    static void setup(){
        User user = TestDataFactory.createUser();
        insert user;

        List<Account> accounts = TestDataFactory.createListAccounts(10);
        for(Account account: accounts){
            account.OwnerId = user.Id;
        }
        insert accounts;
    }

    //Unit Test of APB001_CreateTask Class
    @isTest static void APB001_CreateTask_TEST() {
        Test.startTest();
        APB001_CreateTask createTaskBatch = new APB001_CreateTask();
        Id batchId = Database.executeBatch(createTaskBatch);
        Test.stopTest();

        //10 accounts were create without order or task with subject='call'
        //so we wait 10 tasks created
        List<Task> tasks = [SELECT Id FROM Task WHERE Subject='Call' AND OwnerId IN (SELECT Id FROM User WHERE isActive=true)];
        System.assertEquals(10, tasks.size());
    }
}