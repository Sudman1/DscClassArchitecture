<#
    .SYNOPSIS
        The ApplicationProperty DSC resource manages ...

...
#>

[DscResource()]
class ApplicationProperty : DscResourceBase
{
    # Properties should be the only members required in this class, but we include the methods below as well for now due to HQRM tests.

    [DscProperty(Key)]
    [System.String]
    $Prop1

    [DscProperty(Key)]
    [System.String]
    $Prop2

    [DscProperty(Mandatory)]
    [System.Int32]
    $Prop3

    [DscProperty()]
    [System.Boolean]
    $Prop4

    [DscProperty()]
    [Ensure]
    $Ensure = "Present"

    # In theory, Get(), Set(), and Test() are unnecessary here, since they are inherited, but the HQRM tests require them to exist for now.

    [ApplicationProperty] Get()
    {
        return ([DscResourceBase]$this).Get()
    }

    [Void] Set()
    {
        ([DscResourceBase]$this).Set()
    }
    
    [Boolean] Test()
    {
        return ([DscResourceBase]$this).Test()
    }
}