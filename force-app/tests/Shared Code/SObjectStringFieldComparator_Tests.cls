@isTest
/**
 * @description: Tests the SObjectStringFieldComparator class used in list sorting recipes.
 */
public class SObjectStringFieldComparator_Tests {
    private final static Account a1 = new Account(ShippingCountry = 'A');
    private final static Account a2 = new Account(ShippingCountry = 'A');
    private final static Account a3 = new Account(ShippingCountry = 'B');
    private final static Account a4 = new Account(ShippingCountry = 'C');

    @isTest
    private static void sort_works() {
        List<Account> accounts = new List<Account>{ a4, a2, a3, a1 };

        ListUtils.sort(
            accounts,
            new SObjectStringFieldComparator('ShippingCountry')
        );

        List<Account> expected = new List<Account>{ a2, a1, a3, a4 };
        System.assertEquals(accounts, expected);
    }

    @isTest
    private static void sort_fails_when_incompatible_types() {
        String someString;
        List<Object> objects = new List<Object>{ a1, someString };

        try {
            ListUtils.sort(
                objects,
                new SObjectStringFieldComparator('ShippingCountry')
            );
            System.assert(false, 'Expected ListUtils.CompareException');
        } catch (ListUtils.CompareException e) {
            System.assert(true);
        }
    }
}
