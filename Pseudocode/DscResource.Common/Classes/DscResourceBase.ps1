<#
    .SYNOPSIS
        A class with methods that are equal for all class-based resources.

    .DESCRIPTION
        A class with methods that are equal for all class-based resources.

    .NOTES
        This class should not contain any DSC properties.
#>

class ResourceBase
{
    # Hidden property for holding localization strings
    hidden [System.Collections.Hashtable] $localizedData = @{}

    # Default constructor
    ResourceBase()
    {
        $this.localizedData = Get-LocalizedDataRecursive -ClassName ($this | Get-ClassName -Recurse)
    }

    [ResourceBase] Get()
    {
        # Uses $this.GetType() to determine the resource name to call the Get-* function something like:
        $resourceName = $this.GetType().Name

        # Converts properties to correct type if needed using ConvertFrom-StringParameter, basically converting PSBoundParameters
        $modifiedProperties = ConvertFrom-StringParameter -Parameter $PSBoundParameters -DestinationFunctionName "Get-$ResourceName"

        # Call the Get-* command to get a hashtable back
        $getCurrentStateResult = Invoke-Expression "Get-$($ResourceName) @modifiedProperties"

        # Create an object of the correct type and populate the fields
        $dscResourceObject = [System.Activator]::CreateInstance($this.GetType())

        foreach ($propertyName in $this.PSObject.Properties.Name)
        {
            if ($propertyName -in @($getCurrentStateResult.Keys))
            {
                $dscResourceObject.$propertyName = $getCurrentStateResult.$propertyName
            }
        }

        # return the object
        return $dscResourceObject
    }

    [void] Set() {
        # Uses $this.GetType() to determine the resource name to call the Get-* function something like:
        $resourceName = $this.GetType().Name

        # Converts properties to correct type if needed using ConvertFrom-StringParameter, basically converting PSBoundParameters
        $modifiedProperties = ConvertFrom-StringParameter -Parameter $PSBoundParameters -DestinationFunctionName "Set-$ResourceName"

        # possibly determine if changes need to be made before setting?

        # Call the Set-* command to set values
        Invoke-Expression "Set-$($ResourceName) @modifiedProperties"
    }

    [bool] Test() {
        # Convert this object to a hashtable
        $desiredState = ConvertTo-HashtableFromObject -InputObject $this

        # Get the actual state of the system
        $actual = $this.Get()

        # Convert the actual state to a hashtable
        $actualState = ConvertTo-HashtableFromObject -InputObject $actual
        
        # Do some magic to determine which properties are key vales, which are mandatory and which are not used in determining state compliance

        # Compare the two states
        $result = Test-DscParameterState -CurrentValues $actualState -DesiredValues $desiredState

        # return the result
        return $result
    }
}
