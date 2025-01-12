## demo for Sync-ALTestCodeunit

## 1. Create a test codeunit as usual

# FIXME: Install-Module ATDD.TestScriptor -Force
Import-Module ./output/ATDD.TestScriptor/ATDD.TestScriptor.psd1 -Force

$Features = @()

$Features +=
Feature 'LookupValue UT Customer' {
    Scenario 1 'Check that label can be assigned to customer' {
        Given	'A label'
        Given	'A customer'
        When	'Assign label to customer'
        Then	'Customer has label field populated'
    }

    Scenario 2 'Check that label field table relation is validated for non-existing label on customer' {
        Given	'A non-existing label value'
        Given	'A customer record variable'
        When	'Assign non-existing label to customer'
        Then	'Non existing label error was thrown'
    }

    Scenario 3 'Check that label can be assigned on customer card' {
        Given	'A label'
        Given	'A customer card'
        When	'Assign label to customer card'
        Then	'Customer has label field populated'
    }
}

$Features | `
    ConvertTo-ALTestCodeunit `
    -CodeunitID 81000 `
    -CodeunitName 'LookupValue UT Customer' `
    -InitializeFunction `
    -GivenFunctionName "Create {0}" `
    -ThenFunctionName "Verify {0}" `
| Out-File -FilePath .\test_cu.al

## 2. Let's assume that new features/scenarios were added at a later time

$Features = @()

$Features +=
Feature 'LookupValue UT Customer' {
    Scenario 1 'Check that label can be assigned to customer' {
        Given	'A label'
        Given	'A customer'
        When	'Assign label to customer'
        Then	'Customer has label field populated'
    }

    Scenario 2 'Check that label field table relation is validated for non-existing label on customer' {
        Given	'A non-existing label value'
        Given	'A customer record variable'
        When	'Assign non-existing label to customer'
        Then	'Non existing label error was thrown'
    }

    Scenario 3 'Check that label can be assigned on customer card' {
        Given	'A label'
        Given	'A customer card'
        When	'Assign label to customer card'
        Then	'Customer has label field populated'
    }

    Scenario 4 'Check that label can be assigned on customer card2' {
        Given	'A label2'
        Given	'A customer card2'
        When	'Assign label to customer card2'
        Then	'Customer has label field populated2'
    }
}

$Features +=
Feature 'Another Feature' {
    Scenario 1 'Oink' {
        Given Boink
        When Kloink
        Then Zoink
    }
}

$Features | `
    Sync-ALTestCodeunit `
    -CodeunitPath ".\test_cu.al" `
    -GivenFunctionName "Create {0}" `
    -ThenFunctionName "Verify {0}" `
    -Verbose `
    #| Out-File -FilePath .\test_cu.al
