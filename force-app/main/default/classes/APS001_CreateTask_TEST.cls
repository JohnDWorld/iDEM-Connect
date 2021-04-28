/**
 * Class test the schedule of APS001_CreateTask
 * 
 * @author JohnDWorld
 */
@isTest
private class APS001_CreateTask_TEST {
    static testMethod void APS001_CreateTask_TEST(){
        Test.startTest();
        System.schedule('APS001_CreateTask', '0 0 7 ? * 2#1', new APS001_CreateTask());
        Test.stopTest();
      }
}