/**
 * TriggerFactory.cls
 *
 * @description Factory class for creating and executing TriggerHandler instances as part of the Factory pattern
 *
 * @author Presence PG
 */
public class TriggerFactory {
    private static final String INVALID_TYPE_MSG = 'Invalid class type';
    private static final String INVALID_INSTANCE_MSG = 'Invalid instance, must be of type TriggerHandler';

    // HandlerException to allow throwing
    public class HandlerException extends Exception {}

    /**
     * @description Create and execute an instance of a TriggerHandler.
     *
     * @param handlerType - System.Type of type TriggerHandler
     */
    public static void createAndExecuteHandler( System.Type handlerType) {
        TriggerHandler handler = create( handlerType);
        execute( handler);
    }

    /**
     * @description Create an instance of a TriggerHandler based on a valid TriggerHandler type.
     *
     * @param handlerType - System.Type of type TriggerHandler
     *
     * @return A new TriggerHandler
     */
    private static TriggerHandler create( System.Type handlerType) {
        System.Type classType = handlerType;
        if ( classType == null) {
            throw new HandlerException( TriggerFactory.INVALID_TYPE_MSG);
        }

        Object handler = classType.newInstance();
        if ( !( handler instanceOf TriggerHandler)) {
            throw new HandlerException( TriggerFactory.INVALID_INSTANCE_MSG);
        }
        return ( TriggerHandler)handler;
    }

    /**
     * Execute an instance of a TriggerHandler based on a valid TriggerHandler type.
     *
     * @param handler - a valid TriggerHandler instance
     *
     */
    private static void execute( TriggerHandler handler) {
        // before context
        if ( Trigger.isBefore) {
            if ( Trigger.isInsert) {
                handler.beforeInsert( Trigger.new);
            } else if ( Trigger.isUpdate) {
                handler.beforeUpdate( Trigger.newMap, Trigger.oldMap);
            } else if ( Trigger.isDelete) {
                handler.beforeDelete( Trigger.newMap, Trigger.oldMap);
            }

            // after context
        } else if ( Trigger.isAfter) {
            if ( Trigger.isInsert) {
                handler.afterInsert( Trigger.newMap);
            } else if ( Trigger.isUpdate) {
                handler.afterUpdate( Trigger.newMap, Trigger.oldMap);
            } else if ( Trigger.isDelete) {
                handler.afterDelete( Trigger.newMap, Trigger.oldMap);
            } else if ( Trigger.isUndelete) {
                handler.afterUnDelete( Trigger.newMap, Trigger.oldMap);
            }
        }
    }
}