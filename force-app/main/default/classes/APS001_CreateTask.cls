/**
 * Class to schedule APB001_CreateTask
 * use this class with this method: System.schedule()
 * 
 * @author JohnDWorld
 */
global class APS001_CreateTask implements Schedulable {
    global void execute(SchedulableContext ctx) {
        Database.executeBatch(new APB001_CreateTask());
    }
}