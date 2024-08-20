$policyDefinition = New-AzPolicyDefinition -Name "enforce-vm-naming-convention" -DisplayName "Enforce VM Naming Convention" -Policy 'vm-naming-convention.json'

$scope = "/subscriptions/fa366244-df54-48f8-83c2-e1739ef3c4f1/resourceGroups/rg-tailwind"

New-AzPolicyAssignment -Name "enforce-vm-naming-convention-assignment" -DisplayName "Enforce VM Naming Convention Assignment" -PolicyDefinition $policyDefinition -Scope $scope
